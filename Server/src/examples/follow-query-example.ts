import * as FollowQuery from '../query/follow-query';

/**
 *  Example of how to use the FollowQuery functions
 *  Note that "model-example" has to be run before this
 */
export default async function followExample() {
  await FollowQuery.setDEK('2d30b673-f314-46c5-97dd-a38f98bdd903', 'e1191e83-0c63-4ce5-8895-243e5a6150bd', 'ddd');
  const followerResults = await FollowQuery.getFollowerList('2d30b673-f314-46c5-97dd-a38f98bdd903');
  const followers = followerResults?.followers.map((f) => ({
    first_name: f.first_name, last_name: f.last_name,
  }));
  const followerPKs = followerResults?.followers.map((f) => ({
    follower_id: f.id, public_key: f.public_key,
  }));

  console.log(followers);
  console.log(followerPKs);

  const followingResults = await FollowQuery.getFollowingList('e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const followees = followingResults?.followees.map((f) => ({
    first_name: f.first_name, last_name: f.last_name,
  }));
  console.log(followees);

  const dekResult = await FollowQuery.getDEK('2d30b673-f314-46c5-97dd-a38f98bdd903', 'e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const dek = dekResult?.dek;
  console.log(dek);
}
