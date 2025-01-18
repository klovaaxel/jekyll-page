module Jekyll
    class PreambleTag < Liquid::Tag
        def initialize(tag_name, text, tokens)
            super
            @text = text
        end

        def render(context)
            "<p class=\"preamble\">#{@text}</p>"
        end
    end
end

Liquid::Template.register_tag('preamble', Jekyll::PreambleTag)