'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MapsCtrl
 # @description
 # # MapsCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'MapsCtrl', ($scope, $http, $cookieStore, $location, ServerUrl) ->
    $scope.ServerUrl = ServerUrl
    $scope.loading = true
    $http.post(
        ServerUrl
        {
            action:"maps"
            ip: $cookieStore.get 'q3_ip'
            port: $cookieStore.get 'q3_port'
            password: $cookieStore.get 'q3_password'
        }
    )
    .success (maps) ->
        $scope.loading = false
        $scope.maps = maps
    .error ->
        $scope.loading = false
        $scope.error = true

    $scope.load = (map) ->
        $scope.loading = true
        $scope.loadError = false
        $http.post(
            ServerUrl
            {
                action:"command"
                command: "map " + map.name
                ip: $cookieStore.get 'q3_ip'
                port: $cookieStore.get 'q3_port'
                password: $cookieStore.get 'q3_password'
            }
        )
        .success ->
            $location.path '/status'
        .error ->
            $scope.loading = false
            $scope.loadError = true