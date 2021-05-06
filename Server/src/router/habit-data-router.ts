import { Router } from 'express';
import { setHabitData } from '../query/user-query';
import * as HabitDataService from '../service/habit-data-service';

const habitDataRouter = Router();

/**
 * @description This endpoint is to retrieve the caller's own habit data.
 */
habitDataRouter.get('/', async (req, res) => {
  try {
    const id = req.params.id;
    const habitDataDEKPair = await HabitDataService.getUserHabitDataDEKPair(id);
    res.status(200).json(habitDataDEKPair);
  } catch (error) {
    res.status(404).send(error);
  }
});

/**
 * @description This endpoint is to update / insert the caller's own habit data.
 * @request_body
 * {id: string, habit_data: string}
 * @response_body
 * {}
 */
habitDataRouter.post('/', async (req, res) => {
  try {
    const { id, habit_data } = req.body;
    await setHabitData(id, habit_data);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 *
 * @description This endpoint is to retrieve the followee's habit data and associated dek for the follower
 * @request_params
 * followee_id, follower_id
 * @response_body
 * { followee_id, follower_id, habit_data, dek }
 */
habitDataRouter.get('/', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.params;
    const followingHabitDataDEKPair = await HabitDataService.getFollowingHabitDataDEKPair(followee_id, follower_id);
    res.status(200).json(followingHabitDataDEKPair);
  } catch (error) {
    res.status(500).send(error);
  }
})

export default habitDataRouter;
