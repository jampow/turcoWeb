class AutocompleteController < ApplicationController
  #must return [ { "id": "", "label": "", "value": "" }
  #            , { "id": "", "label": "", "value": "" }]

  def account_plan
    @list = AccountPlan.find(:all,
                             :select => "id As account_plan_id, name as label, name as account_plan_name",
                             :conditions => ["name like ?", "%#{params[:term]}%"],
                             :order => "name")

    respond_to do |format|
      format.js { render :action => "autocomplete" }
    end
  end

  def car

    # Select car.id As car_id
    #      , concat(cre.name, ' - ', car.brand, ' - ', est.acronym, ' - ', car.license_plate) As label
    #      , car.license_plate As value
    # From cars     car Join
    #      carriers cre On cre.id = car.carrier_id Join
    #      estates  est On est.id = car.estate_id
    # Where car.license_plate like '%1234%'
    #    Or car.brand         like '%1324%'
    #    Or cre.name          like '%1324%'
    #    Or est.name          like '%1324%'

    @list = Car.find(:all,
                     :select => "car.id As car_id, concat(cre.name, ' - ', car.brand, ' - ', est.acronym, ' - ', car.license_plate) As label, car.license_plate As value",
                     :joins => "car Join carriers cre On cre.id = car.carrier_id Join estates est On est.id = car.estate_id",
                     :conditions => ["car.license_plate like ? Or car.brand like ? Or cre.name like ? Or est.name like ?", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%"],
                     :order => "label")

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
                        :select => "id As client_id, name as label, name as value, cnpj, cpf",
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

