import { Router } from 'express';

const followRouter = Router();

followRouter.post('/requests', (res, req) => {

});

followRouter.post('/approve', (res, req) => {

});

followRouter.delete('/remove_follower', (res, req) => {

});

followRouter.delete('/unfollow', (res, req) => {

});

followRouter.get('/following/requests', (res, req) => {

});

followRouter.get('/following', (res, req) => {

});

followRouter.get('/followers/requests', (res, req) => {

});

followRouter.get('/followers', (res, req) => {

});

export default followRouter;
