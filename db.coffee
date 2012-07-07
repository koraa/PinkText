#
# File:   db.coffee
# Author: Karolin Varner
# Date:   7/7/2012
#
# This file provides an API for accessing and modifying the 
# 
##########################################################
#
# This file is part of PinkText.
#
# PinkText is free software: you can redistribute it and/or modify
# it under the terms of the Lesser GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# PinkText is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# Lesser GNU General Public License for more details.
#
# You should have received a copy of the Lesser GNU General Public License
# along with PinkText.  If not, see <http://www.gnu.org/licenses/>.
#

fs   = require 'fs'
path = require 'path'
util = require 'util'
F    = require 'F'

PinkDB
    constructor: (@f_loc) ->
        @f_ind     = path.join @f_loc, "index.json"
        @f_entries = path.join @f_loc, "entries/"
        @b_ind = {}

    set: (k,v,f) ->
        @b_ind[k] = v[date]
        fs.writeFile (path.join @f_entries, k), (util.format '%j', v)

    flushIndex: ->
        fs.writeFile @f_ind, (util.format '%j', @b_ind)

    clear: (f) ->
        fs.rmdir @loc, f
        @b_ind = {}