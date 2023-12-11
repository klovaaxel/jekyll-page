module Jekyll
    class GalleryTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @images = text.split(',').map do |item|
                image_path, alt_text = item.split('#').map(&:strip)
                alt_text = '' if alt_text.nil?
                { path: image_path, alt: alt_text }
            end
        end

        def render(context)
            output = '<div class="gallery">'
            @images.each do |image|
                output += "<img src=\"#{image[:path]}\" alt=\"#{image[:alt]}\">"
            end
            output += '</div>'
            output
        end
    end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)