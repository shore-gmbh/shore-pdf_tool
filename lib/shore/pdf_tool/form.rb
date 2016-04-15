require 'pdf-forms'

module Shore
  module PdfTool
    class Form # :nodoc:
      attr_reader :pdf_form, :template

      def initialize(template, options = {})
        @template = template
        default_options = {
          utf8_fields: true,
          data_format: 'Fdf'
        }
        config = default_options.merge(options)
        @pdf_form = PdfForms.new(pdftk_binary, config)
      end

      def fill(output, hash)
        pdf_form.fill_form(template, output, hash)
      end

      def field_names(file = nil)
        file_name = file || template
        pdf_form.get_field_names(file_name)
      end

      def fields(file = nil)
        file_name = file || template
        pdf_form.get_fields(file_name)
      end

      def field(field_name, file = nil)
        file_name = file || template
        pdf = pdf_form.read(file_name)
        fail(InvalidFileFormat, 'No forms found') unless valid?
        pdf.field(field_name)
      end

      def valid?(file = nil)
        pdf_form.get_field_names(file || template).any?
      end

      private

      # Require pdftk-heroku to include pdftk binary into PATH
      # Install locally from https://www.pdflabs.com/tools/pdftk-server/
      def pdftk_binary
        'pdftk'
      end
    end
  end
end
