#encoding: utf-8
class Document < ActiveRecord::Base
    set_table_name "v_documents" 
    set_primary_key "doc_id" 
    set_sequence_name "s_documents"
    
    def base_part_of(file_name)
	File.basename(file_name).gsub(/[^\W._-]/, '')
    end
    
    has_many 	:docattrs,
		:class_name => "Docattr",
		:foreign_key => "doc_id"
    
    HUMANIZED_ATTRIBUTES = {
	:source => "Имя файла",
	:phone => "Телефон",
	:account => "Номер лицевого счета",
	:abonent_name => "ФИО абонента",
	:page_count => "Количество листов, входящих в состав абонентского дела",
	:comments => "Примечание",
	:access_person_data => "Доступ на обработку персональных данных",
	:korobka => "Номер коробки",
	:status => "Статус документа",
	:scaned_at => "Дата сканирования документа",
	:created_at => "Дата загрузки документа",
	:doctype => "Тип документа"
    }
    
    def self.human_attribute_name(attr, options = {})
      HUMANIZED_ATTRIBUTES[attr.to_sym] || super
      end
      
    def self.Headers
	[:account, :abonent_name, :page_count, :korobka, :comments]
    end
    
    def self.search(query)
	if query
	
	    Rails.logger.info 'query'
	    Rails.logger.info query
	    
	    d_bgn = query["created_at_bgn"]
	    d_end = query["created_at_end"]
	    
	    Rails.logger.info 'd_bgn'
	    Rails.logger.info  d_bgn
	    
	    if d_bgn == nil
		d_bgn = ""
	    end
	    if d_bgn == ""
		d_bgn = '01.01.1971'
	    end
	    
	    if d_end == nil
		d_end = ""
	    end
	    if d_end == ""
		d_end = '01.01.2100'
	    end
	    
	    korobka = query["korobka"]
	    if korobka == nil
		korobka = ""
	    end
	    if korobka == ""
		korobka = "%%"
	    end

	    block_gr = query["block_group_search"]
	    
	    if (block_gr==nil)
		block_gr = ""
	    end
	    
	    if (block_gr=="")
		    where('(account LIKE ? or phone LIKE ? or UPPER(abonent_name) LIKE UPPER(?)) and korobka LIKE ? and created_at between ? and ?+1 ',
			    "%#{query["search"]}%", "%#{query["search"]}%", "%#{query["search"]}%",    "#{korobka}", Date.strptime(d_bgn, "%d.%m.%Y") , Date.strptime(d_end, "%d.%m.%Y"))
	    else
		    where("account in (#{block_gr})")
	    end
		
		
	    

	
    	else
	    scoped
	end
    end
    
    def jpeg(session_id)
	
	    if File.directory?("#{Rails.root}/public/tmp") == false
		Dir.mkdir("#{Rails.root}/public/tmp")
	    end
	    
	    path = "#{Rails.root}/public/tmp/#{session_id}"
	    
	    if File.directory?(path)==false
		    Dir.mkdir(path)
	    end
	    
    	    pdf = Magick::ImageList.new(self.source)
    	    
    	    file = "#{path}/#{self.id}.jpeg"
	    pdf.write(file)
	    
	    if File.exist?(file) == false
		file = "/tmp/#{session_id}/#{self.id}-0.jpeg"
	    else
		file = "/tmp/#{session_id}/#{self.id}.jpeg"
	    end
	    
    end
    
end
