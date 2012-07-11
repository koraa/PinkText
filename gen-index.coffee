#
# File:   gen-index.coffee
# Author: Karolin Varner
# Date:   7/1/2012
#
# This file contains an API to generate the json index for PinkText.
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

db   = require './db'
fs2  = require './fs2'
path = require 'path'
F    = require 'F'
_    = require 'underscore'
sys  = require 'child_process'
skv  = require 'simplekv'

gen_index = (dir, index = (path.join dir, "_index"), data=(path.join index, "data")) ->
    db = new db.PinkDB index

    db.delete()
    db.init()

    fs2.cp dir, data

    stack = 0
    fs2.walk dir, ((f) -> fs2.isFile(f) && !fs2.fileMatch index, f), (f, r) ->
        stack++
        proc = sys.exec './git-info.sh #{f}',F.NOERR (stdout) ->
            okv = skv.parse stdout 
            edits = for i in [0..okv["commit-author"].length]
                author:  okv["commit-author" ][i]
                time:    okv["commit-time"   ][i]
                summary: okv["commit-message"][i]
            db.set r, "edits": edits

            stack--
            if stack <= 0
                db.flushIndex()

###############################
# Exports

module.exports.gen_index = gen_index
