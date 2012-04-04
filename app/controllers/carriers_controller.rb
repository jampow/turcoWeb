class CarriersController < ApplicationController

  access_control do
    allow :carriers_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy]
    allow :carriers_l, :to => [:index, :show, :default_data]
    allow :carriers_s, :to => []
  end

  # GET /carriers
  # GET /carriers.xml
  def index
    @carriers = Carrier.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carriers }
    end
  end

  # GET /carriers/1
  # GET /carriers/1.xml
  def show
    @carrier = Carrier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @carrier }
    end
  end

  # GET /carriers/new
  # GET /carriers/new.xml
  def new
    @carrier = Carrier.new
    @carrier.address = Address.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @carrier }
    end
  end

  # GET /carriers/1/edit
  def edit
    @carrier = Carrier.find(params[:id])
    default_data
  end

  # POST /carriers
  # POST /carriers.xml
  def create
    @carrier = Carrier.new(params[:carrier])

    respond_to do |format|
      if @carrier.save
        flash[:notice] = 'Transportadora criada.'
        format.html { redirect_to(@carrier) }
        format.xml  { render :xml => @carrier, :status => :created, :location => @carrier }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @carrier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carriers/1
  # PUT /carriers/1.xml
  def update
    @carrier = Carrier.find(params[:id])

    respond_to do |format|
      if @carrier.update_attributes(params[:carrier])
        flash[:notice] = 'Transportadora atualizada.'
        format.html { redirect_to(@carrier) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @carrier.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carriers/1
  # DELETE /carriers/1.xml
  def destroy
    @carrier = Carrier.find(params[:id])
    @carrier.destroy

    respond_to do |format|
      format.html { redirect_to(carriers_url) }
      format.xml  { head :ok }
    end
  end

protected
  
  def default_data
    @estates = Estate.all.collect { |e| [e.name, e.id] }
  end
end
