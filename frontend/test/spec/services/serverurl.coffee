'use strict'

describe 'Service: ServerUrl', ->

  # load the service's module
  beforeEach module 'rconApp'

  # instantiate service
  ServerUrl = {}
  beforeEach inject (_ServerUrl_) ->
    ServerUrl = _ServerUrl_

  it 'should do something', ->
    expect(!!ServerUrl).toBe true
