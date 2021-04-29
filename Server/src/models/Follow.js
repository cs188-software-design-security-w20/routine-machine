/**
 * @author Spencer Jin
 *
 * @module model/Follow
 * @description This module contains the Javascript class representation of the Follow table
 * in the database.
 * @requires module:model/database
 * @requires module:sequelize
 * @requires module:model/User
 */

'use strict';

import { Model, DataTypes, Sequelize } from 'sequelize';
import { sequelize } from './database.js';
import User from './User';

/**
 * @class
 * @extends Sequelize.Model
 * @classdesc This class represents the Follow table. Its attributes represent columns within
 * the table.
 * @property {string} followee_id - user_id of the followee, references id of User table
 * @property {string} follower_id - user_id of the follower, references id of User table
 * @property {string} dek - followee's dek encrypted using follower's public key
 */
class Follow extends Model {}

Follow.init({
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
  },
  dek: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: false
  }
}, {
  sequelize,
  modelName: 'follow',
});

export default Follow;
