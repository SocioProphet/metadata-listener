# frozen_string_literal: true

RSpec.describe MetadataListener::FitsService do
  subject(:service) { described_class.call(path) }

  let(:path) { fixture_path.join('1.pdf').to_s }

  context 'when successfull' do
    it { is_expected.to be_a(Hash) }
  end

  context 'with a pdf' do
    it 'extracts metadata from the file' do
      expect(service.dig('fits', 'identification', 'identity', 'mimetype')).to eq('application/pdf')
    end
  end

  context 'with a Word document' do
    let(:path) { fixture_path.join('1.docx').to_s }

    it 'extracts metadata from the file' do
      expect(service.dig('fits', 'identification', 'identity', 'mimetype')).to eq(
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
      )
    end
  end

  context 'with a PowerPoint document' do
    let(:path) { fixture_path.join('1.pptx').to_s }

    it 'extracts metadata from the file' do
      expect(
        service.dig('fits', 'identification', 'identity').map { |identity| identity.dig('mimetype') }
      ).to include(
        'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      )
    end
  end

  context 'when the Fits path does not exist' do
    before { ENV['FITS_PATH'] = '/usr/share/fits/fits.broken' }

    after { ENV['FITS_PATH'] = '/usr/share/fits/fits.sh' }

    it 'raises an error' do
      expect { service }.to raise_error(Errno::ENOENT, 'No such file or directory - /usr/share/fits/fits.broken')
    end
  end

  context 'when the call to Fits is not a success' do
    before { ENV['FITS_PATH'] = fixture_path.join('error_command.sh').to_s }

    after { ENV['FITS_PATH'] = '/usr/share/fits/fits.sh' }

    it 'raises a FitsError' do
      expect { service }.to raise_error(MetadataListener::FitsError, "This command failed\n")
    end
  end

  context 'when the file path does not exist' do
    let(:path) { '/not/here' }

    it { is_expected.to be_empty }
  end
end
