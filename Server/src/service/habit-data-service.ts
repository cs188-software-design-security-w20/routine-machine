import * as UserQuery from '../query/user-query';
import * as FollowQuery from '../query/follow-query';

// TODO: throw error if the query fails
// use logger to log error or success
// also return success state
export const setHabitData = async (id: string, habit_data: string) => {
  const res = await UserQuery.setHabitData(id, habit_data);
}

export const getFollowingHabitDataDEKPair = async (followee_id: string, follower_id: string) => {
  const res_habit_data = await UserQuery.getUserById(followee_id);
  const res_dek = await FollowQuery.getDEK(followee_id, follower_id);
  return {
    followee_id,
    follower_id,
    habit_data: res_habit_data?.habit_data,
    dek: res_dek?.dek
  }
}

export const getUserHabitDataDEKPair = async (user_id: string) => getFollowingHabitDataDEKPair(user_id, user_id);