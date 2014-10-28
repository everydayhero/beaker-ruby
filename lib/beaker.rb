require 'beaker/version'
require 'json'

module Beaker
  attr_accessor :base_url
  module_function :base_url, :base_url=

  class Session
    def initialize user_id
      @user_id = user_id
      @base_url = Beaker.base_url
    end

    def participate experiment_name, default: nil
      group = participate_request(experiment_name) || default

      if block_given?
        yield group
      else
        group
      end
    end

    private

    attr_reader :user_id, :base_url

    def participate_request experiment_name
      uri = participate_uri experiment_name
      res = Net::HTTP.get_response uri

      group_from res.body if res.is_a? Net::HTTPSuccess
    rescue
      nil
    end

    def group_from raw_body
      JSON.parse(raw_body)['alternative']
    end

    def participate_uri experiment_name
      URI base_url + "/experiments/participate/#{experiment_name}/#{user_id}"
    end
  end
end
