import app from './app';
import initDB from './database';
import env from './config/env-config';

const { serverPort } = env;

async function main() {
  try {
    const sequelize = initDB();
    await sequelize.sync();
    app.listen(() => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
