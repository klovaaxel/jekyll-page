module Jekyll
    class GalleryTag < Liquid::Tag
      def initialize(tag_name, text, tokens)
        super
        @raw_text = text.strip
      end
  
      def render(context)
        # Resolve the input text from the Liquid context
        resolved_text = context[@raw_text] || Liquid::Template.parse(@raw_text).render(context)
  
        # Ensure resolved_text is not nil
        return '' if resolved_text.nil? || resolved_text.strip.empty?
  
        # Process the resolved input text
        images = []
        properties = resolved_text.split(',').map(&:strip)
        properties.each do |property|
          next if property.nil? || property.empty? # Skip invalid entries
  
          # Split the property into components, ensuring nil-safe processing
          parts = property.split(' | ').map(&:strip)
          image_path = parts[0] || ''
          alt_text = parts[1] || ''
          url = parts[2] || ''
          link_text = parts[3] || ''
  
          # Skip entries without a valid image path
          next if image_path.empty?
  
          images << { path: image_path, alt: alt_text, url: url }
        end
  
        # Generate the HTML for the gallery
        site = context.registers[:site]
        style = ''
        style += "width: #{@width};" if @width
        style += "columns: #{@columnCount};" if @columnCount
        output = "<div class=\"gallery\" style=\"#{style}\">"
        images.each do |image|
          if image[:url].empty?
            output += "<img src=\"#{site.baseurl}#{image[:path]}\" alt=\"#{image[:alt]}\">"
          else
            output += "<a href=\"#{site.baseurl}#{image[:url]}\"><img src=\"#{site.baseurl}#{image[:path]}\" alt=\"#{image[:alt]}\"><span>#{image[:alt]}</span></a>"
          end
        end
        output += '</div>'
        output
      end
    end
  end
  
  Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)