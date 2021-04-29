/**
 * @author Spencer Jin
 *
 * @module model/database
 * @description This module creates the sequelize object using the Sequelize ORM for the
 * purpose of database connection.
 * @requires module:sequelize
 */

'use strict';

// import { Sequelize } from 'sequelize-typescript';
import { Sequelize, Transaction } from 'sequelize';
import db_config from '../../config/db_config';

/**
 * @type {object}
 * @const
 */

const db = db_config[process.env.NODE_ENV];
sequelize = process.env.NODE_ENV === 'production'
  ? new Sequelize(db.database,
    db.username,
    db.password,
    {
      host: db.host,
      dialect: db.dialect,
      isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
      dialectOptions: {
        ssl: {
          require: true,
          rejectUnauthorized: false,
        }
      }
    })
  : new Sequelize(db.database,
    db.username,
    db.password,
    {
      host: db.host,
      dialect: db.dialect,
      isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE
    })

export { sequelize };