# frozen_string_literal: true

RSpec.describe PloomesClient::User::List do
  describe 'run' do
    let(:ploomes_response) { load_fixture_json_symbolized('user/list/response_with_result.json') }
    let(:id) { 123 }

    before do
      PloomesClient::Configuration.configure do |config|
        config.base_uri = 'localhost:3000'
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
        to: "localhost:3000/Users?$filter=Id+eq+#{id}",
        response_body: ploomes_response
      )
    end

    describe 'filtering by path_params explicity' do
      it 'filters by path params id', :aggregate_failures do
        result = described_class.(path_params: { id: id })

        expect(result).to have_succeed_with(:ok, :successful)

        first_contact = result.value[:value].first

        expect(first_contact[:Name]).to eq('Bruno Alberto')
        expect(first_contact[:Email]).to eq('bruno.alberto@test.com.br')
      end
    end

    describe 'filtering by id directly' do
      it 'filters id', :aggregate_failures do
        result = described_class.(id: id)

        expect(result).to have_succeed_with(:ok, :successful)

        first_contact = result.value[:value].first

        expect(first_contact[:Name]).to eq('Bruno Alberto')
        expect(first_contact[:Email]).to eq('bruno.alberto@test.com.br')
      end
    end
  end
end
