'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:StatusCtrl
 # @description
 # # StatusCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'StatusCtrl', ($scope, $http, $cookieStore, ServerUrl) ->
    $scope.loading = true
    $http.post(
        ServerUrl
        {
            action:"status"
            ip: $cookieStore.get 'q3_ip'
            port: $cookieStore.get 'q3_port'
            password: $cookieStore.get 'q3_password'
        }
    )
    .success (status) ->
        $scope.loading = false
        $scope.status = status
        $scope.name = $cookieStore.get 'q3_name'
    .error ->
        $scope.loading = false
        $scope.error = true

    $scope.sortColumn = '-score'
    $scope.sort = (column) ->
        if $scope.sortColumn == column
            $scope.sortColumn = '-' + column
        else
            $scope.sortColumn = column