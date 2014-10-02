require "beaker/version"

module Beaker
  extend self

  attr_accessor :base_url

  class Session
    def initialize user_id
      @user_id = user_id
      @base_url = Beaker.base_url
    end

    def participate experiment_name
      group = participate_request experiment_name
      yield group if block_given?

      group
    end

    private

    attr_reader :user_id, :base_url

    def participate_request experiment_name
      uri = participate_uri experiment_name
      res = Net::HTTP.get_response uri

      res.body if res.is_a?(Net::HTTPSuccess)
    end

    def participate_uri experiment_name
      URI base_url + "/participate/#{experiment_name}/#{user_id}"
    end
  end
end
