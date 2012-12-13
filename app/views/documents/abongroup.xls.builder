xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.Workbook({
    'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet", 
    'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
    'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",    
    'xmlns:html' => "http://www.w3.org/TR/REC-html40",
    'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet" 
}) do
    xml.Styles do
    xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
    xml.Alignment 'ss:Vertical' => 'Bottom'
    xml.Borders
    xml.Font 'ss:FontName' => 'Verdana'
    xml.Interior
    xml.NumberFormat
    xml.Protection
end
    xml.Style 'ss:ID' => 's22' do
	xml.NumberFormat 'ss:Format' => 'General Date'
    end
end
                                                                
xml.Worksheet 'ss:Name' => 'Отчет' do
    xml.Table do
	# Header
        xml.Row do
    	    xml.Cell do
                xml.Data '№', 'ss:Type' => 'String'
            end
    	    
    	    xml.Cell do
                xml.Data 'Лицевой счет', 'ss:Type' => 'String'
            end
            
    	    xml.Cell do
                xml.Data 'ФИО абонента', 'ss:Type' => 'String'
            end
            
            xml.Cell do
                xml.Data 'Коробка', 'ss:Type' => 'String'
            end
            
            xml.Cell do
                xml.Data 'Кол-во листов', 'ss:Type' => 'String'
            end
            
            
            
        end
        # Rows
        i=0
        for document in @documents
    	    i+=1
    	    xml.Row do
    		xml.Cell do
        	    xml.Data i.to_s, 'ss:Type' => 'String'
        	end
        	
        	xml.Cell do
        	    xml.Data document[0], 'ss:Type' => 'String'
        	end
        	
        	xml.Cell do
        	    xml.Data Document.find(:all, :conditions => ['account = ?', document[0]]).first.abonent_name, 'ss:Type' => 'String'
        	end

		xml.Cell do
		    xml.Data Document.find(:all, :conditions => ['account = ?', document[0]]).first.korobka.to_i, 'ss:Type' => 'String'
		end
		
		xml.Cell do
		    xml.Data Document.sum(:page_count, :conditions => ['account = ?', document[0]]), 'ss:Type' => 'String'
		end

        	
    	    end
    	end
    end
end
end
