class StocksController < ApplicationController

  access_control do
    allow :stocks_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :stocks_l, :to => [:index, :show]
    allow :stocks_s, :to => []
  end

  # GET /stocks
  # GET /stocks.xml
  def index
    session[:product] = params[:product] if params[:product]
    @stocks = Stock.product session[:product]
    default_data

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stocks }
    end
  end

  # GET /stocks/1
  # GET /stocks/1.xml
  def show
    @stock = Stock.find(params[:id])
    default_data

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.xml
  def new
    @stock = Stock.new
    default_data
    @main_unit = MeasureUnit.find_main(session[:product]).first
    @last = Stock.last_movimentation(session[:product]).first
    @measure_units = MeasureUnit.by_product session[:product]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @stock }
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
    default_data
  end

  # POST /stocks
  # POST /stocks.xml
  def create
    @stock = Stock.new(params[:stock])
    @stock.product_id = session[:product]

    respond_to do |format|
      if @stock.save
        flash[:notice] = 'Movimentação criada.'
        format.html { redirect_to(@stock) }
        format.xml  { render :xml => @stock, :status => :created, :location => @stock }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stocks/1
  # PUT /stocks/1.xml
  def update
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        flash[:notice] = 'Movimentação atualizada.'
        format.html { redirect_to(@stock) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @stock.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.xml
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to(stocks_url) }
      format.xml  { head :ok }
    end
  end
  
protected

  def default_data
    @measure_select = MeasureUnit.all(:conditions => ["product_id = ?", session[:product]]).collect { |mu| [mu.measure_unit, mu.id]}
    @product = Product.find(session[:product])
  end
end
