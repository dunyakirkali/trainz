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

  $rootScope.$on 'resetCompanies', (event) ->
    $scope.resetCompanies()

  $rootScope.$on 'resetTrains', (event) ->
    $scope.resetTrains()

  $rootScope.$on 'fetchCountries', (event, bounds) ->
    $('.messages').html('loading ...')
    $.get "/countries", (data) ->
      $scope.countries = data
      $scope.$apply()
      $('.messages').html('')
    , "json"

  $rootScope.$on 'fetchCompanies', (event, bounds) ->
    $('.messages').html('loading ...')
    url = "/companies?s=" + bounds.getSouthWest().lat() + "&n=" + bounds.getNorthEast().lat() + "&w=" + bounds.getSouthWest().lng() + "&e=" + bounds.getNorthEast().lng()
    $.get url, (data) ->
      $scope.companies = data
      $scope.$apply()
      $('.messages').html('')
    , "json"

  $rootScope.$on 'fetchTrains', (event, bounds) ->
    $('.messages').html('loading ...')
    url = "/trains?s=" + bounds.getSouthWest().lat() + "&n=" + bounds.getNorthEast().lat() + "&w=" + bounds.getSouthWest().lng() + "&e=" + bounds.getNorthEast().lng()
    $.get url, (data) ->
      $scope.trains = data
      $scope.$apply()
      $('.messages').html('')
    , "json"

  $rootScope.$emit('fetchCountries')
]
