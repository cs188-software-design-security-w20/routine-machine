import { Transaction } from 'sequelize';
import type { SequelizeOptions } from 'sequelize-typescript';

export type DBEnvironment = 'development' | 'test' | 'production';

export type SequelizeOptionEnvironments = {
  [key in DBEnvironment]: SequelizeOptions
};

const dbOptions: SequelizeOptionEnvironments = {
  development: {
    username: process.env.DB_USER ?? '',
    password: process.env.DB_PASS ?? '',
    database: process.env.DB_NAME ?? '',
    host: process.env.DB_HOST ?? '',
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
  },
  test: {
    username: process.env.DB_USER ?? '',
    password: process.env.DB_PASS ?? '',
    database: process.env.DB_NAME ?? '',
    host: process.env.DB_HOST ?? '',
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
  },
  production: {
    username: process.env.DB_USER ?? '',
    password: process.env.DB_PASS ?? '',
    database: process.env.DB_NAME ?? '',
    host: process.env.DB_HOST ?? '',
    dialect: 'postgres',
    isolationLevel: Transaction.ISOLATION_LEVELS.SERIALIZABLE,
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      },
    },
  },
};

export default dbOptions;
