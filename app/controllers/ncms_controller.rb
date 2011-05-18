class NcmsController < ApplicationController
  has_mobile_fu

  access_control do
    allow :ncms_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :ncms_l, :to => [:index, :show]
    allow :ncms_s, :to => []
  end

  #layout nil

  # GET /ncms
  # GET /ncms.xml
  def index
    @ncms = Ncm.all

    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.xml  { render :xml => @ncms }
    end
  end

  # GET /ncms/1
  # GET /ncms/1.xml
  def show
    @ncm = Ncm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.mobile
      format.xml  { render :xml => @ncm }
    end
  end

  # GET /ncms/new
  # GET /ncms/new.xml
  def new
    @ncm = Ncm.new

    respond_to do |format|
      format.html # new.html.erb
      #format.mobile
      format.xml  { render :xml => @ncm }
    end
  end

  # GET /ncms/1/edit
  def edit
    @ncm = Ncm.find(params[:id])
  end

  # POST /ncms
  # POST /ncms.xml
  def create
    @ncm = Ncm.new(params[:ncm])

    respond_to do |format|
      if @ncm.save
        flash[:notice] = 'Novo NCM criado.'
        format.html   { redirect_to(@ncm) }
        #format.mobile { redirect_to(@ncm) }
        format.xml    { render :xml => @ncm, :status => :created, :location => @ncm }
      else
        format.html   { render :action => "new" }
        #format.mobile { render :action => "new" }
        format.xml    { render :xml => @ncm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ncms/1
  # PUT /ncms/1.xml
  def update
    @ncm = Ncm.find(params[:id])

    respond_to do |format|
      if @ncm.update_attributes(params[:ncm])
        flash[:notice] = 'NCM Alterado.'
        format.html   { redirect_to(@ncm) }
        #format.mobile { redirect_to(@ncm) }
        format.xml    { head :ok }
      else
        format.html   { render :action => "edit" }
        #format.mobile { render :action => "edit" }
        format.xml    { render :xml => @ncm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ncms/1
  # DELETE /ncms/1.xml
  def destroy
    @ncm = Ncm.find(params[:id])
    @ncm.destroy

    respond_to do |format|
      format.html   { redirect_to(ncms_url) }
      #format.mobile { redirect_to(ncms_url) }
      format.xml    { head :ok }
    end
  end
end

