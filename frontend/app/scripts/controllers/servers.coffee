'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'MainCtrl', ($scope, $http, $cookieStore, $location, ServerUrl) ->
    $scope.loading = true
    $http.post(
        ServerUrl
        { action:"servers" }
    )
    .success (servers) ->
        $scope.loading = false
        $scope.servers = servers
    .error ->
        $scope.loading = false
        $scope.error = true

    $scope.select = (name, server) ->
        if name == $cookieStore.get 'q3_name'
            $location.path '/status'
        else
            $scope.name = name
            $scope.server = server

    $scope.back = ->
        $scope.loginError = false
        $scope.name = null
        $scope.server = null

    $scope.login = (password) ->
        $scope.loginError = false
        $scope.loading = true
        $http.post(
            ServerUrl
            {
                action:"status"
                ip: $scope.server.ip
                port: $scope.server.port
                password: password
            }
        )
        .success ->
            $cookieStore.put 'q3_name', $scope.name
            $cookieStore.put 'q3_ip', $scope.server.ip
            $cookieStore.put 'q3_port', $scope.server.port
            $cookieStore.put 'q3_password', password
            $location.path '/status'
        .error ->
            $scope.loading = false
            $scope.loginError = true