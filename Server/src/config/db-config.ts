import { Transaction } from 'sequelize';
import type { SequelizeOptions } from 'sequelize-typescript';
import env from './env-config';

export type DBEnvironment = 'development' | 'test' | 'production';

export type SequelizeOptionEnvironments = {
  [key in DBEnvironment]: SequelizeOptions
};

const dbOptions: SequelizeOptionEnvironments = {
  development: {
    username: env.db.user,
    password: env.db.password,
    database: env.db.name,
    host: env.db.host,
    port: env.db.port,
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
    logging: false,
  },
  test: {
    username: env.db.user,
    password: env.db.password,
    database: env.db.name,
    host: env.db.host,
    port: env.db.port,
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
    logging: false,
  },
  production: {
    username: env.db.user,
    password: env.db.password,
    database: env.db.name,
    host: env.db.host,
    port: env.db.port,
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
    logging: false,
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      },
    },
  },
};

export default dbOptions;
