class SellerCreditAccountsController < ApplicationController

  access_control do
    allow :seller_credit_accounts_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy]
    allow :seller_credit_accounts_l, :to => [:index, :show, :default_data]
    allow :seller_credit_accounts_s, :to => []
  end

  # GET /seller_credit_accounts
  # GET /seller_credit_accounts.xml
  def index
    session[:seller_id] = params[:seller_id] if params[:seller_id]
    @seller_credit_accounts = SellerCreditAccount.find(:all, :conditions => ['seller_id = ?', session[:seller_id]])
    default_data

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seller_credit_accounts }
    end
  end

  # GET /seller_credit_accounts/1
  # GET /seller_credit_accounts/1.xml
  def show
    @seller_credit_account = SellerCreditAccount.find(params[:id])
    default_data

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seller_credit_account }
    end
  end

  # GET /seller_credit_accounts/new
  # GET /seller_credit_accounts/new.xml
  def new
    @seller_credit_account = SellerCreditAccount.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seller_credit_account }
    end
  end

  # GET /seller_credit_accounts/1/edit
  def edit
    @seller_credit_account = SellerCreditAccount.find(params[:id])
  end

  # POST /seller_credit_accounts
  # POST /seller_credit_accounts.xml
  def create
    @seller_credit_account = SellerCreditAccount.new(params[:seller_credit_account])
    @seller_credit_account.seller_id = session[:seller_id]

    respond_to do |format|
      if @seller_credit_account.save
        flash[:notice] = 'Movimento lançado.'
        format.html { redirect_to(@seller_credit_account) }
        format.xml  { render :xml => @seller_credit_account, :status => :created, :location => @seller_credit_account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seller_credit_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seller_credit_accounts/1
  # PUT /seller_credit_accounts/1.xml
  def update
    @seller_credit_account = SellerCreditAccount.find(params[:id])
    @seller_credit_account.seller_id = session[:seller_id]

    respond_to do |format|
      if @seller_credit_account.update_attributes(params[:seller_credit_account])
        flash[:notice] = 'Movimento alterado.'
        format.html { redirect_to(@seller_credit_account) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seller_credit_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seller_credit_accounts/1
  # DELETE /seller_credit_accounts/1.xml
  def destroy
    @seller_credit_account = SellerCreditAccount.find(params[:id])
    @seller_credit_account.destroy

    respond_to do |format|
      format.html { redirect_to(seller_credit_accounts_url) }
      format.xml  { head :ok }
    end
  end
  
protected

  def default_data
    @seller = Seller.find(session[:seller_id])
    
  end
end
