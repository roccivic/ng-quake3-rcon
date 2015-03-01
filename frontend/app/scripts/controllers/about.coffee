'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
