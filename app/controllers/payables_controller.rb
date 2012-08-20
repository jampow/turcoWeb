class PayablesController < ApplicationController

  access_control do
    allow :payables_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :select_payables, :generate_payables, :fast_settlement]
    allow :payables_l, :to => [:index, :show]
    allow :payables_s, :to => []
  end

  # GET /payables
  # GET /payables.xml
  def index
    @payables = Payable.grid

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payables }
    end
  end

  # GET /payables/1
  # GET /payables/1.xml
  def show
    @payable = Payable.find(params[:id])
    session[:pay_id] = params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payable }
    end
  end

  # GET /payables/new
  # GET /payables/new.xml
  def new
    @payable  = Payable.new
    @division = PayableCostDivision.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @payable }
    end
  end

  # GET /payables/1/edit
  def edit
    @payable = Payable.find(params[:id])
    @payable.provider_name = Provider.find(@payable.provider_id, :select => 'name').name
    @division   = PayableCostDivision.new
  end

  # POST /payables
  # POST /payables.xml
  def create
    @payable = Payable.new(params[:payable])

    respond_to do |format|
      if @payable.save
        flash[:notice] = 'Título a pagar criado.'
        format.html { redirect_to(@payable) }
        format.xml  { render :xml => @payable, :status => :created, :location => @payable }
      else
        @division   = PayableCostDivision.new
        format.html { render :action => "new" }
        format.xml  { render :xml => @payable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /payables/1
  # PUT /payables/1.xml
  def update
    @payable = Payable.find(params[:id])

    respond_to do |format|
      if @payable.update_attributes(params[:payable])
        flash[:notice] = 'Título a pagar atualizado.'
        format.html { redirect_to(@payable) }
        format.xml  { head :ok }
      else
        @division   = PayableCostDivision.new
        format.html { render :action => "edit" }
        format.xml  { render :xml => @payable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /payables/1
  # DELETE /payables/1.xml
  def destroy
    @payable = Payable.find(params[:id])
    @payable.destroy

    respond_to do |format|
      format.html { redirect_to(payables_url) }
      format.xml  { head :ok }
    end
  end

  def select_payables
    @payables = Payable.monthly

    respond_to do |format|
      format.html # select_locations.html.erb
      format.xml  { render :xml => @locations }
    end
  end

  def generate_payables
    payables = params[:payable]
    payables[:payables].each do |pay_id|
      pay = Payable.find pay_id
      pay.duplicate
    end

    flash[:notice] = "Títulos a pagar duplicados"
    redirect_to :payables
  end

  def fast_settlement
    @payable = Payable.find params[:id]
    @payable.fast_settlement
    flash[:notice] = 'Título quitado'

    redirect_to(@payable)
  end
end
