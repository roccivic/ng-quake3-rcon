'use strict'

###*
 # @ngdoc filter
 # @name rconApp.filter:bytes
 # @function
 # @description
 # # bytes
 # Filter in the rconApp.
###
angular.module('rconApp')
.filter 'bytes', ->
    (bytes, precision) ->
        if isNaN(parseFloat(bytes)) || !isFinite(bytes) || bytes <= 0
            '-'
        else
            if typeof precision == 'undefined'
                precision = 1
            units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
            number = Math.floor(Math.log(bytes) / Math.log(1000))
            (bytes / Math.pow(1000, Math.floor(number))).toFixed(precision) +  ' ' + units[number]