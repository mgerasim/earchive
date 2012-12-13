#encoding: utf-8
require File.dirname(__FILE__) + '/to_xls'
require 'cgi'
require 'RMagick'

class DocumentsController < ApplicationController

  before_filter :authorize
  
  helper_method :sort_column, :sort_direction
  
  def index

	log = Logger.new(STDOUT)

	@title = 'Поиск документа'

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
	
	log.debug('params')
	log.debug(@uri_params)
	log.debug('edited_on')
	log.debug(@uri_params["edited_on"].to_i)
	
	@Documents = {}

	respond_to do |format|
		format.html do |wants|
			@Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => page)
		end
		
	        format.js do |wants|
			@Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 20, :page => page)
	        end 
	        
	        format.xls do |wants|
	    	    @Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction)
		    render :layout=>false
		end
		
		format.zip do |wants|
		
		    begin
			    if File.directory?("#{Rails.root}/public/tmp") == false
				Dir.mkdir("#{Rails.root}/public/tmp")
			    end
	    
			    path = "#{Rails.root}/public/tmp/#{session["session_id"]}"
	    
			    if File.directory?(path)==false
				Dir.mkdir(path)
			    end
			    
			    path_zip = "#{path}/zip"
			    if File.directory?(path_zip)==false
				Dir.mkdir(path_zip)
			    end
			    
			    @Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction)
			    
			    raise Errno::ENOENT if (@Documents.count > 50)
			    
				@Documents.each do |document|
				    FileUtils.cp(document.source, path_zip)
				end

			    system("cd /#{path_zip}")
			    system("#{Rails.root}/archive.sh #{Rails.root} #{session["session_id"]}")
		    
			    send_data IO.read("#{path_zip}/archive.zip"), :filename => "archive.zip", :type => "application/zip", :disposition => "inline"
		    rescue Errno::ENOENT
			    flash[:notice] = "Превашение ограничения документов 50 шт"
	    		    redirect_to :action => :index
		    else
		    end
		end
	end
    
  end
  
  def edit
	@title = 'Редактирование документа'
	if (params[:query] != nil)
	    @uri_params = Rack::Utils.parse_query(params[:query])
	else
	    @uri_params = params
	end
	
	@Documents = {}
	
	respond_to do |format|
		format.html do |wants|
			@Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 1, :page => params[:page])
		end
	        format.js do |wants|
	        	@Documents = Document.search(@uri_params).order(sort_column + ' ' + sort_direction).paginate(:per_page => 1, :page => params[:page])
	        end
	end
	
  end
  
  def update
	log = Logger.new(STDOUT)
	log.debug("update")
  end
  
  def abongroup
	
	log = Logger.new(STDOUT)
	
  
	if (params[:query] != nil)
	    @uri_params = Rack::Utils.parse_query(params[:query])
	else
	    @uri_params = params
	end
	
	
	@Documents = Document.search(@uri_params)
	@documents = @Documents
	
	@page_count = Document.search(@uri_params).sum(:page_count)
	
	log.debug(@documents.count)
	
	@documents = @documents.map(&:account)
	
	@documents = @documents.group_by(&:capitalize).map{|k,v| [k, v.length]}
	
	log.debug(@documents.count)
	
	respond_to do |format|
		format.html
	        format.xls { render :layout=>false }
	end
    
  end
  
  
  def preview
	begin
	    log = Logger.new(STDOUT)
	    log.debug(session["session_id"])
	    
	    @document = Document.find(params[:id])
	    
	    @file = @document.jpeg(session["session_id"])
	    
	rescue Errno::ENOENT
	    logger.error("Попытка доступа к несуществующему документу " )
	    flash[:notice] = "Неверный путь к документу"
	    redirect_to :action => :index
	else
	
	end
	
  end
 
  def load
	begin
	    
	    document = Document.find(params[:id])
	    send_data IO.read(document.source), :filename => File.basename(document.source), :type => "application/pdf", :disposition => "inline"

	rescue Errno::ENOENT
	    logger.error("Попытка доступа к несуществующему документу #{document.source}" )
	    flash[:notice] = "Неверный путь к документу"
	    redirect_to :action => :index
	else
	
	end
  end
 
 
  def show
	begin
	    @document = Document.find(params[:id])
	rescue
	    logger.error("Попытка доступа к несуществующему документу #{params[:id]}" )
	    flash[:notice] = "Неверный путь к документу"
	    redirect_to :action => :index
	else
	end
  end
  
  def export
	@Documents = index
	headers['Content-Type'] = "application/vnd.ms-excel; charset=utf-8"
	headers['Content-Disposition'] = 'attachment; filename="report.xls"'
        headers['Cache-Control'] = ''
        render :layout => false, :file => 'documents/export.xml.builder'
end
  
  
  def new
    @document = Document.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @document }
    end
  end

  # POST /documents
  # POST /documents.json
  def create
  
     name = params[:document][:pdf_file].original_filename
  

    directory = "/storage"
    path = File.join(directory, name)
    File.open(path, "wb") { |f| f.write(params[:document][:pdf_file].read) }
  
    @doc = Document.new
  
    @doc.source = path
    @doc.doc_status_id = 0
    @doc.account = File.basename(name, File.extname(name))
  
    if @doc.save
	redirect_to "/documents/new", notice: "Файл загружен"
    else
	redirect_to "/documents/new", "Ошибка загрузки файла"
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
