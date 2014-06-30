#load File.expand_path '~/.irbrc'

######################################################################
# It's important to load awesome_print first then hirb
######################################################################
# begin
#   require 'awesome_print'
#   Pry.config.print = proc { |output, value| output.puts value.ai }
# rescue LoadError
#   puts "no awesome_print :("
# end

# If you would like to use Pry's pager with awesome_print a slight modification to the above is needed:
begin
  require 'awesome_print'
  # Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
  AwesomePrint.pry!
rescue LoadError
  puts "no awesome_print :("
end

# begin
#   require 'hirb'
# rescue LoadError
#   # Missing goodies, bummer
# end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        # Old line
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)

        # Changed by me
        # formatted_output = Hirb::View.formatter.format_output(value)
        # inspect_mode = false
        # Hirb::View.pager.page(formatted_output, inspect_mode) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end
end


if defined? Rails
  # http://www.hackhowtofaq.com/blog/how-to-enable-rubyrails-irb-console-autocomplete-history/
  # Get all Models in [TAB]
  Rails.application.eager_load!
end

if defined? Hirb
  # Gives me more space to visualize horizontally
  Hirb.enable
  Hirb::View.config[:width] = 1200
end

module DevTools
  # include DevTools in interactive console when needed

  def redirect_stdout_to_file
    # $old_stdout = $stdout.clone
    # $stdout.reopen("/tmp/stdout_dump")
    # $stdout.sync = true
    $old_print2 = Pry.config.print
    Pry.config.print = proc { |output, value| File.write('/tmp/stdout_dump', value) }
  end

  def cancel_stdout_redirection
    # $stdout.reopen($old_stdout)
    # $stdout.sync = true
    Pry.config.print = $old_print2
  end

  def wrap_stdout
    redirect_stdout_to_file
    yield
    cancel_stdout_redirection
    system 'less -S /tmp/stdout_dump'
  end

  def page(active_record_object)
    formatted_output = Hirb::View.formatter.format_output(active_record_object)
    inspect_mode = false
    Hirb::View.pager.page(formatted_output,inspect_mode)
  end
  alias :t :page

  def export(arr)
    require 'axlsx'
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "db-export") do |sheet|
      headers = arr.to_a.first.attributes.keys
      sheet.add_row headers
      arr.each do |ar_object|
        sheet.add_row ar_object.attributes.values_at(*headers)
      end
    end
    p.serialize(File.expand_path("~/db_export/#{Time.now.to_i}_export.xlsx"))
  end
  alias :e :export

  def export2(arr)
    # usage
    # result = Report.where(serial_number: 'E70768M2N324309').usage(3.months.ago).map(&:attributes)
    # result << Report.where(serial_number: 'other').usage(3.months.ago).map(&:attributes)
    # export2 result.flatten
    require 'axlsx'
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "db-export") do |sheet|
      headers = arr.first.keys
      sheet.add_row headers
      arr.each do |elem|
        sheet.add_row elem.values_at(*headers)
      end
    end
    p.serialize(File.expand_path("~/db_export/#{Time.now.to_i}_export.xlsx"))
  end
  alias :ee :export
end

include DevTools
