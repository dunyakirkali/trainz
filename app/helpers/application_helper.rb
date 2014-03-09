module ApplicationHelper
  def country_select_options
    options_for_select(Carmen::Country.all.map(&:name), Carmen::Country.all.map(&:code))
  end
  
  def company_select_options
    companies = [{
      :name => 'NS',
      :code => 'NS',
    },{
      :name => 'Arriva',
      :code => 'NS',
    },{
      :name => 'Syntus',
      :code => 'NS',
    },{
      :name => 'Connexxion',
      :code => 'NS',
    },{
      :name => 'Veolia',
      :code => 'NS',
    },{
      :name => 'RET',
      :code => 'NS',
    },{
      :name => 'HTM',
      :code => 'NS',
    },{
      :name => 'Breng',
      :code => 'NS',
    },{
      :name => 'Fyra',
      :code => 'NS',
    }]
    options_for_select(companies.map{ |c| c[:name] }, companies.map{ |c| c[:code] })
  end
end
