import User from '../models/user-model';
import type { UserSchema } from '../models/user-model';
import * as FollowQuery from './follow-query';

export const createUser = (user: UserSchema) => User.create(user);

export const getUserByName = (user_name: string) => User.findOne({
  where: { user_name },
});

// Habit data, profile, public key can be retrieved through this
export const getUserById = (id: string) => User.findOne({
  where: { id },
});

export const getDEK = (id: string) => FollowQuery.getDEK(id, id);

export const setDEK = (id: string, dek: string) => FollowQuery
  .setDEK(id, id, dek);

export const setPK = (id: string, public_key: string) => User.update({
  public_key,
}, { where: { id } });

export const setHabitData = (id: string, habit_data: string) => User.update({
  habit_data,
}, { where: { id } });

export const setProfile = (id: string, profile: JSON) => User.update({
  profile,
}, { where: { id } });

export const setUsername = (id: string, user_name: string) => User.update({
  user_name,
}, { where: { id } });

export const setFirstname = (id: string, first_name: string) => User.update({
  first_name,
}, { where: { id } });

export const setLastname = (id: string, last_name: string) => User.update({
  last_name,
}, { where: { id } });
