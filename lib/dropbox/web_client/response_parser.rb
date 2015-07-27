module Dropbox
  module WebClient

    class ResponseParser
      attr_reader :response_text

      def initialize(response_text, response_type = :json, error_type = :json)
        @response_text = response_text

        @error_type = error_type
        @response_type = response_type
      end

      def error?
        @response_text.start_with? "err:"
      end

      def error_data
        return unless error?

        error_text = @response_text.split(":", 2)[1]

        self.class.send("parse_#{@error_type.to_s}", error_text)
      end

      def response_data
        if error?
          raise ResponseError, error_data
        else
          parse_response
        end
      end

      private

      def parse_response
        self.class.send("parse_#{@response_type.to_s}", @response_text)
      rescue NoMethodError
        raise "Unsupported response format"
      end

      def self.parse_json(text)
        JSON.parse(text)
      end

      def self.parse_text(text)
        text
      end

      def self.parse_html(text)
        doc = Nokogiri::HTML(text)
        result = {}

        members = doc.css("#sf-members .bs-row")
        if members.size > 0
          result[:members] = members.map do |member|
            {
              :email => member.css("a[href^=mailto]").text,
              :name => (member.css(".sf-tooltip-name").children[0].text.strip rescue nil),
              :access => (member.css(".sf-can-edit-text").text rescue nil),
              :joined => member.css("> .sf-name > em").text == "(pending)" ? "Still waiting" : "Joined"
            }
          end
        end

        # Parse ns_id
        result[:ns_id] = doc.css("[data-ns-id]").first.attr("data-ns-id") rescue nil

        result
      end

      #
      # Following parsers are for specific Dropbox actions
      #

      # Parses a `share_options` response
      def self.parse_share_options(text)
        json = parse_json(text)
        format, html, el = json["actions"].first
        parse_html(html)
      end

    end

  end
end
