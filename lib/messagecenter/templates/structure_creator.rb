module Messagecenter
  module Templates
    module StructureCreator

      private
        def create_structure
          content = Nokogiri::HTML(self.html)
          #start traversing the hierarchy goes as:
          #containers => rows => grids => divisions => editable content
          wrapper = HashWithIndifferentAccess.new(containers: [], html: "")

          containers = wrapper[:containers]
          content.css('container').each do |container_child|
            
            rows = []
            container_child.css('row').each do |row_child|

              grids = []
              row_child.css('grid').each do |grid_child|
                divisions = []
                data_model = build_data_model(grid_child.css('division'))

                grid_child.css('division').each do |division_child|
                  sanitize_division(division_child)
                  divisions << HashWithIndifferentAccess.new(html: division_child.children.to_s, type: division_child['type'])
                  Messagecenter::Templates::MarkupGenerator.add_component_class(division_child, 'division')
                  division_child.parent.add_child(add_newline(Template::PLACE_HOLDER_ELEM)) unless division_child.parent.to_s.include?(Template::PLACE_HOLDER_ELEM)
                  
                  division_child.remove
                end

                grid = HashWithIndifferentAccess.new(divisions: divisions, data_model: data_model)
                grid_parent = grid_child.parent
                grid_child.swap(add_newline(Template::PLACE_HOLDER_ELEM))
                
                Messagecenter::Templates::MarkupGenerator.add_component_class(grid_child, 'grid')
                grid[:html] = grid_child.children.to_s
                
                grids << grid
              end


              row = HashWithIndifferentAccess.new(grids: grids)
              row_parent = row_child.parent
              row_child.swap(add_newline(Template::PLACE_HOLDER_ELEM))
              
              Messagecenter::Templates::MarkupGenerator.add_component_class(row_child, 'row')
              row[:html] = row_child.children.to_s
              
              rows << row
            end

            container = HashWithIndifferentAccess.new(rows: rows, type: container_child['type'])
            container_parent = container_child.parent
            container_child.swap(add_newline(Template::PLACE_HOLDER_ELEM))

            Messagecenter::Templates::MarkupGenerator.add_component_class(container_child, 'container')
            container[:html] = container_child.children.to_s
            
            containers << container
            
          end

          wrapper[:html] = content.to_s

          self.structure = wrapper
          self.save

        end

        #Replace the <headline>, <paragraph>, <image>
        def sanitize_division(division_child)
          division_child.css('headline').each do |headline_child|
            Messagecenter::Templates::MarkupGenerator.add_component_class(headline_child, 'headline')  
            headline_html = headline_child.children.to_s
            headline_child.swap(headline_html)
          end

          division_child.css('paragraph').each do |paragraph_child|
            Messagecenter::Templates::MarkupGenerator.add_component_class(paragraph_child, 'paragraph')  
            paragraph_html = paragraph_child.children.to_s
            paragraph_child.swap(paragraph_html)
          end

          #Add for image
        end

        #build the data model when parsing the divisions for each row => grid when building the structure
        def build_data_model(divisions)
          data_model = {}

          divisions.each do |division|
            data_model[division['type']] = {}
            div_hash = data_model[division['type']]
            div_hash['title'] = division['type'].to_s.humanize
            sanitize_division(division)
            div_hash['content'] = division.children.to_s.squish
          end

          data_model
        end

        def add_newline(html)
          "\n" + html + "\n"
        end

    end #end of the SystemTemplateParser module
  end #end of the Templates module
end #end of the Messagecenter module