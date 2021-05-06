import { Router } from 'express';

import type { follower_dek_pair } from '../service/follow-service';
import * as FollowService from '../service/follow-service';
const followRouter = Router();

/**
 * @description adds a follow requests, used by new followers.
 * @request_body {followee_id, follower_id}
 */
followRouter.post('/requests', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.body;
    await FollowService.addPendingFollow(followee_id, follower_id);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
})

/**
 * @description approve the follow request
 * @request_body {followee_id, follower_id, dek}
 */
followRouter.post('/approve', async (req, res) => {
  try {
    const { followee_id, follower_id, dek } = req.body;
    await FollowService.addFollow(followee_id, follower_id, dek);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description remove a following relationship. can be initiated to both "unfollow" and "remove follower".
 * @request_body {followee_id, follower_id}
 */
followRouter.delete('/remove_follow', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.body;
    await FollowService.removeFollow(followee_id, follower_id);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the pending requests that you sent
 */
followRouter.get('/following/requests', async (req, res) => {
  try {
    const follower_id = req.params.follower_id
    const pending_follows = await FollowService.getSentPendingRequestList(follower_id);
    res.status(200).json(pending_follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the people that you follow
 */
followRouter.get('/following', async (req, res) => {
  try {
    const follower_id = req.params.follower_id
    const follows = await FollowService.getFollowingList(follower_id);
    res.status(200).json(follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the pending follow requests that you received
 */
followRouter.get('/followers/requests', async (req, res) => {
  try {
    const followee_id = req.params.followee_id
    const pending_follows = await FollowService.getPendingRequestList(followee_id);
    res.status(200).json(pending_follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of your followers
 */
followRouter.get('/followers', async (req, res) => {
  try {
    const followee_id = req.params.followee_id
    const follows = await FollowService.getFollowerList(followee_id);
    res.status(200).json(follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get follower public keys
 */
followRouter.get('/followers/pk', async (req, res) => {
  try {
    const followee_id = req.params.followee_id
    const follower_pks = await FollowService.getFollowerPKs(followee_id);
    res.status(200).json(follower_pks);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description update follower deks
 */
followRouter.post('/followers/dek', async (req, res) => {
  try {
    const { followee_id, follower_dek_pairs } = req.body;
    const fdps: follower_dek_pair[] = follower_dek_pairs.map((f: { follower_id: string; dek: string; }) => ({ ...f }));
    await FollowService.updateFollowerDEKs(followee_id, fdps);
    res.status(200);
  } catch (error) {
    res.status(409).send(error);
  }
});

export default followRouter;
