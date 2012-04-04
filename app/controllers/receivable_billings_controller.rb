class ReceivableBillingsController < ApplicationController

  access_control do
    allow :receivable_billings_e, :to => [:index, :show, :load_receivable, :new, :edit, :create, :update, :destroy]
    allow :receivable_billings_l, :to => [:index, :show, :load_receivable]
    allow :receivable_billings_s, :to => []
  end

  before_filter :load_receivable
  # GET /receivable_billings
  # GET /receivable_billings.xml
  def index
    @receivable_billings = @receivable.billings

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /receivable_billings/1
  # GET /receivable_billings/1.xml
  def show
    @receivable_billing = @receivable.billings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /receivable_billings/new
  # GET /receivable_billings/new.xml
  def new
    @receivable_billing = @receivable.billings.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /receivable_billings/1/edit
  def edit
    @receivable_billing = @receivable.billings.find(params[:id])
  end

  # POST /receivable_billings
  # POST /receivable_billings.xml
  def create
    @receivable_billing = @receivable.billings.build(params[:receivable_billing])

    respond_to do |format|
      if @receivable_billing.save
        flash[:notice] = 'ReceivableBilling was successfully created.'
        format.html { redirect_to receivable_billings_path(@receivable_billing) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /receivable_billings/1
  # PUT /receivable_billings/1.xml
  def update
    @receivable_billing = @receivable.billings.find(params[:id])

    respond_to do |format|
      if @receivable_billing.update_attributes(params[:receivable_billing])
        flash[:notice] = 'ReceivableBilling was successfully updated.'
        format.html { redirect_to receivable_billing_path(@receivable, @receivable_billing) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /receivable_billings/1
  # DELETE /receivable_billings/1.xml
  def destroy
    @receivable_billing = @receivable.billings.find(params[:id])
    @receivable_billing.destroy

    respond_to do |format|
      format.html { redirect_to(receivable_billings_url) }
      format.xml  { head :ok }
    end
  end

  private

  def load_receivable
    @receivable = Receivable.find(params[:receivable_id])
  end
end
