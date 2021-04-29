import { config } from 'dotenv';
config();

import app from './app';
import db from './models';

const port = 8000;
db.sequelize.sync().then(() => {
  app.listen(port, () => {
    console.log(`Server is running at ${port}`)
  });
})


