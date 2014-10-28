require 'spec_helper'

describe Beaker::Session do
  before { Beaker.base_url = beaker_base_url }

  describe '#participate' do
    let(:user_id) { 123 }
    let(:ab_test) { :sign_up }

    subject { Beaker::Session.new user_id }

    context 'When beaker server successfully responds' do
      before do
        stub_request(:get, experiment_url(ab_test, user_id))
          .to_return body: response
      end

      let(:response) { { alternative: 'green' }.to_json }

      context 'without default specified' do
        it { expect(subject.participate(ab_test)).to eq 'green' }

        it {
          expect { |b| subject.participate(ab_test, &b) }
            .to yield_with_args 'green'
        }
      end

      context 'with default specified' do
        it { expect(subject.participate(ab_test, default: 'red')).to eq 'green' }

        it {
          expect { |b| subject.participate(ab_test, default: 'red', &b) }
            .to yield_with_args 'green'
        }
      end
    end

    context 'When beaker server responds invalid payload' do
      before do
        stub_request(:get, experiment_url(ab_test, user_id))
          .to_return body: response
      end

      let(:response) { { bad_body: 'green' }.to_json }

      context 'without default specified' do
        it { expect(subject.participate(ab_test)).to be_nil }

        it {
          expect { |b| subject.participate(ab_test, &b) }
            .to yield_with_args nil
        }
      end

      context 'with default specified' do
        it { expect(subject.participate(ab_test, default: 'red')).to eq 'red' }

        it {
          expect { |b| subject.participate(ab_test, default: 'red', &b) }
            .to yield_with_args 'red'
        }
      end
    end

    context 'When beaker server responds error status' do
      before do
        stub_request(:get, experiment_url(ab_test, user_id))
          .to_return status: [500, 'Internal Server Error']
      end

      context 'without default specified' do
        it { expect(subject.participate(ab_test)).to be_nil }

        it {
          expect { |b| subject.participate(ab_test, &b) }
            .to yield_with_args nil
        }
      end

      context 'with default specified' do
        it { expect(subject.participate(ab_test, default: 'red')).to eq 'red' }

        it {
          expect { |b| subject.participate(ab_test, default: 'red', &b) }
            .to yield_with_args 'red'
        }
      end
    end

    context 'When connecting to beaker server times out' do
      before do
        stub_request(:get, experiment_url(ab_test, user_id)).to_timeout
      end

      context 'without default specified' do
        it { expect(subject.participate(ab_test)).to be_nil }

        it {
          expect { |b| subject.participate(ab_test, &b) }
            .to yield_with_args nil
        }
      end

      context 'with default specified' do
        it { expect(subject.participate(ab_test, default: 'red')).to eq 'red' }

        it {
          expect { |b| subject.participate(ab_test, default: 'red', &b) }
            .to yield_with_args 'red'
        }
      end
    end
  end
end
