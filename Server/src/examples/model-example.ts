import type { Sequelize } from 'sequelize-typescript';
import User from '../models/user-model';
import Follow from '../models/follow-model';
import PendingFollow from '../models/pending-follow-model';
import type { UserSchema } from '../models/user-model';
import type { FollowSchema } from '../models/follow-model';

/**
 *  Example of how to use the User, Follow, and PendingFollow Model
 *  This also initializes some test values that NEEDS TO BE RUN before
 *  some of the other tests
 */
export default async function queryExample(sequelize: Sequelize) {
  // Drops the table first to ensure no duplicates are being entered
  await sequelize.drop();
  await sequelize.sync();
  const userSchemas: UserSchema[] = [
    {
      user_name: 'first_user',
      first_name: 'First1',
      last_name: 'Last1',
      id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
      public_key: '1',
    },
    {
      user_name: 'second_user',
      first_name: 'First2',
      last_name: 'Last2',
      id: '56fb0138-7577-4f5a-a842-260d167302bc',
      public_key: '2',
    },
    {
      user_name: 'third_user',
      first_name: 'First3',
      last_name: 'Last3',
      id: 'e1191e83-0c63-4ce5-8895-243e5a6150bd',
      public_key: '3',
    },
    {
      user_name: 'fourth_user',
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
