import Follow from '../models/Follow.model';
import User from '../models/User.model';

export const addFollower = (
  followee_id: string,
  follower_id: string,
  dek: string,
) => Follow.create({
  followee_id, follower_id, dek,
});

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
) => Follow.upsert({
  followee_id,
  follower_id,
  dek,
});

export const getDEK = (followee_id: string, follower_id: string) => Follow.findOne({
  attributes: ['dek'],
  where: { followee_id, follower_id },
});
