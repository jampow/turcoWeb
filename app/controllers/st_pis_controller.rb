class StPisController < ApplicationController
  # GET /st_pis
  # GET /st_pis.xml
  def index
    @st_pis = StPi.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @st_pis }
    end
  end

  # GET /st_pis/1
  # GET /st_pis/1.xml
  def show
    @st_pi = StPi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @st_pi }
    end
  end

  # GET /st_pis/new
  # GET /st_pis/new.xml
  def new
    @st_pi = StPi.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @st_pi }
    end
  end

  # GET /st_pis/1/edit
  def edit
    @st_pi = StPi.find(params[:id])
  end

  # POST /st_pis
  # POST /st_pis.xml
  def create
    @st_pi = StPi.new(params[:st_pi])

    respond_to do |format|
      if @st_pi.save
        flash[:notice] = 'PIS criado.'
        format.html { redirect_to(@st_pi) }
        format.xml  { render :xml => @st_pi, :status => :created, :location => @st_pi }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @st_pi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /st_pis/1
  # PUT /st_pis/1.xml
  def update
    @st_pi = StPi.find(params[:id])

    respond_to do |format|
      if @st_pi.update_attributes(params[:st_pi])
        flash[:notice] = 'PIS atualizado.'
        format.html { redirect_to(@st_pi) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @st_pi.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /st_pis/1
  # DELETE /st_pis/1.xml
  def destroy
    @st_pi = StPi.find(params[:id])
    @st_pi.destroy

    respond_to do |format|
      format.html { redirect_to(st_pis_url) }
      format.xml  { head :ok }
    end
  end
end
