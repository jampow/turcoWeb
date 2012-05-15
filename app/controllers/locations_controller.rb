class LocationsController < ApplicationController

  access_control do
    allow :locations_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy, :to_bill, :generate_bill]
    allow :locations_l, :to => [:index, :show, :default_data]
    allow :locations_s, :to => []
  end

  # GET /locations
  # GET /locations.xml
  def index
    @locations = Location.grid

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.xml
  def show
    @location = Location.find(params[:id])
    @items    = @location.location_items

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.xml
  def new
    @location = Location.new
    @item_form = LocationItem.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    @location.client_name = @location.client.name
    @location.seller_name = @location.seller.name
    default_data

    @item_form = @location.location_items.build
    @grid      = @location.item_grid
  end

  # POST /locations
  # POST /locations.xml
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Locação criada.'
        format.html { redirect_to(@location) }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        default_data
        @item_form = LocationItem.new

        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.xml
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        flash[:notice] = 'Locação atualizada.'
        format.html { redirect_to(@location) }
        format.xml  { head :ok }
      else
        default_data
        @item_form = LocationItem.new

        format.html { render :action => "edit" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.xml
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do |format|
      format.html { redirect_to(locations_url) }
      format.xml  { head :ok }
    end
  end

  def to_bill
    @location = LocationReceipt.new
    @location.calculateFields params[:id]
    render :layout => 'simple_application'
  end

  def generate_bill
    @location = LocationReceipt.new params[:location_receipt]

    respond_to do |format|
      if @location.save
        flash[:notice] = 'Recibo criado'
        format.html { render :layout => 'simple_application' }
        format.xml  { render :xml => @location, :status => :created, :location => @location }
      else
        format.html { render :action => "to_bill" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def default_data
    @payment_conds = PaymentForm.all.collect { |p| [p.name, p.id] }
  end
end
