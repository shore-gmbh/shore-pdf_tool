RSpec.describe Shore::PdfTool::Form do
  let(:valid_file) { File.open('spec/test_files/pdf-form.pdf') }
  let(:invalid_file) { File.open('spec/test_files/pdf-plain.pdf') }
  let(:hash) { { first_name: 'Bob' } }
  let(:output) { '/tmp/test_output.pdf' }
  let(:file) { valid_file }
  subject { described_class.new(file) }

  context '.fill' do
    after do
      FileUtils.rm(output) if File.exist?(output)
    end

    it 'fills pdf form' do
      expect(subject.field('first_name').value).to be_nil
      subject.fill(output, hash)
      expect(described_class.new(output).field('first_name').value).to eq('Bob')
    end
  end

  context '.field_names' do
    it 'returns fields' do
      expect(subject.field_names).not_to be_empty
    end
  end

  context '.fields' do
    it 'returns empty fields' do
      expect(subject.fields).to_not be_empty
    end
  end

  context '.field' do
    it 'returns empty fields' do
      expect(subject.field(:first_name)).to be_nil
    end
  end

  context '.valid?' do
    it 'is valid' do
      expect(subject.valid?).to be_truthy
    end
  end
end
