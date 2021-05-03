/**
 * @author Spencer Jin
 *
 * @module model/database
 * @description This module creates the sequelize object using the Sequelize ORM for the
 * purpose of database connection.
 * @requires module:sequelize
 */

import { Sequelize } from 'sequelize-typescript';
import path from 'path';
import dbConfig from '../config/db_config';
import type { DBEnvironment } from '../config/db_config';

function initDB(): Sequelize {
  const environment: DBEnvironment = (() => {
    const env = process.env.NODE_ENV;
    if (env !== 'production' && env !== 'test' && env !== 'development') {
      throw new Error(`Invalid NODE_ENV environment variable "${env}"`);
    }
    return env;
  })();

  const sequelizeOptions = dbConfig[environment];
  const sequelize = new Sequelize(sequelizeOptions);
  sequelize.addModels([path.join(__dirname, '/models/*.model.ts')]);
  return sequelize;
}

export default initDB;
