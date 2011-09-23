class CstIpisController < ApplicationController
  # GET /cst_ipis
  # GET /cst_ipis.xml
  def index
    @cst_ipis = CstIpi.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cst_ipis }
    end
  end

  # GET /cst_ipis/1
  # GET /cst_ipis/1.xml
  def show
    @cst_ipi = CstIpi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cst_ipi }
    end
  end

  # GET /cst_ipis/new
  # GET /cst_ipis/new.xml
  def new
    @cst_ipi = CstIpi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cst_ipi }
    end
  end

  # GET /cst_ipis/1/edit
  def edit
    @cst_ipi = CstIpi.find(params[:id])
  end

  # POST /cst_ipis
  # POST /cst_ipis.xml
  def create
    @cst_ipi = CstIpi.new(params[:cst_ipi])

    respond_to do |format|
      if @cst_ipi.save
        flash[:notice] = 'S.T. para Ipi criada.'
        format.html { redirect_to(@cst_ipi) }
        format.xml  { render :xml => @cst_ipi, :status => :created, :location => @cst_ipi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cst_ipi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cst_ipis/1
  # PUT /cst_ipis/1.xml
  def update
    @cst_ipi = CstIpi.find(params[:id])

    respond_to do |format|
      if @cst_ipi.update_attributes(params[:cst_ipi])
        flash[:notice] = 'S.T. para Ipi atualizada.'
        format.html { redirect_to(@cst_ipi) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cst_ipi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cst_ipis/1
  # DELETE /cst_ipis/1.xml
  def destroy
    @cst_ipi = CstIpi.find(params[:id])
    @cst_ipi.destroy

    respond_to do |format|
      format.html { redirect_to(cst_ipis_url) }
      format.xml  { head :ok }
    end
  end
end

