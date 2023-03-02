# frozen_string_literal: true

RSpec.describe PloomesClient do
  describe 'versioning' do
    it 'has a version number' do
      expect(PloomesClient::VERSION).not_to be_nil
    end
  end
end
