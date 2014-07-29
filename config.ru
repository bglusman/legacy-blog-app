# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'coverband'
Coverband.configure
use Coverband::Middleware

run Rails.application
