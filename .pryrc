# activate Hirb
begin
  require 'hirb'
  Hirb.enable
  # source: https://github.com/pry/pry/wiki/FAQ#wiki-hirb
  pry_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || pry_print.call(output, value)
  end
rescue LoadError => exc
  warn "Failed to load Hirb: #{exc}"
end
