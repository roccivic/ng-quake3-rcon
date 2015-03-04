'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MenuCtrl
 # @description
 # # MenuCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'MenuCtrl', ($scope, $location) ->
    $scope.isActive = (viewLocation) ->
        viewLocation == $location.path()