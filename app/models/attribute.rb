#encoding: utf-8
class Attribute < ActiveRecord::Base
    set_table_name "attribute_type" 
    set_primary_key "atr_type_id" 
    set_sequence_name "s_attribute_type"
    
    ATTRIBUTE_TYPES = [
	# Отображается 			Сохраняется БД
	[ "Строка",			"string"	],
	[ "Дата",			"date"		],
	[ "Целое число",		"integer"	],
	[ "Перечисление",		"enum"		]
    ]
    
    has_many 	:docattrs,
		:class_name => "Docattr",
		:foreign_key => "attribute_id"
    has_many :documents, :through => :docattrs, :source => :document
end
