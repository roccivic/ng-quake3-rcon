'use strict'

###*
 # @ngdoc function
 # @name rconApp.controller:LogoutCtrl
 # @description
 # # LogoutCtrl
 # Controller of the rconApp
###
angular.module('rconApp')
.controller 'LogoutCtrl', ($scope, $cookieStore, $location) ->
    $cookieStore.remove 'q3_name'
    $cookieStore.remove 'q3_ip'
    $cookieStore.remove 'q3_port'
    $cookieStore.remove 'q3_password'
    $location.path '/servers'