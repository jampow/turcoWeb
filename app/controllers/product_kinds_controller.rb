class ProductKindsController < ApplicationController

  access_control do
    allow :product_kinds_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :product_kinds_l, :to => [:index, :show]
    allow :product_kinds_s, :to => []
  end

  # GET /product_kinds
  # GET /product_kinds.xml
  def index
    @product_kinds = ProductKind.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @product_kinds }
    end
  end

  # GET /product_kinds/1
  # GET /product_kinds/1.xml
  def show
    @product_kind = ProductKind.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product_kind }
    end
  end

  # GET /product_kinds/new
  # GET /product_kinds/new.xml
  def new
    @product_kind = ProductKind.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product_kind }
    end
  end

  # GET /product_kinds/1/edit
  def edit
    @product_kind = ProductKind.find(params[:id])
  end

  # POST /product_kinds
  # POST /product_kinds.xml
  def create
    @product_kind = ProductKind.new(params[:product_kind])

    respond_to do |format|
      if @product_kind.save
        flash[:notice] = 'Tipo de produto criado.'
        format.html { redirect_to(@product_kind) }
        format.xml  { render :xml => @product_kind, :status => :created, :location => @product_kind }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product_kind.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /product_kinds/1
  # PUT /product_kinds/1.xml
  def update
    @product_kind = ProductKind.find(params[:id])

    respond_to do |format|
      if @product_kind.update_attributes(params[:product_kind])
        flash[:notice] = 'Tipo de produto atualizado.'
        format.html { redirect_to(@product_kind) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product_kind.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /product_kinds/1
  # DELETE /product_kinds/1.xml
  def destroy
    @product_kind = ProductKind.find(params[:id])
    @product_kind.destroy

    respond_to do |format|
      format.html { redirect_to(product_kinds_url) }
      format.xml  { head :ok }
    end
  end
end

