/* eslint-disable no-console */
import { Router } from 'express';
import * as UserService from '../service/user-service';

const userRouter = Router();

/**
 * @description create a user
 * @request_body {id, user_name, public_key, first_name, last_name, dek}
 */
userRouter.post('/', async (req, res) => {
  try {
    const {
      id, user_name, public_key, first_name, last_name, dek,
    } = req.body;
    await UserService.createUser({
      id, user_name, public_key, first_name, last_name,
    });
    await UserService.setDEK(id, dek);
    res.status(200).json({ success: 'User created successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @descirption get a profile of a user by name
 * @request_params user_name
 * @response_body {id, user_name, first_name, last_name, profile}
 */
userRouter.get('/profile', async (req, res) => {
  try {
    const { user_name } = req.query;
    const user = await UserService.getUserByName(user_name);
    res.status(200).json(user);
  } catch (error) {
    res.status(404).send(error);
  }
});

/**
 * @descirption set the profile of the user
 * @request_body {id, profile}
 */
userRouter.post('/profile', async (req, res) => {
  try {
    const { id, profile } = req.body;
    await UserService.setProfile(id, profile);
    res.status(200).json({ success: 'User Profile set successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @descirption get the public key of the user
 * @request_body {id, profile}
 */
userRouter.get('/public_key', async (req, res) => {
  try {
    const { id } = req.query;
    const pk = await UserService.getPK(id);
    // TODO handle a case when user does not exist
    res.status(200).json(pk);
  } catch (error) {
    res.status(404).send(error);
  }
});

/**
 * @descirption set your own dek
 * @request_body {id,dek}
 */
userRouter.post('/dek', async (req, res) => {
  try {
    const { id, dek } = req.body;
    await UserService.setDEK(id, dek);
    res.status(200).json({ success: 'User dek set successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @descirption get your own dek
 * @request_param {id}
 * @response_body {dek}
 */
userRouter.get('/dek', async (req, res) => {
  try {
    const { id } = req.query;
    const dek = await UserService.getDEK(id);
    res.status(200).json(dek);
  } catch (error) {
    res.status(404).send(error);
  }
});

export default userRouter;
