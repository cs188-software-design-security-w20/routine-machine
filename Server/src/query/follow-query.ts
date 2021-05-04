import Follow from '../models/follow-model';
import User from '../models/user-model';
import type { FollowSchema } from '../models/follow-model';

export const addFollower = (follow: FollowSchema) => Follow.create(follow);

export const removeFollower = (followee_id: string, follower_id: string) => Follow.destroy({
  where: { followee_id, follower_id },
});

export const getFollowerList = (followee_id: string) => User.findOne({
  include: [{
    model: User, as: 'followers',
  }],
  where: { id: followee_id },
});

export const getFollowingList = (follower_id: string) => User.findOne({
  include: [{
    model: User, as: 'followees',
  }],
  where: { id: follower_id },
});

export const setDEK = (
  followee_id: string,
  follower_id: string,
  dek: string,
) => Follow.update({
  dek,
}, { where: { followee_id, follower_id } });

export const getDEK = (followee_id: string, follower_id: string) => Follow.findOne({
  attributes: ['dek'],
  where: { followee_id, follower_id },
});
