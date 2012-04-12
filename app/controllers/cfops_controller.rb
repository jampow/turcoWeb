class CfopsController < ApplicationController

  access_control do
    allow :cfops_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :cfops_l, :to => [:index, :show]
    allow :cfops_s, :to => []
  end

  # GET /cfops
  # GET /cfops.xml
  def index
    @cfops = Cfop.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cfops }
    end
  end

  # GET /cfops/1
  # GET /cfops/1.xml
  def show
    @cfop = Cfop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cfop }
    end
  end

  # GET /cfops/new
  # GET /cfops/new.xml
  def new
    @cfop = Cfop.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cfop }
    end
  end

  # GET /cfops/1/edit
  def edit
    @cfop = Cfop.find(params[:id])
  end

  # POST /cfops
  # POST /cfops.xml
  def create
    @cfop = Cfop.new(params[:cfop])

    respond_to do |format|
      if @cfop.save
        flash[:notice] = 'Natureza de operação criada.'
        format.html { redirect_to(@cfop) }
        format.xml  { render :xml => @cfop, :status => :created, :location => @cfop }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cfop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cfops/1
  # PUT /cfops/1.xml
  def update
    @cfop = Cfop.find(params[:id])

    respond_to do |format|
      if @cfop.update_attributes(params[:cfop])
        flash[:notice] = 'Natureza de operação atualizada.'
        format.html { redirect_to(@cfop) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cfop.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cfops/1
  # DELETE /cfops/1.xml
  def destroy
    @cfop = Cfop.find(params[:id])
    @cfop.destroy

    respond_to do |format|
      format.html { redirect_to(cfops_url) }
      format.xml  { head :ok }
    end
  end
end
