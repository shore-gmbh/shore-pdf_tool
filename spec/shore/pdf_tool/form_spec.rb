RSpec.describe Shore::PdfTool::Form do
  let(:pdf_form_file) { File.open('spec/test_files/pdf-form.pdf') }
  let(:pdf_plain_file) { File.open('spec/test_files/pdf-plain.pdf') }
  let(:hash) { { first_name: 'Bob' } }
  let(:output) { '/tmp/test_output.pdf' }
  let(:file) { pdf_form_file }
  subject { described_class.new(file) }

  context '.fill' do
    after do
      FileUtils.rm(output) if File.exist?(output)
    end

    it 'fills pdf form' do
      expect(subject.field('first_name').value).to be_nil
      subject.fill(output, hash)
      expect(subject.field('first_name', output).value).to eq('Bob')
    end
  end

  context '.field_names' do
    context 'with pdf form file' do
      it 'returns fields' do
        expect(subject.field_names).not_to be_empty
      end
    end

    context 'with plain pdf file' do
      let(:file) { pdf_plain_file }

      it 'returns fields' do
        expect(subject.field_names).to be_empty
      end
    end
  end

  context '.fields' do
    context 'with pdf form file' do
      it 'returns empty fields' do
        expect(subject.fields).to_not be_empty
      end
    end

    context 'with plain pdf file' do
      let(:file) { pdf_plain_file }

      it 'returns empty fields' do
        expect(subject.fields).to be_empty
      end
    end
  end

  context '.field' do
    context 'with pdf form file' do
      it 'returns empty fields' do
        expect(subject.field(:first_name)).to be_nil
      end
    end

    context 'with plain pdf file' do
      let(:file) { pdf_plain_file }

      it 'returns error' do
        expect { subject.field(:first_name) }
          .to raise_error(Shore::PdfTool::InvalidFileFormat)
      end
    end
  end

  context '.valid?' do
    context 'with pdf form file' do
      it 'is valid' do
        expect(subject.valid?).to be_truthy
      end
    end

    context 'with plain pdf file' do
      let(:file) { pdf_plain_file }

      it 'is not valid' do
        expect(subject.valid?).to be_falsey
      end
    end
  end
end
