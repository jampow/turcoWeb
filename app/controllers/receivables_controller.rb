class ReceivablesController < ApplicationController

  access_control do
    allow :receivables_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :print]
    allow :receivables_l, :to => [:index, :show, :print]
    allow :receivables_s, :to => []
  end

  # GET /receivables
  # GET /receivables.xml
  def index
    @receivables = Receivable.grid

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @receivables }
    end
  end

  # GET /receivables/1
  # GET /receivables/1.xml
  def show
    @receivable = Receivable.find(params[:id])
    session[:rec_id] = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @receivable }
    end
  end

  # GET /receivables/new
  # GET /receivables/new.xml
  def new
    @receivable = Receivable.new
    @division   = ReceivableCostDivision.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @receivable }
    end
  end

  # GET /receivables/1/edit
  def edit
    @receivable = Receivable.find(params[:id])
    @receivable.client_name = Client.find(@receivable.client_id, :select => 'name').name
    @division   = ReceivableCostDivision.new
  end

  # POST /receivables
  # POST /receivables.xml
  def create
    @receivable = Receivable.new(params[:receivable])

    respond_to do |format|
      if @receivable.save
        flash[:notice] = 'Título a receber criado.'
        format.html { redirect_to(@receivable) }
        format.xml  { render :xml => @receivable, :status => :created, :location => @receivable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @receivable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /receivables/1
  # PUT /receivables/1.xml
  def update
    @receivable = Receivable.find(params[:id])

    respond_to do |format|
      if @receivable.update_attributes(params[:receivable])
        flash[:notice] = 'Título a receber atualizado.'
        format.html { redirect_to(@receivable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @receivable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /receivables/1
  # DELETE /receivables/1.xml
  def destroy
    @receivable = Receivable.find(params[:id])
    @receivable.destroy

    respond_to do |format|
      format.html { redirect_to(receivables_url) }
      format.xml  { head :ok }
    end
  end

  def print
    # @receipt = LocationReceipt.find params[:id]
    @receivable = Receivable.find params[:id]
    @location = @receivable.location
    @client = @location.client
    @enterprise = Enterprise.first
    @items = @location.location_items
    render :layout => 'report'
  end
end
