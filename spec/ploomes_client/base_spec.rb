# frozen_string_literal: true

RSpec.describe PloomesClient::Base do
  describe '.config' do
    it { expect(described_class.config).to eq(PloomesClient::Configuration.config) }
  end

  describe 'headers' do
    subject(:client) do
      Class.new(described_class) do
        base_uri 'localhost:3000'

        private

        def make_request
          self.class.get(formatted_path, headers: headers)
        end

        def path_template
          '/test'
        end
      end
    end

    before do
      PloomesClient::Configuration.configure do |config|
        config.user_key = 'user-key-123'
      end

      stub_get(
        {
          headers: {
            'User-Key' => 'user-key-123',
            'Content-Type' => 'application/json',
            'odata.metadata' => 'minimal'
          }
        },
        to: 'localhost:3000/test'
      )
    end

    it { expect(client.()).to have_succeed_with(:ok, :successful) }
  end
end
