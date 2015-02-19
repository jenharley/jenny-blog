require 'rubygems'
require 'middleman/rack'
require 'rack/cors'

run Middleman.server

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :options]
  end
end
