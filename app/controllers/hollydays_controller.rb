class HollydaysController < ApplicationController
  # GET /hollydays
  # GET /hollydays.xml
  def index
    @hollydays = Hollyday.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hollydays }
    end
  end

  # GET /hollydays/1
  # GET /hollydays/1.xml
  def show
    @hollyday = Hollyday.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hollyday }
    end
  end

  # GET /hollydays/new
  # GET /hollydays/new.xml
  def new
    @hollyday = Hollyday.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hollyday }
    end
  end

  # GET /hollydays/1/edit
  def edit
    @hollyday = Hollyday.find(params[:id])
  end

  # POST /hollydays
  # POST /hollydays.xml
  def create
    @hollyday = Hollyday.new(params[:hollyday])

    respond_to do |format|
      if @hollyday.save
        flash[:notice] = 'Hollyday was successfully created.'
        format.html { redirect_to(@hollyday) }
        format.xml  { render :xml => @hollyday, :status => :created, :location => @hollyday }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hollyday.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hollydays/1
  # PUT /hollydays/1.xml
  def update
    @hollyday = Hollyday.find(params[:id])

    respond_to do |format|
      if @hollyday.update_attributes(params[:hollyday])
        flash[:notice] = 'Hollyday was successfully updated.'
        format.html { redirect_to(@hollyday) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hollyday.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hollydays/1
  # DELETE /hollydays/1.xml
  def destroy
    @hollyday = Hollyday.find(params[:id])
    @hollyday.destroy

    respond_to do |format|
      format.html { redirect_to(hollydays_url) }
      format.xml  { head :ok }
    end
  end
end
