'use strict';
import Follow from '../models/Follow.model';
import User from '../models/User.model';

class FollowerQuery {
  addFollower = (followee_id: string, follower_id: string, dek: string) => Follow.create({
    followee_id, follower_id, dek
  });

  removeFollower = (followee_id: string, follower_id: string) => Follow.destroy({
    where: { followee_id, follower_id }
  });

  getFollowerList = (followee_id: string) => User.findOne({
    include: [{
      model: User, as: 'followers'
    }],
    where: { id: followee_id }
  })

  getFollowingList = (follower_id: string) => User.findOne({
    include: [{
      model: User, as: 'followees'
    }],
    where: { id: follower_id }
  })

  setDEK = (followee_id: string, follower_id: string, dek: string) => Follow.upsert({
    followee_id,
    follower_id,
    dek
  })

  getDEK = (followee_id: string, follower_id: string) => Follow.findOne({
    attributes: ['dek'],
    where: { followee_id, follower_id }
  })
}

export default new FollowerQuery();