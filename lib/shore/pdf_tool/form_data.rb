module Shore
  module PdfTool
    class FormData # :nodoc:
      attr_reader :hash, :format_option

      class UnsupportedFormFormat < StandardError
      end

      def initialize(hash, format_option = :fdf)
        @hash = hash
        @format_option = format_option
      end

      def as_format(option = :fdf)
        form_data = case option
                    when :fdf then PdfForms::Fdf.new(hash)
                    when :xfdf then PdfForms::XFdf.new(hash)
                    else fail UnsupportedFormFormat
                    end
        form_data.to_pdf_data
      end

      def to_file(output, format = :fdf)
        form_data = case format
                    when :fdf then PdfForms::Fdf.new(hash)
                    when :xfdf then PdfForms::XFdf.new(hash)
                    else fail UnsupportedFormFormat
                    end
        form_data.save_to(output)
      end
    end
  end
end
