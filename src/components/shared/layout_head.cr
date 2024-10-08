class Shared::LayoutHead < BaseComponent
  needs page_title : String
  # This is used by the 'csrf_meta_tags' method
  needs context : HTTP::Server::Context

  def render
    head do
      utf8_charset
      title ["LuckyDiff", (@page_title.empty? ? nil : @page_title)].compact.join(" - ")
      css_link href: "https://rsms.me/inter/inter.css", data_turbolinks_track: "reload"
      css_link href: "https://cdn.jsdelivr.net/npm/diff2html/bundles/css/diff2html.min.css", data_turbolinks_track: "reload"
      css_link asset("css/app.css"), data_turbolinks_track: "reload"
      js_link asset("js/app.js"), data_turbolinks_track: "reload", attrs: [:defer]

      inject_analytics

      meta name: "turbolinks-cache-control", content: "no-cache"
      meta name: "description", content: site_description
      csrf_meta_tags
      responsive_meta_tag
    end
  end

  private def site_description
    "LuckyDiff provides Lucky Framework developers with easy access to version differences between generated applications, making upgrades a breeze and ensuring you don't leave any great functionality behind."
  end

  private def inject_analytics
    script src: "https://#{Fathom.settings.domain}/script.js", data_site: Fathom.settings.site_id
  end
end
