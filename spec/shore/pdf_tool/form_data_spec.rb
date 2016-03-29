RSpec.describe Shore::PdfTool::FormData do
  let(:hash) { { first_name: 'Bob' } }
  let(:fdf) { PdfForms::Fdf.new(hash).to_pdf_data }
  let(:xfdf) { PdfForms::XFdf.new(hash).to_pdf_data }
  subject { described_class.new(hash, options) }

  context 'with valid format' do
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
  end

  context 'with invalid format' do
    let(:options) { :pdf }

    it 'raise error' do
      expect { subject.as_format(options) }
        .to raise_error(Shore::PdfTool::FormData::UnsupportedFormFormat)
    end
  end
end
