class ClientsController < ApplicationController

  access_control do
    allow :clients_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy, :people_photo, :print_access_card]
    allow :clients_l, :to => [:index, :show]
    allow :clients_s, :to => []
  end

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

    #TODO: substituir tabela de notas (invoices) por recibos (receipts)
    @invoices         = @client.invoices
    @receivables      = @client.receivables
    @attachments      = @client.attachments.from_client

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
    2.times {
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
    contacts = @client.contacts
    contacts.each { |contact| 2.times { contact.phones.build } }

    if contacts.length == 0
      2.times {
        contact = @client.contacts.build
        2.times { contact.phones.build }
      }
    elsif contacts.length == 1
      contact = @client.contacts.build
      2.times { contact.phones.build }
    end

    default_data
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Cliente criado'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        default_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        if params[:up_photo] == 'true'
          flash[:notice] = 'Foto atualizada.'
          format.html { render :action => "close_modal", :layout => "attachments" }
        else
          flash[:notice] = 'Cliente atualizado.'
          format.html { redirect_to(@client) }
          format.xml  { head :ok }
        end
      else
        default_data
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

  def people_photo
    @client         = Client.find(params[:id])
    render :layout => "attachments"
  end

  def print_access_card
    @contact = Person.find params[:id]
    render :layout => "report"
  end

protected

  def default_data
    @activities  = Activity.all.collect    { |a| [a.name, a.id] }
    @estate      = Estate.all.collect      { |e| [e.name, e.id] }
    @departments = DeptContact.all.collect { |d| [d.name, d.id] }
    @functions   = FuncContact.all.collect { |f| [f.name, f.id] }
  end

end

