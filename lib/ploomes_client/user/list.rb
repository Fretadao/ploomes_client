# frozen_string_literal: true

module PloomesClient
  module User
    class List < PloomesClient::Base
      option :id, default: -> {}

      private

      def make_request
        self.class.get(formatted_path, headers: headers)
      end

      def path_template
        '/Users?$filter=Id+eq+%<id>s'
      end

      def path_params
        id.present? ? { id: id } : super
      end
    end
  end
end
