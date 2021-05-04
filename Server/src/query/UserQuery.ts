import User from '../models/User.model';
import type { UserSchema } from '../models/User.model';
import * as FollowerQuery from './FollowerQuery';

export const createUser = (user: UserSchema) => User.create(user);

export const getUserByName = (user_name: string) => User.findOne({
  where: { user_name },
});

// Habit data, profile, public key can be retrieved through this
export const getUserById = (id: string) => User.findOne({
  where: { id },
});

export const getDEK = (id: string) => FollowerQuery.getDEK(id, id);

export const setDEK = (id: string, dek: string) => FollowerQuery.setDEK(id, id, dek);

export const setPK = (id: string, public_key: string) => User.update({
  public_key,
}, { where: { id } });

export const setHabitData = (id: string, habit_data: string) => User.update({
  habit_data,
}, { where: { id } });

export const setProfile = (id: string, profile: JSON) => User.update({
  profile,
}, { where: { id } });
