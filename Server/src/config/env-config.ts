import { config } from 'dotenv';
// @ts-ignore
import parseDbUrl from 'parse-database-url';

config();

export interface EnvConfig {
  db: {
    name: string;
    password: string;
    user: string;
    host: string;
    port: number;
  };
  serverPort: number;
  nodeEnv: string;
  firebaseProjectID: string;
}

const defaultServerPort = 443;
const defaultDBPort = 5432;

const {
  NODE_ENV,
  PROJECT_ID,
} = process.env;

if (!NODE_ENV) throw Error('"NODE_ENV" missing from the .env file');
if (!PROJECT_ID) throw Error('"PROJECT_ID" missing from the .env file. This is associated to a firebase project at https://console.firebase.google.com');
// eslint-disable-next-line import/no-mutable-exports
let env: EnvConfig;

if (NODE_ENV === 'production') {
  const {
    DATABASE_URL,
    PORT,
  } = process.env;

  if (!DATABASE_URL) throw Error('"DATABASE_URL" missing in the environment');
  const dbConfig = parseDbUrl(DATABASE_URL);
  env = {
    db: {
      name: dbConfig.database,
      password: dbConfig.password,
      host: dbConfig.host,
      user: dbConfig.user,
      port: dbConfig.port ? Number(dbConfig.port) : defaultDBPort,
    },
    serverPort: PORT ? Number(PORT) : defaultServerPort,
    nodeEnv: NODE_ENV,
    firebaseProjectID: PROJECT_ID,
  };
} else if (NODE_ENV === 'development') {
  const {
    DB_NAME,
    DB_PASS,
    DB_USER,
    DB_HOST,
    DB_PORT,
    SERVER_PORT,
  } = process.env;
  if (!DB_NAME) throw Error('"DB_NAME" missing from .env file');
  if (!DB_PASS) throw Error('"DB_PASS" missing from the .env file');
  if (!DB_USER) throw Error('"DB_USER" missing from the .env file');
  if (!DB_HOST) throw Error('"DB_HOST" missing from the .env file.');
  if (!DB_PORT) throw Error('"DB_PORT" missing from the .env file.');

  env = {
    db: {
      name: DB_NAME,
      password: DB_PASS,
      host: DB_HOST,
      user: DB_USER,
      port: DB_PORT ? Number(DB_PORT) : defaultDBPort,
    },
    serverPort: SERVER_PORT ? Number(SERVER_PORT) : defaultServerPort,
    nodeEnv: NODE_ENV,
    firebaseProjectID: PROJECT_ID,
  };
} else {
  throw Error(`NODE_ENV set to ${NODE_ENV}, should be production or development`);
}

export default env;
