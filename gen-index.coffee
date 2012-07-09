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
wlk  = require './dirwalker'
path = require 'path'
F    = require 'F'
_    = require 'underscore'
sys  = require 'child_process'
skv  = require 'simplekv'

module.exports.gen_index = (dir, index = path.join dir, "_index") ->
    db = new db.PinkDB index

    db.delete()
    db.init()

    wkl.walk dir, (F.ALL wlk.isFile, (F.NOT F.ARG wlk.isFile, index)), (f, r) ->
        proc = sys.exec_file './git-info.sh'

        sbuf = []
        proc.stdOut.on 'data', s -> sbuf.push s

        proc.stdOut.on 'eof', ->
            okv = skv.parse sbuf.join ''
            edits = for i in [0..okv["commit-author"].length]
                author:  okv["commit-author"][i]
                time:    okv["commit-time"  ][i]
                summary: okv["commit-time"  ][i]
            db.set r, "edits": edits

