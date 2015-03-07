'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:StatusCtrl
 # @description
 # # StatusCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'StatusCtrl', ($scope, $http, $cookieStore, $timeout, ServerUrl) ->
    Status = (variable) ->
        $scope[variable] = true
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
            $scope[variable] = false
            $scope.status = status
            $scope.name = $cookieStore.get 'q3_name'
            $timeout ->
                Status 'reloading'
            , 10000
        .error ->
            $scope[variable] = false
            $scope.error = true

    Status 'loading'

    $scope.sortColumn = '-score'
    $scope.sort = (column) ->
        if $scope.sortColumn == column
            $scope.sortColumn = '-' + column
        else
            $scope.sortColumn = column