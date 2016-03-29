RSpec.describe Shore::PdfTool::FormData do
  let(:hash) { { first_name: 'Bob' } }
  let(:fdf) { PdfForms::Fdf.new(hash).to_pdf_data }
  let(:xfdf) { PdfForms::XFdf.new(hash).to_pdf_data }
  let(:output) { '/tmp/output.fdf' }
  subject { described_class.new(hash, options) }

  context '.as_format' do
    context ':fdf' do
      let(:options) { :fdf }

      it 'works' do
        expect(subject.as_format(options)).to eq(fdf)
      end
    end

    context ':xfdf' do
      let(:options) { :xfdf }

      it 'works' do
        expect(subject.as_format(options)).to eq(xfdf)
      end
    end

    context 'with invalid format' do
      let(:options) { :pdf }

      it 'raise error' do
        expect { subject.as_format(options) }
          .to raise_error(Shore::PdfTool::FormData::UnsupportedFormFormat)
      end
    end
  end

  context '.to_file' do
    after do
      FileUtils.rm(output) if File.exist?(output)
    end

    context 'with :fdf format' do
      let(:options) { :fdf }

      it 'created a form file' do
        subject.to_file(output, options)
        expect(File.file?(output)).to be_truthy
      end
    end

    context 'with :xfdf format' do
      let(:options) { :xfdf }

      it 'created a form file' do
        subject.to_file(output, options)
        expect(File.file?(output)).to be_truthy
      end
    end

    context 'with invalid format' do
      let(:options) { :pdf }

      it 'created a form file' do
        expect { subject.to_file(output, options) }
          .to raise_error(Shore::PdfTool::FormData::UnsupportedFormFormat)
      end
    end
  end
end
