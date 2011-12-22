class SellersController < ApplicationController
  # GET /sellers
  # GET /sellers.xml
  def index
    @sellers = Seller.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sellers }
    end
  end

  # GET /sellers/1
  # GET /sellers/1.xml
  def show
    @seller          = Seller.find(params[:id])
    @address         = @seller.address
    @credit_accounts = SellerCreditAccount.credit_accounts(params[:id])
    @invoices        = @seller.invoices

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seller }
    end
  end

  # GET /sellers/new
  # GET /sellers/new.xml
  def new
    @seller = Seller.new
    @seller.address = Address.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seller }
    end
  end

  # GET /sellers/1/edit
  def edit
    @seller = Seller.find(params[:id])
    default_data
  end

  # POST /sellers
  # POST /sellers.xml
  def create
    @seller = Seller.new(params[:seller])

    respond_to do |format|
      if @seller.save
        flash[:notice] = 'Vendedor criado.'
        format.html { redirect_to(@seller) }
        format.xml  { render :xml => @seller, :status => :created, :location => @seller }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seller.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sellers/1
  # PUT /sellers/1.xml
  def update
    @seller = Seller.find(params[:id])

    respond_to do |format|
      if @seller.update_attributes(params[:seller])
        flash[:notice] = 'Vendedor atualizado.'
        format.html { redirect_to(@seller) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seller.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.xml
  def destroy
    @seller = Seller.find(params[:id])
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to(sellers_url) }
      format.xml  { head :ok }
    end
  end

protected

  def default_data
    @estate = Estate.all.collect { |e| [e.name, e.id] }
  end
end
