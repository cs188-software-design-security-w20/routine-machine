'use strict';
import User from '../models/User.model';
import FollowerQuery from './FollowerQuery';

class UserQuery {
  getUserByName = (first_name: string, last_name: string) => User.findOne({
    where: { first_name, last_name }
  })

  // Habit data, profile, public key can be retrieved through this
  getUserById = (id: string) => User.findOne({
    where: { id }
  })

  getDEK = (id: string) => FollowerQuery.getDEK(id, id);

  setDEK = (id: string, dek: string) => FollowerQuery.setDEK(id, id, dek);

  createUser = (id: string, first_name: string, last_name: string, public_key: string) => User.create({
    id,
    first_name,
    last_name,
    public_key
  });

  setPK = (id: string, public_key: string) => User.update({
    public_key
  }, { where: { id } });

  setHabitData = (id: string, habit_data: string) => User.update({
    habit_data
  }, { where: { id } });

  setProfile = (id: string, profile: JSON) => User.update({
    profile
  }, { where: { id } });
}

export default new UserQuery();