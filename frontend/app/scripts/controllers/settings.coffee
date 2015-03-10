'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:SettingsCtrl
 # @description
 # # SettingsCtrl
 # Controller of the rconApp
###
angular.module('rconApp').controller 'SettingsCtrl', ($scope, $http, $timeout, $cookieStore, ServerUrl) ->
    Names = [
        'sv_allowDownload'
        'g_gametype'
        'fraglimit'
        'timelimit'
        'capturelimit'
        'bot_minplayers'
        'bot_nochat'
    ]
    $scope.yesNos = [
        {
            id: 0
            name: 'No'
        }
        {
            id: 1
            name: 'Yes'
        }
    ]
    $scope.gametypes = [
        {
            id: 0
            name: 'Free for all'
        }
        {
            id: 1
            name: 'Tournament'
        }
        {
            id: 3
            name: 'Team Deathmatch'
        }
        {
            id: 4
            name: 'Capture the Flag'
        }
    ]
    $scope.vars = {}
    $scope.updating = {}
    $scope.updateErrors = {}
    GetValue = (name) ->
        if ! name
            name = Names.shift()
        if name
            $scope.updating[name] = true
            $http.post(
                ServerUrl
                {
                    action:"command"
                    command:name
                    ip: $cookieStore.get 'q3_ip'
                    port: $cookieStore.get 'q3_port'
                    password: $cookieStore.get 'q3_password'
                }
            )
            .success (value) ->
                $scope.updating[name] = false
                actualValue = value.match(/\d+/)
                if actualValue && actualValue.length
                    actualValue = parseInt(actualValue[0]) || 0
                    $scope.vars[name] = actualValue
                if /latched/.test value
                    $scope.restartRequired = true
                GetValue()
            .error ->
                $scope.updating[name] = false
                $scope.error = true
    GetValue()

    $scope.update = (name, value) ->
        $scope.updateErrors = {}
        $scope.updating[name] = true
        $http.post(
            ServerUrl
            {
                action:"command"
                command:name + ' ' + value
                ip: $cookieStore.get 'q3_ip'
                port: $cookieStore.get 'q3_port'
                password: $cookieStore.get 'q3_password'
            }
        )
        .success ->
            $scope.updating[name] = false
            GetValue(name)
        .error ->
            $scope.updating[name] = false
            $scope.updateErrors[name] = true

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
            $scope.restartRequired = false
            $scope.updating.g_gametype = true
            $timeout ->
                GetValue('g_gametype')
            , 4000
        .error ->
            $scope.restarting = false
            $scope.error = true