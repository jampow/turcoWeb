class BankAccountTransactionsController < ApplicationController
  # GET /bank_account_transactions
  # GET /bank_account_transactions.xml
  def index
    session[:bank_account_id] = params[:bank_account_id] if params[:bank_account_id]
    @bank_account_transactions = BankAccountTransaction.transactions(session[:bank_account_id])
    default_data

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bank_account_transactions }
    end
  end

  # GET /bank_account_transactions/1
  # GET /bank_account_transactions/1.xml
  def show
    @bank_account_transaction = BankAccountTransaction.find(params[:id])
    default_data

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bank_account_transaction }
    end
  end

  # GET /bank_account_transactions/new
  # GET /bank_account_transactions/new.xml
  def new
    @bank_account_transaction = BankAccountTransaction.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bank_account_transaction }
    end
  end

  # GET /bank_account_transactions/1/edit
  def edit
    @bank_account_transaction = BankAccountTransaction.find(params[:id])
    default_data
  end

  # POST /bank_account_transactions
  # POST /bank_account_transactions.xml
  def create
    @bank_account_transaction = BankAccountTransaction.new(params[:bank_account_transaction])
    @bank_account_transaction.bank_account_id = session[:bank_account_id]

    respond_to do |format|
      if @bank_account_transaction.save
        flash[:notice] = 'Movimentação bancária criada.'
        format.html { redirect_to(@bank_account_transaction) }
        format.xml  { render :xml => @bank_account_transaction, :status => :created, :location => @bank_account_transaction }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @bank_account_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bank_account_transactions/1
  # PUT /bank_account_transactions/1.xml
  def update
    @bank_account_transaction = BankAccountTransaction.find(params[:id])
    @bank_account_transaction.bank_account_id = session[:bank_account_id]

    respond_to do |format|
      if @bank_account_transaction.update_attributes(params[:bank_account_transaction])
        flash[:notice] = 'Movimentação bancária atualizada.'
        format.html { redirect_to(@bank_account_transaction) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bank_account_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bank_account_transactions/1
  # DELETE /bank_account_transactions/1.xml
  def destroy
    @bank_account_transaction = BankAccountTransaction.find(params[:id])
    @bank_account_transaction.destroy

    respond_to do |format|
      format.html { redirect_to(bank_account_transactions_url) }
      format.xml  { head :ok }
    end
  end
  
protected
  
  def default_data
    @bank_account = BankAccount.find(session[:bank_account_id])
  end
end
