class TermsController < ApplicationController

  access_control do
    allow :terms_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :terms_l, :to => [:index, :show]
    allow :terms_s, :to => []
  end

  # GET /terms
  # GET /terms.xml
  def index
    @terms = Term.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.xml
  def show
    @term = Term.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/new
  # GET /terms/new.xml
  def new
    @term = Term.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @term = Term.find(params[:id])
  end

  # POST /terms
  # POST /terms.xml
  def create
    @term = Term.new(params[:term])

    respond_to do |format|
      if @term.save
        flash[:notice] = 'Termo criado.'
        format.html { redirect_to(@term) }
        format.xml  { render :xml => @term, :status => :created, :location => @term }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1
  # PUT /terms/1.xml
  def update
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        flash[:notice] = 'Termo atualizado.'
        format.html { redirect_to(@term) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1
  # DELETE /terms/1.xml
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to(terms_url) }
      format.xml  { head :ok }
    end
  end
end

