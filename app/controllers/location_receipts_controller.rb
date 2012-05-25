class LocationReceiptsController < ApplicationController
  # GET /location_receipts
  # GET /location_receipts.xml
  def index
    session[:location_id] = params[:id] if params[:id]
    @location_receipts = LocationReceipt.find(:all, :conditions => "location_id = #{session[:location_id]}")
    @location = Location.find session[:location_id]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @location_receipts }
    end
  end

  # GET /location_receipts/1
  # GET /location_receipts/1.xml
  def show
    @location_receipt = LocationReceipt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @location_receipt }
    end
  end

  # GET /location_receipts/new
  # GET /location_receipts/new.xml
  def new
    @location_receipt = LocationReceipt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @location_receipt }
    end
  end

  # GET /location_receipts/1/edit
  def edit
    @location_receipt = LocationReceipt.find(params[:id])
  end

  # POST /location_receipts
  # POST /location_receipts.xml
  def create
    @location_receipt = LocationReceipt.new(params[:location_receipt])

    respond_to do |format|
      if @location_receipt.save
        flash[:notice] = 'Recibo criado.'
        format.html { redirect_to(@location_receipt) }
        format.xml  { render :xml => @location_receipt, :status => :created, :location => @location_receipt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location_receipt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /location_receipts/1
  # PUT /location_receipts/1.xml
  def update
    @location_receipt = LocationReceipt.find(params[:id])

    respond_to do |format|
      if @location_receipt.update_attributes(params[:location_receipt])
        flash[:notice] = 'Recibo atualizado.'
        format.html { redirect_to(@location_receipt) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @location_receipt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /location_receipts/1
  # DELETE /location_receipts/1.xml
  def destroy
    @location_receipt = LocationReceipt.find(params[:id])
    @location_receipt.destroy

    respond_to do |format|
      format.html { redirect_to(location_receipts_url) }
      format.xml  { head :ok }
    end
  end

  def print
    @receipt = LocationReceipt.find params[:id]
    # @location = @location_receipt.location
    # @client = @location.client
    # @enterprise = Enterprise.first
    render :layout => 'report'
  end
end
