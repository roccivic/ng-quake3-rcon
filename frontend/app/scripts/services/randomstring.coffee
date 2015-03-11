'use strict'

###*
 # @ngdoc service
 # @name rconApp.Randomstring
 # @description
 # # Randomstring
 # Service in the rconApp.
###
angular.module('rconApp')
.service 'RandomString', ->
    (length) ->
        length = length || 16
        result = []
        charSet = 'abcdefghijklmnopqrstuvwxyz0123456789'
        for i in [0..length]
            result[i] = charSet[Math.floor(Math.random() * 36)]
        result.join('')