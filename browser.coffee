#
# File:   browser.coffee
# Author: Karolin Varner
# Date:   7/11/2012
#
# This file provides an API for accessing the PinkDB in a browser enviroment 
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

class PinkDB
    constructor: (@f_loc) ->
        @f_ind     = @f_loc + "/index.json"
        @f_entries = @f_loc + "/entries/"
        @f_data    = @f_loc + "/data/"

    get: (k, f) ->
         $.getJSON @f_entries + "/" + k, f
   
    data: (k, f) ->
        $.load @f_data + "/" + k, f

    index: (f) ->
           $.getJSON @f_ind, f

