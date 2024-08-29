module ApplicationHelper
  def navigation_links
    links = [
      { name: I18n.t("home"), path: root_path, hover_class: "hover:text-lime-500" },
      { name: I18n.t("shop"), path: nil, hover_class: "hover:text-orange-500" },
      { name: I18n.t("about"), path: nil, hover_class: "hover:text-lime-500" },
      { name: I18n.t("contact"), path: nil, hover_class: "hover:text-orange-500" }
    ]

    content_tag(:ul, class: "space-y-4 md:space-y-0 md:flex md:space-x-6") do
      links.each do |link|
        concat(
          content_tag(:li) do
            link_to link[:name], link[:path], title: link[:name], class: "block text-gray-600 transition-colors #{link[:hover_class]}"
          end
        )
      end
    end
  end
end
