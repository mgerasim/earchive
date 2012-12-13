#encoding: utf-8
module ApplicationHelper
    def title
		base_title = 'Электронный архив'
		if @title.nil?
		    base_title
		else
		    "#{base_title} | #{@title}"
		end
    end
    
    def sortable(column, title = nil)
	title ||= Document.human_attribute_name(column)
	css_class = (column == sort_column) ? "current #{sort_direction}" : nil
	direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
        link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
    end
    
end
