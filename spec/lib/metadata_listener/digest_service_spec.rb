# frozen_string_literal: true

RSpec.describe MetadataListener::DigestService do
    subject { described_class.call(path) }
  
    context 'when a file is present' do
      let(:path) { fixture_path.join('1.pdf').to_s }
  
      it { is_expected.to eq('ba3e31e370a2ec949dbb189218c409c62c91ee9d327c720f73fdc9c77484a0e5') }
    end
  end
  