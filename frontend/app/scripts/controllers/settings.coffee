'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:SettingsCtrl
 # @description
 # # SettingsCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
  .controller 'SettingsCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
