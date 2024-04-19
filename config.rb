# Dependencies
require 'adelyte-website-themes'
###
# Page options, layouts, aliases and proxies
###
page "/private/*", :layout => "private"
page "/sonos/*", :layout => "sonos"

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
# page "/index.html", :layout => "homepage"


set :erb, {
  ugly: true,
  format: :html5
}

activate :syntax, line_numbers: false
activate :directory_indexes

set :markdown_engine, :kramdown
set :markdown, tables: true, hard_wrap: false, input: "GFM"

activate :blog do |blog|
  blog.sources = "posts/{year}-{month}-{day}-{title}.html"
  blog.permalink = "{year}/{month}/{day}/{title}/index.html"
  blog.layout = "post"

  blog.summary_separator = /<!--\s*more\s*-->/
end

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

set :sass_assets_paths, ['assets']

##
# Helper methods
##
helpers do
  def xml_feed_content(article)
    content = article.body

    if article.data.image_title
      content << "<img src='#{data.site.url}#{article.data.image_title}' class='webfeedsFeaturedVisual' style='display: none;' />"
    else
      content << "<img src='#{data.site.url}#{image_path("default-blog-image.png")}' class='webfeedsFeaturedVisual' style='display: none;' />"
    end

    h(content)
  end

  def markdown(text)
    Tilt['markdown'].new { text }.render
  end
end

# Build-specific configuration
configure :build do
  set :build_dir, "public"
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
end

ignore '/includes/*'
ignore '/proposals/template.html'
