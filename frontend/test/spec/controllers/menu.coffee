'use strict'

describe 'Controller: MenuCtrl', ->

  # load the controller's module
  beforeEach module 'rconApp'

  MenuCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MenuCtrl = $controller 'MenuCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
