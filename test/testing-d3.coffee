require 'fluentnode'
d3      = require 'd3'
jsdom   = require "jsdom"
express = require 'express'

describe 'testing d3', ->
  it 'checking dependencies', ->
    d3.version.assert_Is '3.5.17'
    jsdom.debugMode.assert_Is_False()
    express.Router.assert_Is_Function()

  it 'creating svg element', ->
    document = jsdom.jsdom()
    svg = d3.select(document.body).append("svg");
    svg[0].parentNode.assert_Is {}
