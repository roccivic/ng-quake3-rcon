'use strict'

###*
 # @ngdoc overview
 # @name rconApp
 # @description
 # # rconApp
 #
 # Main module of the application.
###
angular
  .module('rconApp', [
    'ngRoute'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'

