import * as PendingFollowQuery from '../query/pending-follow-query';
import type { PendingFollowSchema } from '../models/pending-follow-model';

/**
 *  Example of how to use the PendingFollowQuery functions
 *  Note that "model-example" has to be run before this
 */
export default async function pendingFollowExample() {
  const pf: PendingFollowSchema = { followee_id: 'e1191e83-0c63-4ce5-8895-243e5a6150bd', follower_id: 'aa11c953-6568-48a8-9a2b-a5f77dcb569f' }
  await PendingFollowQuery.removePendingFollow(pf);

  const pfResults = await PendingFollowQuery.getPendingRequestList('e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const pendingFollows = pfResults?.pending_follows.map((f) => ({
    id: f.id, first_name: f.first_name, last_name: f.last_name,
  }));
  console.log(pendingFollows);

  const spfResults = await PendingFollowQuery.getSentPendingRequestList('aa11c953-6568-48a8-9a2b-a5f77dcb569f');
  const sentPendingFollows = spfResults?.sent_pending_follows.map((f) => ({
    id: f.id, first_name: f.first_name, last_name: f.last_name,
  }));
  console.log(sentPendingFollows);
}
