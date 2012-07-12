class PayableBillingsController < ApplicationController

  access_control do
    allow :payable_billings_e, :to => [:index, :show, :load_payable, :new, :edit, :create, :update, :destroy]
    allow :payable_billings_l, :to => [:index, :show, :load_payable]
    allow :payable_billings_s, :to => []
  end

  # GET /payable_billings
  # GET /payable_billings.xml
  def index
    session[:pay_id] = params[:id] if params[:id]
    @payable_billings = PayableBilling.find(:all, :conditions => ['payable_id = ?', session[:pay_id]])

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /payable_billings/1
  # GET /payable_billings/1.xml
  def show
    @payable_billing = PayableBilling.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /payable_billings/new
  # GET /payable_billings/new.xml
  def new
    if Payable.find(session[:pay_id]).settled
      flash[:notice] = "Cobrança já está quitada"
      redirect_to "/payable_billings/?id=#{session[:pay_id]}"
    end
    @payable_billing = PayableBilling.new
    @payable_billing.payable_id = session[:pay_id]
    @payable_billing.provider_id     = Payable.find(session[:pay_id]).provider_id

    # respond_to do |format|
    #   format.html # new.html.erb
    # end
  end

  # GET /payable_billings/1/edit
  def edit
    @payable_billing = PayableBilling.find(params[:id])
  end

  # POST /payable_billings
  # POST /payable_billings.xml
  def create
    @payable_billing = PayableBilling.new(params[:payable_billing])

    respond_to do |format|
      if @payable_billing.save
        flash[:notice] = 'Pagamento criado.'
        format.html { redirect_to(@payable_billing) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /payable_billings/1
  # PUT /payable_billings/1.xml
  def update
    @payable_billing = PayableBilling.find(params[:id])

    respond_to do |format|
      if @payable_billing.update_attributes(params[:payable_billing])
        flash[:notice] = 'Pagamento atualizado.'
        format.html { redirect_to(@payable_billing) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /payable_billings/1
  # DELETE /payable_billings/1.xml
  def destroy
    @payable_billing = PayableBilling.find(params[:id])
    @payable_billing.destroy

    respond_to do |format|
      format.html { redirect_to(payable_billings_url) }
      format.xml  { head :ok }
    end
  end

end
