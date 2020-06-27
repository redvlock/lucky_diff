class Shared::LayoutHead < BaseComponent
  needs page_title : String
  # This is used by the 'csrf_meta_tags' method
  needs context : HTTP::Server::Context

  def render
    head do
      utf8_charset
      title "#{@page_title}"
      css_link asset("css/app.css"), data_turbolinks_track: "reload"
      js_link asset("js/app.js"), defer: "true", data_turbolinks_track: "reload"

      # Set up page view tracking in production only
      if Lucky::Env.production?
        js_link src: "https://kindmetrics.io/js/track.js",
          defer: true,
          data_domain: "luckydiff.com"
      end

      meta name: "turbolinks-cache-control", content: "no-cache"
      csrf_meta_tags
      responsive_meta_tag
    end
  end
end
