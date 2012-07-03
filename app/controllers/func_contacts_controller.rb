class FuncContactsController < ApplicationController

  access_control do
    allow :func_contacts_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :func_contacts_l, :to => [:index, :show]
    allow :func_contacts_s, :to => []
  end

  # GET /func_contacts
  # GET /func_contacts.xml
  def index
    @func_contacts = FuncContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @func_contacts }
    end
  end

  # GET /func_contacts/1
  # GET /func_contacts/1.xml
  def show
    @func_contact = FuncContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @func_contact }
    end
  end

  # GET /func_contacts/new
  # GET /func_contacts/new.xml
  def new
    @func_contact = FuncContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @func_contact }
    end
  end

  # GET /func_contacts/1/edit
  def edit
    @func_contact = FuncContact.find(params[:id])
  end

  # POST /func_contacts
  # POST /func_contacts.xml
  def create
    @func_contact = FuncContact.new(params[:func_contact])

    respond_to do |format|
      if @func_contact.save
        flash[:notice] = 'Função de contato criada.'
        format.html { redirect_to(@func_contact) }
        format.xml  { render :xml => @func_contact, :status => :created, :location => @func_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @func_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /func_contacts/1
  # PUT /func_contacts/1.xml
  def update
    @func_contact = FuncContact.find(params[:id])

    respond_to do |format|
      if @func_contact.update_attributes(params[:func_contact])
        flash[:notice] = 'Função de contato atualizada.'
        format.html { redirect_to(@func_contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @func_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /func_contacts/1
  # DELETE /func_contacts/1.xml
  def destroy
    @func_contact = FuncContact.find(params[:id])
    @func_contact.destroy

    respond_to do |format|
      format.html { redirect_to(func_contacts_url) }
      format.xml  { head :ok }
    end
  end
end

