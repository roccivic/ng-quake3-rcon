'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
