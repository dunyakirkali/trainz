trainzApp.controller 'SettingsController', ['$rootScope', '$scope', 'osmAPI', 'overpassAPI', ($rootScope, $scope, osmAPI, overpassAPI) ->
  $scope.settings = {
    country: 'Turkey',
    company: '',
    train: ''
  }
  $scope.trains = []
  $scope.companies = []
  $scope.countries = []

  $scope.displayCompany = (company) ->
    $scope.$emit('companyChanged', $scope.settings.company)

  $scope.displayCountry = () ->
    $rootScope.$emit('countryChanged', $scope.settings.country)

  $scope.resetCompanies = () ->
    $scope.companies = []

  $scope.resetTrains = () ->
    $scope.trains = []

  $scope.unique = (list) ->
    result = []
    $.each list, (i, e) ->
      if $.inArray(e, result) == -1
        result.push(e)
    result

  $rootScope.$on 'resetCompanies', (event) ->
    $scope.resetCompanies()

  $rootScope.$on 'resetTrains', (event) ->
    $scope.resetTrains()

  $rootScope.$on 'fetchCountries', (event, bounds) ->
    $('.messages').append('<p class="countries">loading countries ...</p>')
    $.get "/countries", (data) ->
      $scope.countries = data
      $scope.$apply()
      $('.messages .countries').remove()
    , "json"

  $rootScope.$on 'fetchTrains', (event, bounds) ->
    $('.messages').append('<p class="trains">loading trains ...</p>')
    $('#country-select').prop('disabled', true).trigger("chosen:updated")
    $('#company-select').prop('disabled', true).trigger("chosen:updated")
    $('#train-select').prop('disabled', true).trigger("chosen:updated")
    url = "/trains?s=" + bounds.getSouthWest().lat() + "&n=" + bounds.getNorthEast().lat() + "&w=" + bounds.getSouthWest().lng() + "&e=" + bounds.getNorthEast().lng()
    $.get url, (data) ->
      $scope.trains = data
      company_names = $.map $scope.trains, (train, index) ->
        train.tags.operator
      $scope.companies = $scope.unique(company_names)
      $scope.$apply()
      $('.messages .trains').remove()
      $('#country-select').prop('disabled', false).trigger("chosen:updated")
      $('#company-select').prop('disabled', false).trigger("chosen:updated")
      $('#train-select').prop('disabled', false).trigger("chosen:updated")
    , "json"

  $rootScope.$emit('fetchCountries')
]
