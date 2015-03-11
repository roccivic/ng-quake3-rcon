'use strict'

describe 'Filter: bytes', ->

  # load the filter's module
  beforeEach module 'rconApp'

  # initialize a new instance of the filter before each test
  bytes = {}
  beforeEach inject ($filter) ->
    bytes = $filter 'bytes'

  it 'should return the input prefixed with "bytes filter:"', ->
    text = 'angularjs'
    expect(bytes text).toBe ('bytes filter: ' + text)
