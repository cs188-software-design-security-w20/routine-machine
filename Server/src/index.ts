/* eslint-disable no-console */
import app from './app';
import initDB from './database';
import env from './config/env-config';

const { serverPort } = env;

async function main() {
  try {
    const sequelize = initDB();
    await sequelize.drop();
    await sequelize.sync();
    app.listen(serverPort, () => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
