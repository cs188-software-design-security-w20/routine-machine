import { Router } from 'express';

import type { follower_dek_pair } from '../service/follow-service';
import * as FollowService from '../service/follow-service';
import { requireEqual, requireOneEqual } from '../util/validate-id';

const followRouter = Router();

/**
 * @description adds a follow request, used by new followers.
 * @request_body {followee_id, follower_id}
 */
followRouter.post('/requests', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.body;
    await requireEqual(follower_id, res.locals.userData.user_id);
    await FollowService.addPendingFollow(followee_id, follower_id);
    res.json({ success: 'Pending Follow request created successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description rejects a follow request
 * @request_body {followee_id, follower_id}
 */
followRouter.delete('/requests', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.body;
    await requireOneEqual(followee_id, follower_id, res.locals.userData.user_id);
    await FollowService.removePendingFollow(followee_id, follower_id);
    res.json({ success: 'Pending Follow request removed successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description approve the follow request
 * @request_body {followee_id, follower_id, dek (dek + iv) }
 */
followRouter.post('/', async (req, res) => {
  try {
    const { followee_id, follower_id, dek } = req.body;
    await requireEqual(followee_id, res.locals.userData.user_id);
    await FollowService.addFollow(followee_id, follower_id, dek);
    await FollowService.removePendingFollow(followee_id, follower_id);
    res.json({ success: 'Follow created successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description remove a following relationship. both "unfollow" and "remove follower".
 * @request_body {followee_id: string, follower_id: string}
 */
followRouter.delete('/', async (req, res) => {
  try {
    const { followee_id, follower_id } = req.body;
    await requireOneEqual(followee_id, follower_id, res.locals.userData.user_id);
    await FollowService.removeFollow(followee_id, follower_id);
    res.json({ success: 'Follow removed successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the pending requests that you sent
 * @request_params {follower_id:string}
 * @res_body {pending_follows: pending_follow[]}
 */
followRouter.get('/following/requests', async (req, res) => {
  try {
    const { follower_id } = req.query;
    await requireEqual(follower_id, res.locals.userData.user_id);
    const pending_follows = await FollowService.getSentPendingRequestList(follower_id);
    res.status(200).json(pending_follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the people that you follow
 * @request_params {follower_id}
 * @res_body {follows:follow[]}
 */
followRouter.get('/following', async (req, res) => {
  try {
    const { follower_id } = req.query;
    await requireEqual(follower_id, res.locals.userData.user_id);
    const follows = await FollowService.getFollowingList(follower_id);
    res.status(200).json(follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of the pending follow requests that you received
 * @request_parms {followee_id}
 * @res_body {pendingfollows: []}
 */
followRouter.get('/followers/requests', async (req, res) => {
  try {
    const { followee_id } = req.query;
    await requireEqual(followee_id, res.locals.userData.user_id);
    const pending_follows = await FollowService.getPendingRequestList(followee_id);
    res.status(200).json(pending_follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get a list of your followers
 * @request_params {followee_id}
 * @res_body {follows: follow[]}
 */
followRouter.get('/followers', async (req, res) => {
  try {
    const { followee_id } = req.query;
    await requireEqual(followee_id, res.locals.userData.user_id);
    const follows = await FollowService.getFollowerList(followee_id);
    res.status(200).json(follows);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description get follower public keys
 * @request_params {followee_id}
 * @res_body {follower_pk: {id, public_key}[]}
 */
followRouter.get('/followers/pk', async (req, res) => {
  try {
    const { followee_id } = req.query;
    await requireEqual(followee_id, res.locals.userData.user_id);
    const follower_pks = await FollowService.getFollowerPKs(followee_id);
    res.status(200).json(follower_pks);
  } catch (error) {
    res.status(409).send(error);
  }
});

/**
 * @description update follower deks
 * @request_body {followee_id, follower_dek_pairs}
 */
followRouter.post('/followers/dek', async (req, res) => {
  try {
    const { followee_id, follower_dek_pairs } = req.body;
    await requireEqual(followee_id, res.locals.userData.user_id);
    const fdps: follower_dek_pair[] = follower_dek_pairs
      .map((f: { follower_id: string; dek: string; }) => ({ ...f }));
    await FollowService.updateFollowerDEKs(followee_id, fdps);
    res.json({ success: 'Follower DEKs updated successfully', status: 200 });
  } catch (error) {
    res.status(409).send(error);
  }
});

export default followRouter;
