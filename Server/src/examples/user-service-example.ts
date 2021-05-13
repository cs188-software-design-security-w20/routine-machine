import type { Sequelize } from 'sequelize-typescript';
import type { UserSchema } from '../models/user-model';
import * as UserService from '../service/user-service';

export default async function userServiceExample(sequelize: Sequelize) {
  await sequelize.drop();
  await sequelize.sync();
  const userSchemas: UserSchema[] = [
    {
      user_name: 'first_user',
      first_name: 'First1',
      last_name: 'Last1',
      id: '2d30b673-f314-46c5-97dd-a38f98bdd903',
      public_key: '1',
      profile: {
        img: 'asdfasdfasdfasdfasdfasd'
      }
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

  const res = await UserService.createUser(userSchemas[0]);
  console.log(res);

  const dekRes = await UserService.setDEK(userSchemas[0].id, 'a');
  console.log(dekRes);

  const dek = await UserService.getDEK(userSchemas[0].id);
  console.log(dek);

  const userRes = await UserService.getUserByName(userSchemas[0].user_name);
  console.log(userRes);


  console.log(await UserService.getUserById(userSchemas[0].id));
}