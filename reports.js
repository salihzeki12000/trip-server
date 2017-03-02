/**
 * @license TRIP - Trip Recording and Itinerary Planning application.
 * (c) 2016, 2017 Frank Dean <frank@fdsd.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
'use strict';

var winston = require('winston');

var db = require('./db');
var utils = require('./utils');

module.exports = {
  getSystemStatus: getSystemStatus
};

function getSystemStatus(callback) {
  callback = typeof callback === 'function' ? callback : function() {};
  db.getTileCount(function(err, result) {
    if (utils.handleError(err, callback)) {
      callback(err, {tileUsage: result});
    }
  });
}
