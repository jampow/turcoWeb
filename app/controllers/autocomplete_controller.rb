class AutocompleteController < ApplicationController
  #must return [ { "id": "", "label": "", "value": "" }
  #            , { "id": "", "label": "", "value": "" }]
  def client
    @list = Client.find(:all,
                        :select => "id, name as label, id as value",
                        :conditions => ["name like ?", "%#{params[:term]}%"])

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def product
    @list = Product.find(:all,
                        :select => "id, name as label, id as value",
                        :conditions => ["name like ?", "%#{params[:term]}%"])

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def autocomplete
  end

end

