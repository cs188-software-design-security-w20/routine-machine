import PendingFollow from '../models/PendingFollow.model';
import User from '../models/User.model';

export const addPendingFollow = (followee_id: string, follower_id: string) => PendingFollow.create({
  followee_id,
  follower_id,
});

export const removePendingFollow = (
  followee_id: string,
  follower_id: string,
) => PendingFollow.destroy({
  where: {
    followee_id,
    follower_id,
  },
});

export const getPendingRequestList = (followee_id: string) => User.findOne({
  include: [{
    model: User, as: 'pending_follows',
  }],
  where: { id: followee_id },
});

export const getSentPendingRequestList = (follower_id: string) => User.findOne({
  include: [{
    model: User, as: 'sent_pending_follows',
  }],
  where: { id: follower_id },
});
