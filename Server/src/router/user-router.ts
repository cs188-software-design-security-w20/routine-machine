/* eslint-disable no-console */
import { Router } from 'express';
import * as UserService from '../service/user-service';
import { requireEqual } from '../util/validate-id';

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
    await requireEqual(id, res.locals.userData.user_id);
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
 * @descirption get a profile of a user by name
 * @request_params user_name
 * @response_body {id, user_name, first_name, last_name, profile}
 */
userRouter.get('/profile/id', async (req, res) => {
  try {
    const { id } = req.query;
    await requireEqual(id, res.locals.userData.user_id);
    const user = await UserService.getUserById(id);
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
    await requireEqual(id, res.locals.userData.user_id);
    await UserService.setProfile(id, profile);
    res.status(200).json({ success: 'User Profile set successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

userRouter.get('/username', async (req, res) => {
  try {
    const { user_name } = req.query;
    await UserService.getUserByName(user_name);
    res.status(200).json(true);
  } catch (error) {
    if (error.name === 'UserNotFoundError') {
      res.status(200).json(false);
    } else {
      res.status(400).send(error);
    }
  }
});

userRouter.post('/username', async (req, res) => {
  try {
    const { id, user_name } = req.body;
    await requireEqual(id, res.locals.userData.user_id);
    await UserService.setUsername(id, user_name);
    res.status(200).json({ success: 'Username set successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

userRouter.post('/firstName', async (req, res) => {
  try {
    const { id, first_name } = req.body;
    await requireEqual(id, res.locals.userData.user_id);
    await UserService.setFirstname(id, first_name);
    res.status(200).json({ success: 'First Name set successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

userRouter.post('/lastName', async (req, res) => {
  try {
    const { id, last_name } = req.body;
    await requireEqual(id, res.locals.userData.user_id);
    await UserService.setLastname(id, last_name);
    res.status(200).json({ success: 'Last Name set successfully', status: 200 });
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
    await requireEqual(id, res.locals.userData.user_id);
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
    await requireEqual(id, res.locals.userData.user_id);
    const dek = await UserService.getDEK(id);
    res.status(200).json(dek);
  } catch (error) {
    res.status(404).send(error);
  }
});

export default userRouter;
