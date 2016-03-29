# Shore::PdfTool

Shore PdfTool for manipulating pdf files.


## Installation

Install [pdftk-server](https://www.pdflabs.com/tools/pdftk-server/). If you are on ElCapitan use [this one](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg).

Add this line to your application's Gemfile:

```ruby
gem 'shore-pdf_tool', github: 'shore-gmbh/shore-pdf_tool'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install shore-pdf_tool


## Usage

Create an `config/initializers/shore-pdf_tool.rb` in your application and require [`pdftk-heroku`](https://github.com/ChromeCapital/pdftk-heroku). This will add pdftk binary and library file for Heroku Cedar 14 stack.

    require 'pdftk-heroku'

Create pdf file from template and pre-fill form fields with data

    template_pdf = '/path/to/file.pdf'
    output = '/path/to/output.pdf'
    hash = { first_name: 'Bob' }
    pdf_form = Shore::PdfTool::Form.new(template_pdf)
    pdf_form.fill(output, hash)

Get pdf template file form fields

    pdf_form = Shore::PdfTool::Form.new(template_pdf)
    pdf_form.fields

Check specified template file has valid pdf form

    pdf_form = Shore::PdfTool::Form.new(template_pdf)
    pdf_form.valid?


## Development

Install dependencies

    $ bin/setup

Run tests

    $ bin/rspec

To generate SimpleCov stats by run

    $ COVERAGE=true bin/rspec

For REPL you can use

    $ bin/console

Install the gem locally

    $ bin/rake install

Release your changes: update version number in version.rb file and run

    $ gem_push=no bin/rake release


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shore-gmbh/shore-pdf_tool. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

