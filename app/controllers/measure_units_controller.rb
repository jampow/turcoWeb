class MeasureUnitsController < ApplicationController
  # GET /measure_units
  # GET /measure_units.xml
  def index
    session[:product] = params[:product] if params[:product] 
    @measure_units = MeasureUnit.all :conditions => ["product_id = ?", session[:product]]
    default_data

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @measure_units }
    end
  end

  # GET /measure_units/1
  # GET /measure_units/1.xml
  def show
    @measure_unit = MeasureUnit.find(params[:id])
    default_data

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @measure_unit }
    end
  end

  # GET /measure_units/new
  # GET /measure_units/new.xml
  def new
    @measure_unit = MeasureUnit.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @measure_unit }
    end
  end

  # GET /measure_units/1/edit
  def edit
    @measure_unit = MeasureUnit.find(params[:id])
    default_data
  end

  # POST /measure_units
  # POST /measure_units.xml
  def create
    @measure_unit = MeasureUnit.new(params[:measure_unit])
    @measure_unit.product_id = session[:product]

    respond_to do |format|
      if @measure_unit.save
        flash[:notice] = 'Unidade de medida criada.'
        format.html { redirect_to(@measure_unit) }
        format.xml  { render :xml => @measure_unit, :status => :created, :location => @measure_unit }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @measure_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /measure_units/1
  # PUT /measure_units/1.xml
  def update
    @measure_unit = MeasureUnit.find(params[:id])

    respond_to do |format|
      if @measure_unit.update_attributes(params[:measure_unit])
        flash[:notice] = 'Unidade de medida atualizada.'
        format.html { redirect_to(@measure_unit) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @measure_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /measure_units/1
  # DELETE /measure_units/1.xml
  def destroy
    @measure_unit = MeasureUnit.find(params[:id])
    @measure_unit.destroy

    respond_to do |format|
      format.html { redirect_to(measure_units_url) }
      format.xml  { head :ok }
    end
  end
  
protected

  def default_data
    @product = Product.find(session[:product])
  end
end
