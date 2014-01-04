#load File.expand_path '~/.irbrc'

######################################################################
# It's important to load pry first then hirb
######################################################################
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }
rescue LoadError => err
  puts "no awesome_print :("
end

# If you would like to use Pry's pager with awesome_print a slight modification to the above is needed:
# begin
#   require 'awesome_print'
#   Pry.config.print = proc { |output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai}", output) }
# rescue LoadError => err
#   puts "no awesome_print :("
# end

begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
  # Gives me more space to visualize horizontally
  Hirb::View.config[:width] = 1200

  # Helper method to display only specified fields
  def hirb(object, *fields)
    puts Hirb::Helpers::AutoTable.render(object, :fields => [*fields])
  end
end

if defined? Rails
  # http://www.hackhowtofaq.com/blog/how-to-enable-rubyrails-irb-console-autocomplete-history/
  # Get all Models in [TAB]
  Rails.application.eager_load!
end
