#encoding: utf-8
class DepartsController < ApplicationController

  before_filter :authorize

  # GET /departs
  # GET /departs.json
  def index
    @departs = Depart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @departs }
    end
  end

  # GET /departs/1
  # GET /departs/1.json
  def show
    @depart = Depart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @depart }
    end
  end

  # GET /departs/new
  # GET /departs/new.json
  def new
    @depart = Depart.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @depart }
    end
  end

  # GET /departs/1/edit
  def edit
    @depart = Depart.find(params[:id])
  end

  # POST /departs
  # POST /departs.json
  def create
    @depart = Depart.new(params[:depart])

    respond_to do |format|
      if @depart.save
        format.html { redirect_to @depart, notice: 'Филиал успешно создан.' }
        format.json { render json: @depart, status: :created, location: @depart }
      else
        format.html { render action: "new" }
        format.json { render json: @depart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /departs/1
  # PUT /departs/1.json
  def update
    @depart = Depart.find(params[:id])

    respond_to do |format|
      if @depart.update_attributes(params[:depart])
        format.html { redirect_to @depart, notice: 'Филиал успешно создан.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @depart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departs/1
  # DELETE /departs/1.json
  def destroy
    @depart = Depart.find(params[:id])
    @depart.destroy

    respond_to do |format|
      format.html { redirect_to departs_url }
      format.json { head :ok }
    end
  end
end
