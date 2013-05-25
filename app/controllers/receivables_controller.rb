class ReceivablesController < ApplicationController

  access_control do
    allow :receivables_e, :to => [:filter_index, :index, :show, :new, :edit, :create, :update, :destroy, :print, :fast_settlement]
    allow :receivables_l, :to => [:filter_index, :index, :show, :print]
    allow :receivables_s, :to => []
  end

  def filter_index
    @filter = {:starts_at => "", :ends_at => "", :field_filter => params[:receivables][:field_filter]}

    if params[:receivables][:starts_at].blank? && params[:receivables][:ends_at].blank?
      @filter[:starts_at] = Date.today.beginning_of_month
      @filter[:ends_at]   = Date.today.end_of_month
    else
      @filter[:starts_at] = params[:receivables][:starts_at]
      @filter[:ends_at]   = params[:receivables][:ends_at]
    end

    @receivables = Receivable.grid @filter[:starts_at], @filter[:ends_at], @filter[:field_filter]

    render :index
  end

  # GET /receivables
  # GET /receivables.xml
  def index
    @filter = {:starts_at => "", :ends_at => "", :field_filter => "1"}

    params[:receivables] ||= {}
    if params[:receivables][:starts_at].blank? && params[:receivables][:ends_at].blank?
      @filter[:starts_at] = Date.today.beginning_of_month
      @filter[:ends_at]   = Date.today.end_of_month
    else
      @filter[:starts_at] = params[:receivables][:starts_at]
      @filter[:ends_at]   = params[:receivables][:ends_at]
    end

    @receivables = Receivable.grid @filter[:starts_at], @filter[:ends_at], @filter[:field_filter]

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

  def fast_settlement
    @receivable = Receivable.find params[:id]
    @receivable.fast_settlement
    flash[:notice] = 'Título quitado'

    redirect_to(@receivable)
  end
end
