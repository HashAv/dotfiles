requires = [
  "interactive_editor",
  "awesome_print"
]

requires.each do |gem|
  begin
    require gem
  rescue LoadError
    puts "#{gem}" + " is not available"
  end
end
