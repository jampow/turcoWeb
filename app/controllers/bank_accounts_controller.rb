class BankAccountsController < ApplicationController

  access_control do
    allow :bank_accounts_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy]
    allow :bank_accounts_l, :to => [:index, :show, :default_data]
    allow :bank_accounts_s, :to => []
  end
  
  # GET /bank_accounts
  # GET /bank_accounts.xml
  def index
    @bank_accounts = BankAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bank_accounts }
    end
  end

  # GET /bank_accounts/1
  # GET /bank_accounts/1.xml
  def show
    @bank_account = BankAccount.find(params[:id])
    @address = @bank_account.address

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bank_account }
    end
  end

  # GET /bank_accounts/new
  # GET /bank_accounts/new.xml
  def new
    @bank_account = BankAccount.new
    @bank_account.address = Address.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bank_account }
    end
  end

  # GET /bank_accounts/1/edit
  def edit
    @bank_account = BankAccount.find(params[:id])
    default_data
  end

  # POST /bank_accounts
  # POST /bank_accounts.xml
  def create
    @bank_account = BankAccount.new(params[:bank_account])

    respond_to do |format|
      if @bank_account.save
        flash[:notice] = 'Conta bancária criada.'
        format.html { redirect_to(@bank_account) }
        format.xml  { render :xml => @bank_account, :status => :created, :location => @bank_account }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @bank_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bank_accounts/1
  # PUT /bank_accounts/1.xml
  def update
    @bank_account = BankAccount.find(params[:id])

    respond_to do |format|
      if @bank_account.update_attributes(params[:bank_account])
        flash[:notice] = 'Conta bancária atualizada.'
        format.html { redirect_to(@bank_account) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bank_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_accounts/1
  # DELETE /bank_accounts/1.xml
  def destroy
    @bank_account = BankAccount.find(params[:id])
    @bank_account.destroy

    respond_to do |format|
      format.html { redirect_to(bank_accounts_url) }
      format.xml  { head :ok }
    end
  end
  
protected
  
  def default_data
    @estate = Estate.all.collect { |e| [e.name, e.id] }
  end
    
end
