require 'rubygems'
require 'middleman/rack'
require 'rack/cors'

run Middleman.server

use Rack::Cors do
  allow do
    origins 'jmh-portfolio.herokuapp.com, jenharley.com, blog.jenharley.com jmh-blog.herokuapp.com, localhost:3000, localhost:5000, localhost:4567'
    resource 'feed.xml',
      headers: :any,
      methods: [:get, :options]
  end
end
