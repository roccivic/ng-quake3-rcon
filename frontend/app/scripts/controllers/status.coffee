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
    Timeout = null
    $scope.name = $cookieStore.get 'q3_name'
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
            if Timeout
                $timeout.cancel(Timeout)
            Timeout = $timeout ->
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

    $scope.map_restart = ->
        $scope.restarting = true
        $http.post(
            ServerUrl
            {
                action:"command"
                command: "map_restart"
                ip: $cookieStore.get 'q3_ip'
                port: $cookieStore.get 'q3_port'
                password: $cookieStore.get 'q3_password'
            }
        )
        .success ->
            $scope.restarting = false
        .error ->
            $scope.restarting = false
            $scope.error = true

    $scope.kicking = {}
    $scope.kick = (player) ->
        $scope.kicking[player.num] = true
        $http.post(
            ServerUrl
            {
                action:"command"
                command: "clientkick " + player.num
                ip: $cookieStore.get 'q3_ip'
                port: $cookieStore.get 'q3_port'
                password: $cookieStore.get 'q3_password'
            }
        )
        .success ->
            $scope.kicking[player.num] = false
            Status 'reloading'
        .error ->
            $scope.kicking[player.num] = false
            $scope.error = true