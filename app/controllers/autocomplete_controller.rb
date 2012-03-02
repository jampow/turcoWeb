class AutocompleteController < ApplicationController
  #must return [ { "id": "", "label": "", "value": "" }
  #            , { "id": "", "label": "", "value": "" }]

  def account_plan
    @list = AccountPlan.find(:all,
                             :select => "id As account_plan_id, name as label, name as value",
                             :conditions => ["name like ?", "%#{params[:term]}%"],
                             :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def city
    @list = City.find(:all,
                      :select => "id As city_id, concat(estate_acronym, ' - ', name) As label, name As value",
                      :conditions => ["name like ?", "%#{params[:term]}%"],
                      :order => "estate_acronym, name"  )

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end
  
  def client
    @list = Client.find(:all,
                        :select => "id As client_id, name as label, name as value",
                        :conditions => ["name like ? And active = 1", "%#{params[:term]}%"],
                        :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def cost_center
    @list = CostCenter.find(:all,
                            :select => "id As cost_center_id, name as label, name as value",
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
    #client_id para o pedido de compras porque o model herda de order, e lá só tem client_id
    @list = Provider.find(:all,
                          :select => "id As provider_id, id As client_id, name as label, name as value",
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

