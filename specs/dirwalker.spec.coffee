fs   = require 'fs'
util = require 'util'

dw = reqire '../dirwalker'

#######################################
# Util

#
# Add support for cascaded describes
# 
_describe = describe
describe = (p..., f) ->
    if p.length < 2
        _describe p[0], f
    else
        _describe p[0], (-> describe p[1..], f)

#
# Test for multiple datasets
# 
they = (mssg, data, arg...) ->
    if data instanceof Function
        [n, fun] = arg
        datagen = data
    else if data instanceof Array
        [fun] = arg
        n = data.length
        datagen = ((i) -> data[i])

    for i in [0..n]
        it mssg + " #" + i, (-> fun datagen i )

#######################################
# Test

describe "Dirwalker", ->