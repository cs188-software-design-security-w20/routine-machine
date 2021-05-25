/* eslint-disable no-console */
import app from './app';
import initDB from './database';
import env from './config/env-config';
const https = require('https');
const fs = require('fs');
const { serverPort } = env;

let key = fs.readFileSync(__dirname + '/ssl/key.pem');
let cert = fs.readFileSync(__dirname + '/ssl/cert.pem');
var options = {
    key: key,
    cert: cert,
};

async function main() {
	console.log(__dirname + '/ssl/key.pem');
  try {
    const sequelize = initDB();
    await sequelize.drop();
    await sequelize.sync();
    var server = https.createServer(options, app);
    server.listen(serverPort, () => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
