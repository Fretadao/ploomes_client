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
        "/Deals?$expand=#{expanded_fields}&$filter=Id+eq+%<id>s"
      end

      def expanded_fields
        # if needed, there is the possibility of passing 'sub-selections' and 'sub-expansions'
        # in the api, as well as iterating inside their own responses. More below:
        # https://suporte.ploomes.com/pt-BR/articles/5452435-otimizacao-de-codigo-para-buscar-dados-em-varios-niveis-expands
        [
          'Attachments',
          'OtherProperties',
          'Pipeline',
          'Status',
          'LossReason',
          'Tags($expand=Tag)'
        ].join(',')
      end

      def path_params
        id.present? ? { id: id } : super
      end
    end
  end
end
