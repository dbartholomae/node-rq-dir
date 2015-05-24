sinon = require('sinon')
chai = require('chai')
chai.use(require 'sinon-chai')
expect = chai.expect

When = require 'when'
requirejs = require('requirejs')

requirejs.config
  baseUrl: "test/"
  nodeRequire: require

path = require 'path'

expectedResults = {}
expectedResults['files' + path.sep + 'function.js'] = "This is a String"
expectedResults['files' + path.sep + 'json.js'] = {"key": "value"}
expectedResults['files' + path.sep + 'nested' + path.sep + 'json.js'] = {"key": "anotherValue"}

describe "A rq-dir plugin", ->

  describe "that is used to require modules", ->
    it "throws when the path does not exist", (done) ->
      requirejs.onError = (err) ->
        expect(err).to.have.property 'code', "ENOENT"
        done()
      requirejs ['../lib/rqDir!nonExistentDir'], -> done "Did not throw error"

    it "throws when the directory is empty", (done) ->
      requirejs.onError = (err) ->
        expect(err).to.have.property 'message', "Directory test/emptyDir is empty"
        done()
      requirejs ['../lib/rqDir!emptyDir'], -> done "Did not throw error"

    it "requires a directory", (done) ->
      requirejs.onError = done
      requirejs ['../lib/rqDir!files'], (files) ->
        expect(Object.keys(files).length).to.equal Object.keys(expectedResults).length
        for filename, content of files
          expect(content).to.deep.equal expectedResults[filename]
        done()

  describe "that is used to define a module", ->
    it "requires a directory", (done) ->
      requirejs.config
        baseUrl: ""
        nodeRequire: require
      requirejs.onError = done
      requirejs ['test/define/defineTest'], (files) ->
        expect(Object.keys(files).length).to.equal Object.keys(expectedResults).length
        for filename, content of files
          expect(content).to.deep.equal expectedResults[filename[5..]]
        done()
