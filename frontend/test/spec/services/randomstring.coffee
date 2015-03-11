'use strict'

describe 'Service: Randomstring', ->

  # load the service's module
  beforeEach module 'rconApp'

  # instantiate service
  Randomstring = {}
  beforeEach inject (_Randomstring_) ->
    Randomstring = _Randomstring_

  it 'should do something', ->
    expect(!!Randomstring).toBe true
