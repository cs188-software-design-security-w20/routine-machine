import { Router } from 'express';
import * as UserService from '../service/user-service';

const userRouter = Router();

userRouter.get('/profile', async (req, res) => {
  try {
    const user_name = req.params['user_name'];
    const user = await UserService.getUserByName(user_name);
    // TODO handle a case when user does not exist
    res.status(200).json(user);
  } catch (error) {
    res.status(404).send(error);
  }
});

userRouter.get('/public_key', async (req, res) => {
  try {
    const id = req.params['id'];
    const pk = await UserService.getPK(id);
    // TODO handle a case when user does not exist
    res.status(200).json(pk);
  } catch (error) {
    res.status(500).send(error);
  }
});

userRouter.post('/public_key', async (req, res) => {
  try {
    const { id, public_key } = req.body;
    await UserService.setPK(id, public_key);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

userRouter.get('/dek', async (req, res) => {
  try {
    const id = req.params['id'];
    const dek = await UserService.getDEK(id);
    // TODO handle a case when user does not exist
    res.status(200).json(dek);
  } catch (error) {
    res.status(500).send(error);
  }
});

userRouter.post('/dek', async (req, res) => {
  try {
    const { id, dek } = req.body;
    await UserService.setDEK(id, dek);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

export default userRouter;
