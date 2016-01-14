###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  blog.paginate = true
  blog.per_page = 6
  blog.page_link = "page/{num}"
end

set :casper, {
  blog: {
    url: 'http://blog.jenharley.com',
    name: "Jen Harley | Blog",
    description: 'My blog about making things',
    date_format: '%B %d, %Y',
    logo: nil # Optional
  },
  author: {
    name: 'Jen Harley',
    bio: '',
    location: nil, # Optional
    website: 'http://jenharley.com', # Optional
    gravatar_email: nil # Optional
  }
}


page "/feed.xml", layout: false
page '/sitemap.xml', layout: false

ignore '/partials/*'

ready do
  blog.tags.each do |tag, articles|
    proxy "/tag/#{tag.downcase.parameterize}/feed.xml", '/feed.xml', layout: false do
      @tagname = tag
      @articles = articles[0..5]
    end
  end

  proxy "/author/#{blog_author.name.parameterize}.html", '/author.html', ignore: true
end

set :haml, { ugly: true }
set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true
activate :syntax, line_numbers: true

set :build_dir, 'tmp'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :fonts_dir, '../fonts'

set :images_dir, 'images'

configure :build do
end

activate :deploy do |deploy|
  deploy.method   = :sftp
  deploy.host     = 'carroll.dreamhost.com'
  deploy.port     = 22
  deploy.path     = '/home/smharley/blog.jenharley.com'
  deploy.user     = 'smharley'
  deploy.password = ENV['JENNY_DEPLOY']
end

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
      headers: :any,
      methods: [:get, :options]
  end
end
