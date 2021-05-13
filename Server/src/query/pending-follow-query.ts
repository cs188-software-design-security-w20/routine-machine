import PendingFollow from '../models/pending-follow-model';
import type { PendingFollowSchema } from '../models/pending-follow-model';
import User from '../models/user-model';

export const addPendingFollow = (pf: PendingFollowSchema) => PendingFollow.create(pf);

export const removePendingFollow = (
  pf: PendingFollowSchema,
) => PendingFollow.destroy({
  where: {
    ...pf,
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
