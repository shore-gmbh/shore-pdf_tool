module Shore
  module PdfTool
    class FormData # :nodoc:
      attr_reader :form_data

      class UnsupportedFormFormat < StandardError
      end

      def initialize(hash, format = :fdf)
        @form_data = form_data_object(hash, format)
      end

      def as_format
        form_data.to_pdf_data
      end

      def to_file(output)
        form_data.save_to(output)
      end

      private

      def form_data_object(hash, format)
        case format
        when :fdf then PdfForms::Fdf.new(hash)
        when :xfdf then PdfForms::XFdf.new(hash)
        else fail UnsupportedFormFormat
        end
      end
    end
  end
end
