class ProductsController < ApplicationController

  access_control do
    allow :products_e, :to => [:index, :show, :default_data, :new, :edit, :create, :update, :destroy]
    allow :products_l, :to => [:index, :show, :default_data]
    allow :products_s, :to => []
  end

  # GET /products
  # GET /products.xml
  def index
    @products = Product.grid

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product     = Product.find(params[:id])
    @attachments = @product.attachments.from_product

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    default_data
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    default_data
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Produto criado.'
        format.html { redirect_to(@product) }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Produto salvo.'
        format.html { redirect_to(@product) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

protected

  def default_data
    @product_kinds    = ProductKind.all.collect   { |a| [a.name, a.id] }
    @product_families = ProductFamily.all.collect { |a| [a.name, a.id] }
    @cst_cofins       = CstCofins.all.collect     { |a| [a.code + ' - ' + a.description, a.id] }
    @cst_icm          = CstIcm.all.collect        { |a| [a.code + ' - ' + a.description, a.id] }
    @cst_ipi          = CstIpi.all.collect        { |a| [a.code + ' - ' + a.description, a.id] }
    @cst_pis          = CstPis.all.collect        { |a| [a.code + ' - ' + a.description, a.id] }
  end
end

