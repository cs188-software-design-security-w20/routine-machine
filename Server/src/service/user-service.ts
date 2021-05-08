import * as UserQuery from '../query/user-query';
import type { UserSchema } from '../models/user-model';

// TODO: throw error if the query fails
// use logger to log error or success
// also return success state

export const createUser = async (user: UserSchema) => {
  const res = await UserQuery.createUser(user);
  return res;
};

export const getUserByName = async (user_name: string) => {
  const res = await UserQuery.getUserByName(user_name);
  return {
    id: res?.id,
    user_name: res?.user_name,
    first_name: res?.first_name,
    last_name: res?.last_name,
    profile: res?.profile,
  };
};

export const getUserById = async (id: string) => {
  const res = await UserQuery.getUserById(id);
  return {
    id: res?.id,
    user_name: res?.user_name,
    public_key: res?.public_key,
    first_name: res?.first_name,
    last_name: res?.last_name,
    profile: res?.profile,
  };
};

export const getDEK = async (id: string) => {
  const res = await UserQuery.getDEK(id);
  return {
    dek: res?.dek,
  };
};

export const setDEK = async (id: string, dek: string) => {
  const res = await UserQuery.setDEK(id, dek);
  return res;
};

export const getPK = async (id: string) => {
  const res = await UserQuery.getUserById(id);
  return {
    id: res?.id,
    public_key: res?.public_key,
  };
};

export const setProfile = async (id: string, profile: JSON) => {
  const res = await UserQuery.setProfile(id, profile);
  return res;
};
