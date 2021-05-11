import express from 'express';
import morgan from 'morgan';
import cors from 'cors';

import authenticate from './util/authenticate';
import userRouter from './router/user-router';
import followRouter from './router/follow-router';
import habitDataRouter from './router/habit-data-router';

const app = express();
app.use(cors());
app.use(morgan('short'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/user', authenticate, userRouter);
app.use('/follow', authenticate, followRouter);
app.use('/habit_data', authenticate, habitDataRouter);

export default app;
