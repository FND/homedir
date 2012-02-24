# load Hirb (without adding it to the respective Gemfile)
begin
  require 'bundler'
  $: << Dir.glob(Bundler.bundle_path.join(*%w(gems hirb-* lib))).first
  require 'hirb'
  Hirb.enable
  puts "activated Hirb v#{Hirb::VERSION}"
  # source: https://github.com/pry/pry/wiki/FAQ#wiki-hirb
  pry_print = Pry.config.print
  Pry.config.print = proc do |output, value|
    Hirb::View.view_or_page_output(value) || pry_print.call(output, value)
  end
rescue LoadError => exc
  warn "Failed to load Hirb: #{exc}"
end
