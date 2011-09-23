class CstPisController < ApplicationController
  # GET /cst_pis
  # GET /cst_pis.xml
  def index
    @cst_pis = CstPis.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cst_pis }
    end
  end

  # GET /cst_pis/1
  # GET /cst_pis/1.xml
  def show
    @cst_pi = CstPis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cst_pi }
    end
  end

  # GET /cst_pis/new
  # GET /cst_pis/new.xml
  def new
    @cst_pi = CstPis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cst_pi }
    end
  end

  # GET /cst_pis/1/edit
  def edit
    @cst_pi = CstPis.find(params[:id])
  end

  # POST /cst_pis
  # POST /cst_pis.xml
  def create
    @cst_pi = CstPis.new(params[:cst_pis])

    respond_to do |format|
      if @cst_pi.save
        flash[:notice] = 'S.T. para Pis criada.'
        format.html { redirect_to(@cst_pi) }
        format.xml  { render :xml => @cst_pi, :status => :created, :location => @cst_pi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cst_pi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cst_pis/1
  # PUT /cst_pis/1.xml
  def update
    @cst_pi = CstPis.find(params[:id])

    respond_to do |format|
      if @cst_pi.update_attributes(params[:cst_pis])
        flash[:notice] = 'S.T. para Pis atualizada.'
        format.html { redirect_to(@cst_pi) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cst_pi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cst_pis/1
  # DELETE /cst_pis/1.xml
  def destroy
    @cst_pi = CstPis.find(params[:id])
    @cst_pi.destroy

    respond_to do |format|
      format.html { redirect_to(cst_pis_url) }
      format.xml  { head :ok }
    end
  end
end

