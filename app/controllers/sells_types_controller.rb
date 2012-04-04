class SellsTypesController < ApplicationController

  access_control do
    allow :sells_types_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :sells_types_l, :to => [:index, :show]
    allow :sells_types_s, :to => []
  end

  # GET /sells_types
  # GET /sells_types.xml
  def index
    @sells_types = SellsType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sells_types }
    end
  end

  # GET /sells_types/1
  # GET /sells_types/1.xml
  def show
    @sells_type = SellsType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sells_type }
    end
  end

  # GET /sells_types/new
  # GET /sells_types/new.xml
  def new
    @sells_type = SellsType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sells_type }
    end
  end

  # GET /sells_types/1/edit
  def edit
    @sells_type = SellsType.find(params[:id])
  end

  # POST /sells_types
  # POST /sells_types.xml
  def create
    @sells_type = SellsType.new(params[:sells_type])

    respond_to do |format|
      if @sells_type.save
        flash[:notice] = 'Tipo de NF criado.'
        format.html { redirect_to(@sells_type) }
        format.xml  { render :xml => @sells_type, :status => :created, :location => @sells_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sells_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sells_types/1
  # PUT /sells_types/1.xml
  def update
    @sells_type = SellsType.find(params[:id])

    respond_to do |format|
      if @sells_type.update_attributes(params[:sells_type])
        flash[:notice] = 'Tipo de NF atualizado.'
        format.html { redirect_to(@sells_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sells_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sells_types/1
  # DELETE /sells_types/1.xml
  def destroy
    @sells_type = SellsType.find(params[:id])
    @sells_type.destroy

    respond_to do |format|
      format.html { redirect_to(sells_types_url) }
      format.xml  { head :ok }
    end
  end
end
