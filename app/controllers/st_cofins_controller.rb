class StCofinsController < ApplicationController

  access_control do
    allow :st_cofins_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :st_cofins_l, :to => [:index, :show]
    allow :st_cofins_s, :to => []
  end

  # GET /st_cofins
  # GET /st_cofins.xml
  def index
    @st_cofins = StCofin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @st_cofins }
    end
  end

  # GET /st_cofins/1
  # GET /st_cofins/1.xml
  def show
    @st_cofin = StCofin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @st_cofin }
    end
  end

  # GET /st_cofins/new
  # GET /st_cofins/new.xml
  def new
    @st_cofin = StCofin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @st_cofin }
    end
  end

  # GET /st_cofins/1/edit
  def edit
    @st_cofin = StCofin.find(params[:id])
  end

  # POST /st_cofins
  # POST /st_cofins.xml
  def create
    @st_cofin = StCofin.new(params[:st_cofin])

    respond_to do |format|
      if @st_cofin.save
        flash[:notice] = 'Cofins criado.'
        format.html { redirect_to(@st_cofin) }
        format.xml  { render :xml => @st_cofin, :status => :created, :location => @st_cofin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @st_cofin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /st_cofins/1
  # PUT /st_cofins/1.xml
  def update
    @st_cofin = StCofin.find(params[:id])

    respond_to do |format|
      if @st_cofin.update_attributes(params[:st_cofin])
        flash[:notice] = 'Cofins atualizado.'
        format.html { redirect_to(@st_cofin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @st_cofin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /st_cofins/1
  # DELETE /st_cofins/1.xml
  def destroy
    @st_cofin = StCofin.find(params[:id])
    @st_cofin.destroy

    respond_to do |format|
      format.html { redirect_to(st_cofins_url) }
      format.xml  { head :ok }
    end
  end
end
