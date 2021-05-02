import './util/loadEnv';
import app from './app';
import initDB from './database';

import User from './models/User.model';
import Follow from './models/Follow.model';
import PendingFollow from './models/PendingFollow.model';
import type { UserSchema } from './models/User.model';
import type { FollowSchema } from './models/Follow.model';

import followerQuery from './query/FollowerQuery';
import pendingFollowQuery from './query/PendingFollowQuery';

const serverPort = process.env.SERVER_PORT;

async function queryExample(sequelize: any) {
  await sequelize.drop();
  await sequelize.sync();
  const userSchemas: UserSchema[] = [
    {
      first_name: 'First1',
      last_name: 'Last1',
      id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
      public_key: '1',
    },
    {
      first_name: 'First2',
      last_name: 'Last2',
      id: '56fb0138-7577-4f5a-a842-260d167302bc',
      public_key: '2',
    },
    {
      first_name: 'First3',
      last_name: 'Last3',
      id: 'e1191e83-0c63-4ce5-8895-243e5a6150bd',
      public_key: '3',
    },
    {
      first_name: 'First4',
      last_name: 'Last4',
      id: 'aa11c953-6568-48a8-9a2b-a5f77dcb569f',
      public_key: '4',
    },
  ];
  const followSchemas: FollowSchema[] = [
    {
      followee_id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
      follower_id: '56fb0138-7577-4f5a-a842-260d167302bc',
      dek: 'a',
    },
    {
      followee_id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
      follower_id: 'e1191e83-0c63-4ce5-8895-243e5a6150bd',
      dek: 'b',
    },
  ];
  await Promise.all(userSchemas.map((userSchema) => User.create(userSchema)));
  await Promise.all(followSchemas.map((followSchema) => Follow.create(followSchema)));
  await PendingFollow.create({
    followee_id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
    follower_id: 'aa11c953-6568-48a8-9a2b-a5f77dcb569f',
  });
  const user = await User.findOne({
    where: {
      first_name: 'First1',
    },
    // This requires the "as" key since we have more than one possible join with other Users
    include: [
      { model: User, as: 'pending_follows' },
      { model: User, as: 'followers' },
    ],
  });
  if (user !== null) {
    console.log(user.full_name);
    console.log('has the followers - - -');
    console.log(user.followers.map((x) => ({ name: x.full_name, key: x.public_key })));
    console.log('and pending follows - - -');
    console.log(user.pending_follows.map((x) => ({ name: x.full_name, key: x.public_key })));
  }
}

async function followExample(sequelize: any) {
  await sequelize.sync();
  await followerQuery.setDEK('2d30b673-f314-46c5-97dd-a38f98bdd903', 'e1191e83-0c63-4ce5-8895-243e5a6150bd', 'ddd');
  const follower_results = await followerQuery.getFollowerList('2d30b673-f314-46c5-97dd-a38f98bdd903');
  const followers = follower_results?.followers.map((f) => ({ first_name: f.first_name, last_name: f.last_name }));
  const follower_pks = follower_results?.followers.map((f) => ({ follower_id: f.id, public_key: f.public_key }));

  console.log(followers);
  console.log(follower_pks);

  const following_results = await followerQuery.getFollowingList('e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const followees = following_results?.followees.map((f) => ({ first_name: f.first_name, last_name: f.last_name }));
  console.log(followees);

  const dek_result = await followerQuery.getDEK('2d30b673-f314-46c5-97dd-a38f98bdd903', 'e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const dek = dek_result?.dek;
  console.log(dek);
}

async function pendingFollowExample(sequelize: any) {
  await sequelize.sync();

  await pendingFollowQuery.removePendingFollow('e1191e83-0c63-4ce5-8895-243e5a6150bd', 'aa11c953-6568-48a8-9a2b-a5f77dcb569f');

  const pf_results = await pendingFollowQuery.getPendingRequestList('e1191e83-0c63-4ce5-8895-243e5a6150bd');
  const pending_follows = pf_results?.pending_follows.map((f) => ({ id: f.id, first_name: f.first_name, last_name: f.last_name }));
  console.log(pending_follows);

  const spf_results = await pendingFollowQuery.getSentPendingRequestList('aa11c953-6568-48a8-9a2b-a5f77dcb569f');
  const sent_pending_follows = spf_results?.sent_pending_follows.map((f) => ({ id: f.id, first_name: f.first_name, last_name: f.last_name }));
  console.log(sent_pending_follows);
}

async function main() {
  try {
    const sequelize = initDB();
    await sequelize.sync();
    // Uncomment this to try the query example
    // await queryExample(sequelize);

    // Uncomment this to try the follow query example
    // await followExampleTest(sequelize);

    // Uncomment this to try the pending Follow Query example
    // await pendingFollowTest(sequelize);

    app.listen(() => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
