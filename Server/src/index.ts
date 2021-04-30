import './util/loadEnv';
import app from './app';
import initDB from './database';

import User from './models/User.model';
import Follow from './models/Follow.model';
import PendingFollow from './models/PendingFollow.model';
import type { UserSchema } from './models/User.model';
import type { FollowSchema } from './models/Follow.model';

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

async function main() {
  try {
    const sequelize = initDB();
    await sequelize.sync();
    // Uncomment this to try the query example
    // await queryExample(sequelize);
    app.listen(() => {
      console.log(`Started server on port ${serverPort}`);
    });
  } catch (e) {
    console.error(e.message);
  }
}

main();
