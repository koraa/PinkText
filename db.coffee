#
# File:   db.coffee
# Author: Karolin Varner
# Date:   7/7/2012
#
# This file provides an API for accessing and modifying the PinkText File.
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
        @b_ind = {} # Using a map here to enshure that each k occures once only

    set: (k,v,f) ->
        @b_ind[k] = v["edits"][0]["date"]
        fs.writeFile (path.join @f_entries, k), (util.format '%j', v), f

    flushIndex: ->
        si = F.dor @b_ind,
            F.PIPE ((d) -> [k,v] for k,v in d         ),
                   ((l) -> l.sort, (a,b) -> a[1]-b[1] ),
                   ((m) -> e[0] for e in m            )
        
        fs.writeFile @f_ind, (util.format '%j', si)

    init: ->
        fs.mkdir @f_loc
        fs.mkdir @f_entries

    delete: (f) ->
        fs.rmdir @loc, f
        @b_ind = {}