import './util/loadEnv';
import app from './app';
import initDB from './database';

const serverPort = process.env.SERVER_PORT;

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
