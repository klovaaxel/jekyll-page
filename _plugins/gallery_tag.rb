module Jekyll
    class GalleryTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @width = nil
            @height = nil
            @imageWidth= nil
            @images = []
            properties = text.split(',').map(&:strip)
            properties.each do |property|
                if property.start_with?('@')
                    key, value = property.split(':').map(&:strip)
                    case key
                    when '@width'
                        @width = value
                    when '@height'
                        @height = value
                    when '@image-width'
                        @imageWidth = value
                    end
                else
                    image_path, alt_text, url, linkText = property.split(' | ').map(&:strip)
                    alt_text = '' if alt_text.nil?
                    url = '' if url.nil?
                    @images << { path: image_path, alt: alt_text, url: url } unless image_path.empty?
                end
            end
        end

        def render(context)
            style = ''
            style += "width: #{@width};" if @width
            style += "height: #{@height};" if @height
            output = "<div class=\"gallery\" style=\"#{style}\">"
            @images.each do |image|
                if image[:url].empty?
                    output += "<img style=\"width:#{@imageWidth} \" src=\"#{image[:path]}\" alt=\"#{image[:alt]}\">"
                else
                    output += "<a href=\"#{image[:url]}\"><img style=\"width:#{@imageWidth} \" src=\"#{image[:path]}\" alt=\"#{image[:alt]}\"></a>"
                end
            end
            output += '</div>'
            output
        end
    end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)