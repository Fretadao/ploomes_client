# frozen_string_literal: true

module PloomesClient
  module Deal
    class List < PloomesClient::Base
      option :id, default: -> {}

      private

      def make_request
        self.class.get(formatted_path, headers: headers)
      end

      def path_template
        '/Deals?$expand=Attachments,OtherProperties&$filter=Id+eq+%<id>s'
      end

      def path_params
        id.present? ? { id: id } : super
      end
    end
  end
end
