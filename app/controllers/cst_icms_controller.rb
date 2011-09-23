class CstIcmsController < ApplicationController
  # GET /cst_icms
  # GET /cst_icms.xml
  def index
    @cst_icms = CstIcm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cst_icms }
    end
  end

  # GET /cst_icms/1
  # GET /cst_icms/1.xml
  def show
    @cst_icm = CstIcm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cst_icm }
    end
  end

  # GET /cst_icms/new
  # GET /cst_icms/new.xml
  def new
    @cst_icm = CstIcm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cst_icm }
    end
  end

  # GET /cst_icms/1/edit
  def edit
    @cst_icm = CstIcm.find(params[:id])
  end

  # POST /cst_icms
  # POST /cst_icms.xml
  def create
    @cst_icm = CstIcm.new(params[:cst_icm])

    respond_to do |format|
      if @cst_icm.save
        flash[:notice] = 'S.T. para Icm criada.'
        format.html { redirect_to(@cst_icm) }
        format.xml  { render :xml => @cst_icm, :status => :created, :location => @cst_icm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cst_icm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cst_icms/1
  # PUT /cst_icms/1.xml
  def update
    @cst_icm = CstIcm.find(params[:id])

    respond_to do |format|
      if @cst_icm.update_attributes(params[:cst_icm])
        flash[:notice] = 'S.T. para Icm atualizada.'
        format.html { redirect_to(@cst_icm) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cst_icm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cst_icms/1
  # DELETE /cst_icms/1.xml
  def destroy
    @cst_icm = CstIcm.find(params[:id])
    @cst_icm.destroy

    respond_to do |format|
      format.html { redirect_to(cst_icms_url) }
      format.xml  { head :ok }
    end
  end
end

