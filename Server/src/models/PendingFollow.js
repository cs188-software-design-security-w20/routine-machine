/**
 * @author Spencer Jin
 *
 * @module model/User
 * @description This module contains the Javascript class representation of the PendingFollow table
 * in the database.
 * @requires module:model/database
 * @requires module:sequelize
 */

'use strict';

import { Model, DataTypes, Sequelize } from 'sequelize';
import { sequelize } from './database.js';
import User from './User';

/**
 * @class
 * @extends Sequelize.Model
 * @classdesc This class represents the PendingFollow table. Its attributes represent columns within
 * the table.
 * @property {string} followee_id - id of the user who would approve this pending follow
 * @property {string} follower_id - id of the user who created this pending follow
 */
class PendingFollow extends Model {}

PendingFollow.init({
  followee_id: {
    type: DataTypes.STRING,
    allowNull: false,
    references: {
      model: User,
      key: 'id',
      deffereable: Sequelize.Deferrable.INITIALLY_IMMEDIATE
    }
  },
  follower_id: {
    type: DataTypes.STRING,
    allowNull: false,
    references: {
      model: User,
      key: 'id',
      deffereable: Sequelize.Deferrable.INITIALLY_IMMEDIATE
    }
  }
}, {
  sequelize,
  modelName: 'pending_follow',
});

export default PendingFollow;
