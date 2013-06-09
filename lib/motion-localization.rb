unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

eval(File.read(File.join(File.dirname(__FILE__), 'motion-localization.rake')))
