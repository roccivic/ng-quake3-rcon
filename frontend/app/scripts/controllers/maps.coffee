'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:MapsCtrl
 # @description
 # # MapsCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'MapsCtrl', ($scope, $http, $cookieStore, $location, ServerUrl, RandomString) ->
    $scope.name = $cookieStore.get 'q3_name'
    $scope.keyword = ''
    $scope.ServerUrl = ServerUrl
    $scope.uploadQueue = RandomString()
    $scope.flowConfig = {
        target: ServerUrl + 'upload.php'
        query:
            uploadQueue: $scope.uploadQueue
    }
    $scope.progress = (file) ->
        Math.round(file.progress()*100)
    $scope.installing = {}
    $scope.installed = {}
    $scope.failedToInstall = {}
    $scope.$on 'flow::fileAdded', (event, $flow, flowFile) ->
        flowFile.uploadQueue = $scope.uploadQueue
        flowFile.originalName = flowFile.name
        flowFile.name = RandomString()
        if flowFile.size > 30*1024*1024
            event.preventDefault()
            alert 'File too big'
        else if $flow.files.length > 5
            event.preventDefault()
            alert 'Too many files'
        else
            parts = flowFile.originalName.split('.')
            if parts.length >= 1
                extension = parts.pop().toLowerCase()
            if extension != 'pk3'
                event.preventDefault()
                alert 'Invalid filetype: only pk3 files are supported'
    $scope.$on 'flow::fileSuccess', (event, $flow, flowFile) ->
        $scope.installing[flowFile.name] = flowFile
        $http.post(
            ServerUrl
            {
                action:"install"
                name: flowFile.name
                originalName: flowFile.originalName
                uploadQueue: flowFile.uploadQueue
                ip: $cookieStore.get 'q3_ip'
                port: $cookieStore.get 'q3_port'
                password: $cookieStore.get 'q3_password'
            }
        )
        .success ->
            GetMaps('reloading')
            delete $scope.installing[flowFile.name]
            $scope.installed[flowFile.name] = flowFile
        .error ->
            delete $scope.installing[flowFile.name]
            $scope.failedToInstall[flowFile.name] = flowFile

    GetMaps = (variable) ->
        if ! variable
            variable = 'loading'
        $scope[variable] = true
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
            $scope[variable] = false
            $scope.maps = maps
        .error ->
            $scope[variable] = false
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

    $scope.dismiss = (flowFile) ->
        flowFile.cancel()
        if $scope.installed[flowFile.name]
            delete $scope.installed[flowFile.name]
        else if $scope.failedToInstall[flowFile.name]
            delete $scope.failedToInstall[flowFile.name]

    $scope.needBr = ->
        !! (Object.keys($scope.installing).length +
        Object.keys($scope.installed).length +
        Object.keys($scope.failedToInstall).length)

    $scope.notEmpty = (obj) ->
        !! Object.keys(obj).length

    GetMaps()