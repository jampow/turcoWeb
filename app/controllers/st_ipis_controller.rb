class StIpisController < ApplicationController
  # GET /st_ipis
  # GET /st_ipis.xml
  def index
    @st_ipis = StIpi.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @st_ipis }
    end
  end

  # GET /st_ipis/1
  # GET /st_ipis/1.xml
  def show
    @st_ipi = StIpi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @st_ipi }
    end
  end

  # GET /st_ipis/new
  # GET /st_ipis/new.xml
  def new
    @st_ipi = StIpi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @st_ipi }
    end
  end

  # GET /st_ipis/1/edit
  def edit
    @st_ipi = StIpi.find(params[:id])
  end

  # POST /st_ipis
  # POST /st_ipis.xml
  def create
    @st_ipi = StIpi.new(params[:st_ipi])

    respond_to do |format|
      if @st_ipi.save
        flash[:notice] = 'IPI criado.'
        format.html { redirect_to(@st_ipi) }
        format.xml  { render :xml => @st_ipi, :status => :created, :location => @st_ipi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @st_ipi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /st_ipis/1
  # PUT /st_ipis/1.xml
  def update
    @st_ipi = StIpi.find(params[:id])

    respond_to do |format|
      if @st_ipi.update_attributes(params[:st_ipi])
        flash[:notice] = 'IPI atualizado.'
        format.html { redirect_to(@st_ipi) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @st_ipi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /st_ipis/1
  # DELETE /st_ipis/1.xml
  def destroy
    @st_ipi = StIpi.find(params[:id])
    @st_ipi.destroy

    respond_to do |format|
      format.html { redirect_to(st_ipis_url) }
      format.xml  { head :ok }
    end
  end
end
