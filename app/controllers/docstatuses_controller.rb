#encoding: utf-8
class DocstatusesController < ApplicationController

	before_filter :authorize

  # GET /docstatuses
  # GET /docstatuses.json
  def index
    @title = 'Статус документа'
    
    @docstatuses = Docstatus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @docstatuses }
    end
  end

  # GET /docstatuses/1
  # GET /docstatuses/1.json
  def show
    @docstatus = Docstatus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @docstatus }
    end
  end

  # GET /docstatuses/new
  # GET /docstatuses/new.json
  def new
    @docstatus = Docstatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @docstatus }
    end
  end

  # GET /docstatuses/1/edit
  def edit
    @docstatus = Docstatus.find(params[:id])
  end

  # POST /docstatuses
  # POST /docstatuses.json
  def create
    @docstatus = Docstatus.new(params[:docstatus])

    respond_to do |format|
      if @docstatus.save
        format.html { redirect_to @docstatus, notice: 'Статус документа успешно создан.' }
        format.json { render json: @docstatus, status: :created, location: @docstatus }
      else
        format.html { render action: "new" }
        format.json { render json: @docstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /docstatuses/1
  # PUT /docstatuses/1.json
  def update
    @docstatus = Docstatus.find(params[:id])

    respond_to do |format|
      if @docstatus.update_attributes(params[:docstatus])
        format.html { redirect_to @docstatus, notice: 'Статус документа успешно обновлен.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @docstatus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docstatuses/1
  # DELETE /docstatuses/1.json
  def destroy
    @docstatus = Docstatus.find(params[:id])
    @docstatus.destroy

    respond_to do |format|
      format.html { redirect_to docstatuses_url }
      format.json { head :ok }
    end
  end
end
