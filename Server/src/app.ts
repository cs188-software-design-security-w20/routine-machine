import express from 'express';
import morgan from 'morgan';
import bodyParser from 'body-parser';

import authenticate from './authenticate';
import userRouter from './userRouter';
import followRouter from './followRouter';
import habitDataRouter from './habitDataRouter';

const app = express();
app.use(morgan('short'));
app.use(bodyParser.json());
app.use('/user', authenticate, userRouter);
app.use('/follow', authenticate, followRouter);
app.use('/user_habit_data', authenticate, habitDataRouter);

export default app;
