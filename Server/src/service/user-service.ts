/* eslint-disable no-console */
/* eslint-disable @typescript-eslint/no-throw-literal */
import * as UserQuery from '../query/user-query';
import type { UserSchema } from '../models/user-model';

export const createUser = async (user: UserSchema) => {
  await UserQuery.createUser(user);
};

// eslint-disable-next-line max-len
export const getUserByName = async (user_name: any) => {
  if (user_name === undefined) {
    throw { message: 'user_name is undefined', name: 'UserNameUndefinedError' };
  }
  if (typeof user_name === 'string') {
    const res = await UserQuery.getUserByName(user_name);
    if (res === null) {
      throw { message: `There is no user with user_name: ${user_name}`, name: 'UserNotFoundError' };
    }
    return {
      id: res?.id,
      user_name: res?.user_name,
      public_key: res?.public_key,
      first_name: res?.first_name,
      last_name: res?.last_name,
      profile: res?.profile,
    };
  }
  throw { message: 'type of user_name is not string', name: 'TypeError' };
};

export const getUserById = async (id: any) => {
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

export const getDEK = async (id: any) => {
  if (id === undefined) {
    throw { message: 'id is undefined', name: 'UserIdUndefinedError' };
  }
  const res = await UserQuery.getDEK(id);
  if (res === null) {
    throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
  }
  return {
    id,
    dek: res.dek,
  };
};

export const setDEK = async (id: string, dek: string) => {
  try {
    await UserQuery.setDEK(id, dek);
  } catch (error) {
    if (error.name === 'SequelizeForeignKeyConstraintError') {
      throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
    }
  }
};

export const getPK = async (id: any) => {
  const res = await UserQuery.getUserById(id);
  if (res === null) {
    throw { message: 'There is no user with user id', name: 'UserNotFoundError' };
  }
  return {
    id: res?.id,
    public_key: res?.public_key,
  };
};

export const setProfile = async (id: string, profile: JSON) => {
  const res = await UserQuery.setProfile(id, profile);
  if (res[0] !== 1) {
    throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
  }
};

export const setUsername = async (id: string, user_name: string) => {
  const res = await UserQuery.setUsername(id, user_name);
  if (res[0] !== 1) {
    throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
  }
};

export const setFirstname = async (id: string, first_name: string) => {
  const res = await UserQuery.setFirstname(id, first_name);
  if (res[0] !== 1) {
    throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
  }
};

export const setLastname = async (id: string, last_name: string) => {
  const res = await UserQuery.setLastname(id, last_name);
  if (res[0] !== 1) {
    throw { message: `There is no user with user id: ${id}`, name: 'UserNotFoundError' };
  }
};
