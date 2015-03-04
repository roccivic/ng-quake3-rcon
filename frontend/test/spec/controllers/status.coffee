'use strict'

describe 'Controller: StatusCtrl', ->

  # load the controller's module
  beforeEach module 'rconApp'

  StatusCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    StatusCtrl = $controller 'StatusCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
