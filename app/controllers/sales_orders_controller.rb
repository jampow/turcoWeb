require 'ap'
class SalesOrdersController < ApplicationController

  access_control do
    allow :sales_orders_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy, :production, :save_production, :close, :reverse]
    allow :sales_orders_l, :to => [:index, :show, :default_data]
    allow :sales_orders_s, :to => []
  end

  # GET /sales_orders
  # GET /sales_orders.xml
  def index
    @sales_orders = SalesOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sales_orders }
    end
  end

  # GET /sales_orders/1
  # GET /sales_orders/1.xml
  def show
    @sales_order = SalesOrder.find(params[:id])
    @items       = @sales_order.order_items

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sales_order }
    end
  end

  # GET /sales_orders/new
  # GET /sales_orders/new.xml
  def new
    @sales_order = SalesOrder.new
    @sales_order.order_items.build
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sales_order }
    end
  end

  # GET /sales_orders/1/edit
  def edit
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.client_name = @sales_order.client.name
    default_data

    if @sales_order.closed
      flash[:notice] = "Pedido de venda fechado."
      redirect_to @sales_order
    else
      @item_form = @sales_order.order_items.build
      @grid      = OrderItem.grid @sales_order.id
    end
  end

  # POST /sales_orders
  # POST /sales_orders.xml
  def create
    @sales_order = SalesOrder.new(params[:sales_order])
    @sales_order.order_items.build

    respond_to do |format|
      if @sales_order.save
        flash[:notice] = 'Pedido de venda criado.'
        format.html { redirect_to(@sales_order) }
        format.xml  { render :xml => @sales_order, :status => :created, :location => @sales_order }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @sales_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sales_orders/1
  # PUT /sales_orders/1.xml
  def update
    @sales_order = SalesOrder.find(params[:id])

    respond_to do |format|
      if @sales_order.update_attributes(params[:sales_order])
        flash[:notice] = 'Pedido de venda atualizado.'
        format.html { redirect_to(@sales_order) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sales_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_orders/1
  # DELETE /sales_orders/1.xml
  def destroy
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.destroy

    respond_to do |format|
      format.html { redirect_to(sales_orders_url) }
      format.xml  { head :ok }
    end
  end

  def close
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.closed  = true

    respond_to do |format|
      if !@sales_order.has_production?
        flash[:notice] = 'Pedido de venda sem itens produzidos.'
        format.html { redirect_to(@sales_order) }
        format.xml  { head :ok }
      else
        if @sales_order.save
          flash[:notice] = 'Pedido de venda fechado.'
          format.html { redirect_to(@sales_order) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @sales_order.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def reverse
    @sales_order = SalesOrder.find(params[:id])
    @sales_order.reverse = true
    @sales_order.closed  = false

    respond_to do |format|
      if @sales_order.save
        flash[:notice] = 'Pedido de venda estornado.'
        format.html { redirect_to(@sales_order) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sales_order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def production
    @sales_order = SalesOrder.find(params[:id])
    render :layout => 'simple_application'
  end

  def save_production
    @sales_order = SalesOrder.find(params[:id])

    respond_to do |format|
      if @sales_order.update_attributes(params[:sales_order])
        flash[:notice] = 'Pedido de venda atualizado.'
        format.html { render :layout => 'simple_application' }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sales_order.errors, :status => :unprocessable_entity }
      end
    end
  end

protected

  def default_data
    @order_types   = SalesOrder::OrderType.to_select
    @sell_types    = SalesOrder::SellType.to_select
    @payment_forms = PaymentForm.all.collect { |p| [p.name, p.id] }
  end
end

