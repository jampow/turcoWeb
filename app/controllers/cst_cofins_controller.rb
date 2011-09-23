class CstCofinsController < ApplicationController
  # GET /cst_cofins
  # GET /cst_cofins.xml
  def index
    @cst_cofins = CstCofins.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cst_cofins }
    end
  end

  # GET /cst_cofins/1
  # GET /cst_cofins/1.xml
  def show
    @cst_cofin = CstCofins.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cst_cofin }
    end
  end

  # GET /cst_cofins/new
  # GET /cst_cofins/new.xml
  def new
    @cst_cofin = CstCofins.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cst_cofin }
    end
  end

  # GET /cst_cofins/1/edit
  def edit
    @cst_cofin = CstCofins.find(params[:id])
  end

  # POST /cst_cofins
  # POST /cst_cofins.xml
  def create
    @cst_cofin = CstCofins.new(params[:cst_cofins])

    respond_to do |format|
      if @cst_cofin.save
        flash[:notice] = 'S.T. para Cofins criada.'
        format.html { redirect_to(@cst_cofin) }
        format.xml  { render :xml => @cst_cofin, :status => :created, :location => @cst_cofin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cst_cofin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cst_cofins/1
  # PUT /cst_cofins/1.xml
  def update
    @cst_cofin = CstCofins.find(params[:id])

    respond_to do |format|
      if @cst_cofin.update_attributes(params[:cst_cofins])
        flash[:notice] = 'S.T. para Cofins atualizada.'
        format.html { redirect_to(@cst_cofin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cst_cofin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cst_cofins/1
  # DELETE /cst_cofins/1.xml
  def destroy
    @cst_cofin = CstCofins.find(params[:id])
    @cst_cofin.destroy

    respond_to do |format|
      format.html { redirect_to(cst_cofins_url) }
      format.xml  { head :ok }
    end
  end
end

