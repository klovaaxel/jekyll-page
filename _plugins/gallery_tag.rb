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
            style = ''
            style += "width: #{@width};" if @width
            style += "columns: #{@columnCount};" if @columnCount
            output = "<div class=\"gallery\" style=\"#{style}\">"
            @images.each do |image|
                if image[:url].empty?
                    output += "<img src=\"#{image[:path]}\" alt=\"#{image[:alt]}\">"
                else
                    output += "<a href=\"#{image[:url]}\"><img src=\"#{image[:path]}\" alt=\"#{image[:alt]}\"></a>"
                end
            end
            output += '</div>'
            output
        end
    end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)