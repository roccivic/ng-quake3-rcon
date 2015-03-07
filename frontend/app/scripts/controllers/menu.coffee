'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MenuCtrl
 # @description
 # # MenuCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'MenuCtrl', ($scope, $location, $cookieStore) ->
    $scope.isActive = (viewLocation) ->
        viewLocation == $location.path()

    $scope.isLoggedIn = ->
        !! $cookieStore.get 'q3_name'