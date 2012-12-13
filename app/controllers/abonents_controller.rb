#encoding: utf-8
require 'will_paginate/array'
class AbonentsController < ApplicationController

  before_filter :authorize
  
  helper_method :sort_column, :sort_direction

  # GET /abonents
  # GET /abonents.json
  def index
    	@title = 'Поиск абонента'

	if (params[:query] != nil)
	    @uri_params = Rack::Utils.parse_query(params[:query])
	else
	    @uri_params = params
	end
	
	
	page = params[:page]
	
	if page == nil
	    page = 1
	end
	
	session[:page] = page
	
	@Abonents = {}

	respond_to do |format|
		format.html do |wants|
			@Abonents = Abonent.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => page)
		end
		
	        format.js do |wants|
			@Abonents = Abonent.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => page)
	        end 
	        
	        format.xls do |wants|
	    	    @Abonents = Abonent.search(@uri_params).order(sort_column + ' ' + sort_direction)
		    render :layout=>false
		end
	end
  end
  
  private
    def sort_column
	Document.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
	%w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end

end
