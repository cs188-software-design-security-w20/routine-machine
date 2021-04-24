import { config } from 'dotenv';
config();

import app from './app';

const port = 8000;


app.listen(port, () => {
  console.log(`Server is running at ${port}`)
});
