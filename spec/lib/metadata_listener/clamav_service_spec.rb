# frozen_string_literal: true

RSpec.describe MetadataListener::ClamavService do
  subject(:service) { described_class.call(path) }

  context 'when a virus is not present' do
    let(:path) { fixture_path.join('1.pdf').to_s }

    it { is_expected.to be(false) }
  end

  context 'when a virus is present' do
    let(:path) { fixture_path.join('eicar_com.zip').to_s }

    it { is_expected.to be(true) }
  end

  context 'when the path does not exist' do
    let(:path) { 'nothere' }

    it { is_expected.to be(false) }
  end

  context 'when clamscan returns a different exit code' do
    let(:path) { fixture_path.join('1.pdf').to_s }
    let(:mock_command) { instance_spy('Clamby::Command') }

    before do
      allow(Clamby::Command).to receive(:new).and_return(mock_command)
      allow(mock_command).to receive(:run) { system('exit 2', out: File::NULL) }
    end

    it 'raises an error' do
      expect { service }.to raise_error(Clamby::ClamscanClientError)
    end
  end
end
