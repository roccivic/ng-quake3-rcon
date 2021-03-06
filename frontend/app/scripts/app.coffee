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
    'ngCookies'
    'flow'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/servers',
        templateUrl: 'views/servers.html'
        controller: 'MainCtrl'
      .when '/status',
        templateUrl: 'views/status.html'
        controller: 'StatusCtrl'
      .when '/logout',
        templateUrl: 'views/logout.html'
        controller: 'LogoutCtrl'
      .when '/maps',
        templateUrl: 'views/maps.html'
      .when '/settings',
        templateUrl: 'views/settings.html'
        controller: 'SettingsCtrl'
      .otherwise
        redirectTo: '/servers'

