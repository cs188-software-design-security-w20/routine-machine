import * as UserQuery from '../query/user-query';
import * as FollowQuery from '../query/follow-query';

export const setHabitData = async (id: string, habit_data: string) => {
  const res = await UserQuery.setHabitData(id, habit_data);
  return res;
};

export const getFollowingHabitDataDEKPair = async (followee_id: any, follower_id: any) => {
  const res_habit_data = await UserQuery.getUserById(followee_id);
  const res_dek = await FollowQuery.getDEK(followee_id, follower_id);
  return {
    followee_id,
    follower_id,
    habit_data: res_habit_data?.habit_data,
    dek: res_dek?.dek,
  };
};

export const getUserHabitDataDEKPair = async (user_id: any) => {
  const habit_dek_pair = await getFollowingHabitDataDEKPair(user_id, user_id);
  return {
    id: habit_dek_pair.followee_id,
    habit_data: habit_dek_pair.habit_data,
    dek: habit_dek_pair.dek,
  };
};
