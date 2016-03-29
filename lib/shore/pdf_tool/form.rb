require 'pdf-forms'
# require 'pdftk-heroku'

module Shore
  module PdfTool
    class Form # :nodoc:
      attr_reader :pdftk, :template

      def initialize(template, options = {})
        @template = template
        default_options = {
          utf8_fields: true,
          data_format: 'Fdf'
        }
        config = default_options.merge(options)
        @pdftk = PdfForms.new('/usr/local/bin/pdftk', config)
      end

      def fill(output, hash)
        pdftk.fill_form(template, output, hash)
      end

      def field_names(file = nil)
        file_name = file || template
        pdftk.get_field_names(file_name)
      end

      def fields(file = nil)
        file_name = file || template
        pdftk.get_fields(file_name)
      end

      def field(field_name, file = nil)
        file_name = file || template
        pdf = pdftk.read(file_name)
        fail(InvalidFileFormat, 'No forms found') unless valid?
        pdf.field(field_name)
      end

      def valid?(file = nil)
        pdftk.get_field_names(file || template).any?
      end
    end
  end
end
