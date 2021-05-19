import { config } from 'dotenv';

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

const defaultServerPort = 8000;
const defaultDBPort = 5432;

const {
  DB_NAME,
  DB_PASS,
  DB_USER,
  DB_HOST,
  DB_PORT,
  PORT,
  NODE_ENV,
  PROJECT_ID,
} = process.env;

if (!DB_NAME) throw Error('"DB_NAME" missing from .env file');
if (!DB_PASS) throw Error('"DB_PASS" missing from the .env file');
if (!DB_USER) throw Error('"DB_USER" missing from the .env file');
if (!DB_HOST) throw Error('"DB_HOST" missing from the .env file. For local testing, this should be set to "localhost"');
if (!NODE_ENV) throw Error('"NODE_ENV" missing from the .env file');
if (!PROJECT_ID) throw Error('"PROJECT_ID" missing from the .env file. This is associated to a firebase project at https://console.firebase.google.com');

const env: EnvConfig = {
  db: {
    name: DB_NAME,
    password: DB_PASS,
    host: DB_HOST,
    user: DB_USER,
    port: DB_PORT ? Number(DB_PORT) : defaultDBPort,
  },
  serverPort: PORT ? Number(PORT) : defaultServerPort,
  nodeEnv: NODE_ENV,
  firebaseProjectID: PROJECT_ID,
};

export default env;
