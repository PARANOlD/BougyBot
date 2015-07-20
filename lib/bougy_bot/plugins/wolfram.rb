require 'cinch'
require 'nokogiri'
require 'open-uri'
require 'cinch/cooldown'
require 'wolfram-alpha'

# Bot Namespace
module BougyBot
  # Plugin namespace
  module Plugins
    # Wolfram Alpha plugin
    class Wolfram
      include Cinch::Plugin
      enforce_cooldown
      match(/((?:what|how|why|who|where) .+)\??/)

      def self.search(query)
        #          https://developer.wolframalpha.com/portal/signin.html
        api_id = BougyBot.options.wolfram_key

        wolfram = WolframAlpha::Client.new(api_id)

        response = wolfram.query(query)
        if result = (response['Value'] || response['Result'])
          result.subpods.map(&:plaintext).join('; ')
        else
          'Sorry, I\'ve no idea'
        end
      end

      def execute(m, query)
        m.reply "#{m.user.nick}: #{self.class.search(query)}"
      end
    end
  end
end
