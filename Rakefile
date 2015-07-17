# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'map-kit-wrapper'
require 'bubble-wrap/location'


begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Radares de Portugal'
  app.info_plist['NSLocationAlwaysUsageDescription'] = 'Por favor deixe-nos usar a sua localização'
  app.info_plist['NSLocationWhenInUseUsageDescription'] = 'Estamos a usar a sua localização'
  app.frameworks += ['CoreLocation', 'MapKit']
  app.identifier = 'radares.fcdigital.ws'
  app.codesign_certificate = 'iPhone Developer: Filipe Contente (94BEP2NJ7B)'
  app.provisioning_profile = '/Users/tiago/MyProjects/RADARES2PROVDEV.mobileprovision'

end
