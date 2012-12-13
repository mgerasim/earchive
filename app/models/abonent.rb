#encoding: utf-8

#encoding: utf-8
class Abonent < ActiveRecord::Base
    set_table_name "v_abonents" 
    
    HUMANIZED_ATTRIBUTES = {
	:account => "Номер лицевого счета",
	:abonent_name => "ФИО абонента",
	:page_count => "Количество листов, входящих в состав абонентского дела",
	:korobka => "Номер коробки",
	:updated_at => "Дата обновления абонента",
	:created_at => "Дата создания абонента"
    }
    
    def self.human_attribute_name(attr, options = {})
      HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end
    
    def self.ExcelReportHeaders
	[:account, :abonent_name, :korobka, :page_count]
    end
    
    def self.search(query)
	if query
	
	    d_bgn = query["abonent_created_at_bgn"]
	    d_end = query["abonent_created_at_end"]
	    
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

	    d_bgn_upd = query["abonent_updated_at_bgn"]
	    d_end_upd = query["abonent_updated_at_end"]
	    
	    if d_bgn_upd == nil
		d_bgn_upd = ""
	    end
	    if d_bgn_upd == ""
		d_bgn_upd = '01.01.1971'
	    end
	    
	    if d_end_upd == nil
		d_end_upd = ""
	    end
	    if d_end_upd == ""
		d_end_upd = '01.01.2100'
	    end
	    
	    korobka = query["abonent_korobka"]
	    if korobka == nil
		korobka = ""
	    end
	    if korobka == ""
		korobka = "%%"
	    end

	    where('(account LIKE ? or UPPER(abonent_name) LIKE UPPER(?)) and korobka LIKE ? and created_at between ? and ?+1 ',
			    "%#{query["abonent_search"]}%", "%#{query["abonent_search"]}%",  "#{korobka}", Date.strptime(d_bgn, "%d.%m.%Y") , Date.strptime(d_end, "%d.%m.%Y"))
    	else
	    scoped
	end
    end


end
