RSpec.describe Shore::PdfTool::Form do
  let(:valid_file) { File.open('spec/test_files/pdf-form.pdf') }
  let(:invalid_file) { File.open('spec/test_files/pdf-plain.pdf') }
  let(:hash) { { first_name: 'Bob' } }
  let(:output) { '/tmp/test_output.pdf' }
  subject { described_class.new(file) }

  context 'with valid file' do
    let(:file) { valid_file }

    it 'is valid' do
      expect(subject.valid?).to be_truthy
    end

    it 'returns fields' do
      expect(subject.fields(file)).not_to be_empty
    end

    after do
      FileUtils.rm(output) if File.exist?(output)
    end

    it 'fills pdf form' do
      expect(subject.field('first_name').value).to be_nil
      subject.fill(output, hash)
      expect(described_class.new(output).field('first_name').value).to eq('Bob')
    end
  end

  context 'with invalid file' do
    let(:file) { invalid_file }

    it 'is invalid' do
      expect(subject.valid?).to be_falsey
    end

    it 'returns empty fields' do
      expect(subject.fields(file)).to be_empty
    end
  end
end
