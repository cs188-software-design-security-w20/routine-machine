import PendingFollow from '../models/PendingFollow.model';
import type PendingFollowSchema from '../models/PendingFollow.model';
import User from '../models/User.model';

export const addPendingFollow = (pendingFollow: PendingFollowSchema) => PendingFollow.create(pendingFollow);

export const removePendingFollow = (
  pendingFollow: PendingFollowSchema
) => PendingFollow.destroy({
  where: {
    ...pendingFollow
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
