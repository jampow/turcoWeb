class StIcmsController < ApplicationController
  # GET /st_icms
  # GET /st_icms.xml
  def index
    @st_icms = StIcm.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @st_icms }
    end
  end

  # GET /st_icms/1
  # GET /st_icms/1.xml
  def show
    @st_icm = StIcm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @st_icm }
    end
  end

  # GET /st_icms/new
  # GET /st_icms/new.xml
  def new
    @st_icm = StIcm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @st_icm }
    end
  end

  # GET /st_icms/1/edit
  def edit
    @st_icm = StIcm.find(params[:id])
  end

  # POST /st_icms
  # POST /st_icms.xml
  def create
    @st_icm = StIcm.new(params[:st_icm])

    respond_to do |format|
      if @st_icm.save
        flash[:notice] = 'ICMS criado.'
        format.html { redirect_to(@st_icm) }
        format.xml  { render :xml => @st_icm, :status => :created, :location => @st_icm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @st_icm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /st_icms/1
  # PUT /st_icms/1.xml
  def update
    @st_icm = StIcm.find(params[:id])

    respond_to do |format|
      if @st_icm.update_attributes(params[:st_icm])
        flash[:notice] = 'ICMS atualizado.'
        format.html { redirect_to(@st_icm) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @st_icm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /st_icms/1
  # DELETE /st_icms/1.xml
  def destroy
    @st_icm = StIcm.find(params[:id])
    @st_icm.destroy

    respond_to do |format|
      format.html { redirect_to(st_icms_url) }
      format.xml  { head :ok }
    end
  end
end
