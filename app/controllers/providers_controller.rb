class ProvidersController < ApplicationController

  access_control do
    allow :providers_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy]
    allow :providers_l, :to => [:index, :show, :default_data]
    allow :providers_s, :to => []
  end

  # GET /providers
  # GET /providers.xml
  def index
    @providers = Provider.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @providers }
    end
  end

  # GET /providers/1
  # GET /providers/1.xml
  def show
    @provider    = Provider.find(params[:id])
    @address     = @provider.address
    @seller      = @provider.seller_contact
    @invoicer    = @provider.invoicer_contact

    @invoices    = @provider.invoices
    @receivables = @provider.receivables
    @attachments = @provider.attachments.from_provider

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/new
  # GET /providers/new.xml
  def new
    @provider                  = Provider.new
    @provider.address          = Address.new
    @provider.seller_contact   = Contact.new
    @provider.invoicer_contact = Contact.new
    2.times {
      @provider.seller_contact.phones.build
      @provider.invoicer_contact.phones.build
    }
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @provider }
    end
  end

  # GET /providers/1/edit
  def edit
    @provider = Provider.find(params[:id])

    @provider.seller_contact   = Contact.new if @provider.seller_contact.nil?
    @provider.invoicer_contact = Contact.new if @provider.invoicer_contact.nil?

    2.times {
      @provider.seller_contact.phones.build
      @provider.invoicer_contact.phones.build
    }

    default_data
  end

  # POST /providers
  # POST /providers.xml
  def create
    @provider = Provider.new(params[:provider])

    respond_to do |format|
      if @provider.save
        flash[:notice] = 'Fornecedor criado.'
        format.html { redirect_to(@provider) }
        format.xml  { render :xml => @provider, :status => :created, :location => @provider }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /providers/1
  # PUT /providers/1.xml
  def update
    @provider = Provider.find(params[:id])

    respond_to do |format|
      if @provider.update_attributes(params[:provider])
        flash[:notice] = 'Fornecedor atualizado.'
        format.html { redirect_to(@provider) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @provider.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.xml
  def destroy
    @provider = Provider.find(params[:id])
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to(providers_url) }
      format.xml  { head :ok }
    end
  end

protected

  def default_data
    @estate = Estate.all.collect { |e| [e.name, e.id] }
    @prodcost = Provider::ProdCost.to_select
  end
end

