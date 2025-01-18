module Jekyll
    class GalleryTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @images = []
            properties = text.split(',').map(&:strip)
            properties.each do |property|
                image_path, alt_text, url, linkText = property.split(' | ').map(&:strip)
                alt_text = '' if alt_text.nil?
                url = '' if url.nil?
                @images << { path: image_path, alt: alt_text, url: url } unless image_path.empty?
            end
        end

        def render(context)
            site = context.registers[:site]
            style = ''
            style += "width: #{@width};" if @width
            style += "columns: #{@columnCount};" if @columnCount
            output = "<div class=\"gallery\" style=\"#{style}\">"
            @images.each do |image|
                if image[:url].empty?
                    output += "<img src=\"#{ site.baseurl }#{image[:path]}\" alt=\"#{image[:alt]}\">"
                else
                    # Todo: Switch betwen local links and external links and add baseurl if local
                    output += "<a href=\"#{ site.baseurl }#{image[:url]}\"><img src=\"#{ site.baseurl }#{image[:path]}\" alt=\"#{image[:alt]}\"><span>#{image[:alt]}</span></a>"
                end
            end
            output += '</div>'
            output
        end
    end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)