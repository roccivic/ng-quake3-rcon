'use strict'

describe 'Controller: MapsCtrl', ->

  # load the controller's module
  beforeEach module 'rconApp'

  MapsCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MapsCtrl = $controller 'MapsCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
