class DeptContactsController < ApplicationController
  # GET /dept_contacts
  # GET /dept_contacts.xml
  def index
    @dept_contacts = DeptContact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dept_contacts }
    end
  end

  # GET /dept_contacts/1
  # GET /dept_contacts/1.xml
  def show
    @dept_contact = DeptContact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dept_contact }
    end
  end

  # GET /dept_contacts/new
  # GET /dept_contacts/new.xml
  def new
    @dept_contact = DeptContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dept_contact }
    end
  end

  # GET /dept_contacts/1/edit
  def edit
    @dept_contact = DeptContact.find(params[:id])
  end

  # POST /dept_contacts
  # POST /dept_contacts.xml
  def create
    @dept_contact = DeptContact.new(params[:dept_contact])

    respond_to do |format|
      if @dept_contact.save
        flash[:notice] = 'DeptContact was successfully created.'
        format.html { redirect_to(@dept_contact) }
        format.xml  { render :xml => @dept_contact, :status => :created, :location => @dept_contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dept_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dept_contacts/1
  # PUT /dept_contacts/1.xml
  def update
    @dept_contact = DeptContact.find(params[:id])

    respond_to do |format|
      if @dept_contact.update_attributes(params[:dept_contact])
        flash[:notice] = 'DeptContact was successfully updated.'
        format.html { redirect_to(@dept_contact) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dept_contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dept_contacts/1
  # DELETE /dept_contacts/1.xml
  def destroy
    @dept_contact = DeptContact.find(params[:id])
    @dept_contact.destroy

    respond_to do |format|
      format.html { redirect_to(dept_contacts_url) }
      format.xml  { head :ok }
    end
  end
end
