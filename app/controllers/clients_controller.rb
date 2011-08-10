class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.xml
  def index
    @clients = Client.grid
    @all_clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
      format.xls
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])
    @main_address     = @client.main_address
    @billing_address  = @client.billing_address
    @delivery_address = @client.delivery_address
    @main_contact     = @client.contacts.main[0]
    @other_contacts   = @client.contacts.others

    @invoices         = @client.invoices
    @receivables      = @client.receivables

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client                  = Client.new
    @client.main_address     = Address.new
    @client.billing_address  = Address.new
    @client.delivery_address = Address.new
    5.times {
      contact = @client.contacts.build
      2.times { contact.phones.build }
    }
    default_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])

    #Adiciona dois novos telefones pros contatos existentes
    @client.contacts.each { |contact| 2.times { contact.phones.build } }

    #Adiciona dois novos contatos com dois telefones cada um
    2.times {
      contact = @client.contacts.build
      2.times { contact.phones.build }
    }

    default_data
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    default_data

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Cliente criado'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])
    default_data

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Cliente atualizado.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end

protected

  def default_data
    @activities  = Activity.all.collect    { |a| [a.name, a.id] }
    @estate      = Estate.all.collect      { |e| [e.name, e.id] }
    @departments = DeptContact.all.collect { |d| [d.name, d.id] }
    @functions   = FuncContact.all.collect { |f| [f.name, f.id] }
  end

end

