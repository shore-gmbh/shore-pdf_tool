RSpec.describe Shore::PdfTool::FormData do
  let(:hash) { { first_name: 'Bob' } }
  let(:fdf) { PdfForms::Fdf.new(hash).to_pdf_data }
  let(:xfdf) { PdfForms::XFdf.new(hash).to_pdf_data }
  let(:output) { '/tmp/output.fdf' }
  subject { described_class.new(hash, format) }

  context '.as_format' do
    context ':fdf' do
      let(:format) { :fdf }

      it 'works' do
        expect(subject.as_format).to eq(fdf)
      end
    end

    context ':xfdf' do
      let(:format) { :xfdf }

      it 'works' do
        expect(subject.as_format).to eq(xfdf)
      end
    end

    context 'with invalid format' do
      let(:format) { :pdf }

      it 'raise error' do
        expect { subject.as_format }
          .to raise_error(Shore::PdfTool::FormData::UnsupportedFormFormat)
      end
    end
  end

  context '.to_file' do
    after do
      FileUtils.rm(output) if File.exist?(output)
    end

    context 'with :fdf format' do
      let(:format) { :fdf }

      it 'created a form file' do
        subject.to_file(output)
        expect(File.file?(output)).to be_truthy
      end
    end

    context 'with :xfdf format' do
      let(:format) { :xfdf }

      it 'created a form file' do
        subject.to_file(output)
        expect(File.file?(output)).to be_truthy
      end
    end

    context 'with invalid format' do
      let(:format) { :pdf }

      it 'created a form file' do
        expect { subject.to_file(output) }
          .to raise_error(Shore::PdfTool::FormData::UnsupportedFormFormat)
      end
    end
  end
end
