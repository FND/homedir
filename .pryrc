#Pry.commands.alias_command 'n', 'next'
#Pry.commands.alias_command 's', 'step'

# highlight Rails production mode
#if (Rails.env rescue nil) == "production"
#	PRYMPT = Pry.config.prompt[0]
#	Pry.config.prompt[0] = proc { |*args| "\e[1;31m[" + Rails.env + "]\e[0m " + PRYMPT.call(*args) }
#end

# activate Hirb
#begin
#  require 'hirb'
#  Hirb.enable
#  # source: https://github.com/pry/pry/wiki/FAQ#wiki-hirb
#  pry_print = Pry.config.print
#  Pry.config.print = proc do |output, value|
#    Hirb::View.view_or_page_output(value) || pry_print.call(output, value)
#  end
#rescue LoadError => exc
#  warn "Failed to load Hirb: #{exc}"
#end
