# Routine Machine Backend

## Overview

The Routine Machine API is written in [Typescript](https://www.typescriptlang.org/) using:
- [Express 4.x](https://expressjs.com/): Used to route, parse, and generate incoming and outgoing HTTP requests
- [Firebase Admin SDK](https://firebase.google.com/docs/reference/admin#nodejs): Used to validate credential tokens distributed by the Firebase Auth Server
- [Jest](https://jestjs.io/): Unit testing framework

## Usage

Set this directory to `Server` for any of the steps.

### Initial Setup

```
npm install
```

You need to add the Firebase Project ID to the environment. This can be found in the Firebase console for your own Firebase project, or the one our group will eventually use.
Create a `.env` file under `Server` with the key value pairs:
```
PROJECT_ID=<Put Project ID Here>
```

### Development
```bash
npm run dev
```

Runs a dev server on port 8000 with hot-reloading.

### Testing
```
npm test
```




