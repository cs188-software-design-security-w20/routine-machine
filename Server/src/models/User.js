/**
 * @author Spencer Jin
 *
 * @module model/User
 * @description This module contains the Javascript class representation of the User table
 * in the database.
 * @requires module:model/database
 * @requires module:sequelize
 */

'use strict';

import { Model, DataTypes } from 'sequelize';
import { sequelize } from './database';

/**
 * @class
 * @extends Sequelize.Model
 * @classdesc This class represents the User table. Its attributes represent columns within
 * the table.
 * @property {string} id - A unique identifier (primary key) for a user
 * @property {string} public_key - public key used to encrypt the User DEK
 * @property {string} first_name - user first name
 * @property {string} last_name - user first name
 * @property {JSON} profile - user profile data in json
 * @property {string} habit_data - Encrypted habit data (json encrypted)
 */

class User extends Model {}

User.init({
  id: {
    type: DataTypes.STRING,
    primaryKey: true,
    unique: true,
    allowNull: false,
  },
  public_key: {
    type: DataTypes.STRING,
    unique: true,
    allowNull: false,
  },
  first_name: {
    type: DataTypes.STRING,
    unique: false,
    allowNull: false
  },
  last_name: {
    type: DataTypes.STRING,
    unique: false,
    allowNull: false
  },
  profile: {
    type: DataTypes.JSON,
    unique: false,
    allowNull: true
  },
  habit_data: {
    type: DataTypes.STRING,
    unique: false,
    allowNull: true
  }
}, {
  modelName: 'user',
  sequelize,
});

export default User;
