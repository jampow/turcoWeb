class AutocompleteController < ApplicationController
  #must return [ { "id": "", "label": "", "value": "" }
  #            , { "id": "", "label": "", "value": "" }]
  def client
    @list = Client.find(:all,
                        :select => "id, name as label, name as value",
                        :conditions => ["name like ?", "%#{params[:term]}%"])

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def product
    @list = Product.find(:all,
                        :select => "id, name as label, name as value",
                        :conditions => ["name like ?", "%#{params[:term]}%"])

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  #criada só pra renderizar
  def autocomplete
  end

end

