import app from './app';
import initDB from './database';
import env from './config/env-config';
import userServiceExample from './examples/user-service-example';

const { serverPort } = env;

async function main() {
  try {
    const sequelize = initDB();
    await sequelize.sync();
    userServiceExample(sequelize);
    app.listen(() => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
