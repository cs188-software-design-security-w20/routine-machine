import express from 'express';
import morgan from 'morgan';
import cors from 'cors';

import authenticate from './util/authenticate';
import userRouter from './router/user-router';
import followRouter from './router/follow-router';
import habitDataRouter from './router/habit-data-router';
import challengeRouter from './router/challenge';

const app = express();
app.use(cors());
app.use(morgan('short'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/user', authenticate, userRouter);
app.use('/follow', authenticate, followRouter);
app.use('/habit_data', authenticate, habitDataRouter);
app.use('/challenge', authenticate, challengeRouter);
//app.use('/user', userRouter);
//app.use('/follow', followRouter);
//app.use('/habit_data', habitDataRouter);
//app.use('/.well-known/acme-challenge/Y6Q52IlJTBSljwDpV87R7SBBFTTdllySeX3lK2vB7k8', challengeRouter);
export default app;
