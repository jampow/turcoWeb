class AutocompleteController < ApplicationController
  #must return [ { "id": "", "label": "", "value": "" }
  #            , { "id": "", "label": "", "value": "" }]

  def account_plan
    @list = AccountPlan.find(:all,
                             :select => "id, name as label, name as value",
                             :conditions => ["name like ?", "%#{params[:term]}%"],
                             :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end  
  
  def client
    @list = Client.find(:all,
                        :select => "id, name as label, name as value",
                        :conditions => ["name like ? And active = 1", "%#{params[:term]}%"],
                        :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def cost_center
    @list = CostCenter.find(:all,
                            :select => "id, name as label, name as value",
                            :conditions => ["name like ?", "%#{params[:term]}%"],
                            :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end
  
  def measure_units
    @list = MeasureUnit.find(:all,
                             :select => "id, measure_unit as label, measure_unit as value",
                             :conditions => ["product_id = ?", params[:prod_id]],
                             :order => "measure_unit")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def product
    @list = Product.to_autocomplete params[:term]

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def provider
    @list = Provider.find(:all,
                          :select => "id, name as label, name as value",
                          :conditions => ["name like ?", "%#{params[:term]}%"],
                          :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  #renderiza
  def autocomplete
  end

end

