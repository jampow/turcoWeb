class ContractsController < ApplicationController
  # GET /contracts
  # GET /contracts.xml
  def index
    @contracts = Contract.grid

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.xml
  def show
    @contract = Contract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/new
  # GET /contracts/new.xml
  def new
    @contract = Contract.new
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contract }
    end
  end

  # GET /contracts/1/edit
  def edit
    @contract = Contract.find(params[:id])
    default_data
  end

  # POST /contracts
  # POST /contracts.xml
  def create
    @contract = Contract.new(params[:contract])

    respond_to do |format|
      if @contract.save
        flash[:notice] = 'Cláusula criada.'
        format.html { redirect_to(@contract) }
        format.xml  { render :xml => @contract, :status => :created, :location => @contract }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contracts/1
  # PUT /contracts/1.xml
  def update
    @contract = Contract.find(params[:id])

    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        flash[:notice] = 'Cláusula alterada.'
        format.html { redirect_to(@contract) }
        format.xml  { head :ok }
      else
        default_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contract.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.xml
  def destroy
    @contract = Contract.find(params[:id])
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to(contracts_url) }
      format.xml  { head :ok }
    end
  end

protected
  def default_data
    @clauses   = Contract.grid.collect { |c| [c.ordenator + ' - ' + c.text[0..70], c.id] }
    @listtypes = Contract::ListTypes.to_select
  end
end
