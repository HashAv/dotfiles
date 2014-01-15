requires = [
  "awesome_print"
]

requires.each do |gem|
  begin
    require gem
  rescue LoadError
    puts "#{gem}" + " is not available"
  end
end

def page(active_record_object)
  require 'hirb'
  Hirb.enable
  formatted_output = Hirb::View.formatter.format_output(active_record_object)
  require 'pry' ; binding.pry
  inspect_mode = false
  Hirb::View.pager.page(formatted_output,inspect_mode)
end
alias :t :page

