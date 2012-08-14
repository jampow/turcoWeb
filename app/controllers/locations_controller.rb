class LocationsController < ApplicationController

  access_control do
    allow :locations_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy, :to_bill, :generate_bill, :select_locations, :generate_bills, :contract]
    allow :locations_l, :to => [:index, :show, :default_data, :contract]
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
    @location.seller_name = @location.seller.name unless @location.seller.blank?
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
        Talk.broadcast current_user.id, "<a href=\"/locations/#{@location.id}\" ajax=\"true\">iniciou nova locação #{@location.number} para o cliente #{@location.client_name}</a>."
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
        Talk.broadcast current_user.id, "<a href=\"/locations/#{@location.id}\" ajax=\"true\">alterou a locação #{@location.number} para o cliente #{@location.client_name}</a>."
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
    @location = Location.find params[:id]
    @location.create_receivable(nil)
    flash[:notice] = 'Cobrança criada'
    redirect_to :action => "show"
    # render :layout => 'simple_application'
  end

  # def generate_bill
  #   @location = LocationReceipt.new params[:location_receipt]

  #   respond_to do |format|
  #     if @location.save
  #       flash[:notice] = 'Cobrança criada'
  #       format.html { render :layout => 'simple_application' }
  #       format.xml  { render :xml => @location, :status => :created, :location => @location }
  #     else
  #       format.html { render :layout => 'simple_application', :action => "to_bill" }
  #       format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end

  def select_locations
    @locations = Location.actives

    respond_to do |format|
      format.html # select_locations.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  def generate_bills
    locations = params[:location]
    locations[:locations].each do |loc_id|
      loc = Location.find loc_id
      loc.create_receivable(locations[:due_date])
    end

    flash[:notice] = "Títulos a receber gerados"
    redirect_to :locations
  end

  def contract
    @loc = Location.find params[:id]
    @ent = Enterprise.first
    @cli = @loc.client

    render :layout => 'report'
  end

  private

  def default_data
    @banks = BankAccount.all.collect { |p| ["#{p.bank_name} - #{p.agency_number} - #{p.account_number}", p.id] }
  end
end
