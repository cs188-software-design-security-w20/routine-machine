import * as PendingFollowQuery from '../query/pending-follow-query';
import * as FollowQuery from '../query/follow-query';
import type { PendingFollowSchema } from '../models/pending-follow-model';
import { FollowSchema } from '../models/follow-model';

export const addPendingFollow = async (followee_id: string, follower_id: string) => {
  const pf: PendingFollowSchema = { followee_id, follower_id };
  const res = await PendingFollowQuery.addPendingFollow(pf);
  return res;
};

export const removePendingFollow = async (followee_id: string, follower_id: string) => {
  const pf: PendingFollowSchema = { followee_id, follower_id };
  const res = await PendingFollowQuery.removePendingFollow(pf);
  return res;
};

export const getPendingRequestList = async (followee_id: any) => {
  const res = await PendingFollowQuery.getPendingRequestList(followee_id);
  return res?.pending_follows.map((pf) => ({
    id: pf.id,
    user_name: pf.user_name,
    public_key: pf.public_key,
    profile: pf.profile,
    first_name: pf.first_name,
    last_name: pf.last_name,
  }));
};

export const getSentPendingRequestList = async (follower_id: any) => {
  const res = await PendingFollowQuery.getSentPendingRequestList(follower_id);
  return res?.sent_pending_follows.map((pf) => ({
    id: pf.id,
    user_name: pf.user_name,
    profile: pf.profile,
    first_name: pf.first_name,
    last_name: pf.last_name,
  }));
};

export const addFollow = async (followee_id: string, follower_id: string, dek: string) => {
  const follow: FollowSchema = { followee_id, follower_id, dek };
  const res = await FollowQuery.addFollow(follow);
  return res;
};

export const removeFollow = async (followee_id: string, follower_id: string) => {
  const res = await FollowQuery.removeFollow(followee_id, follower_id);
  return res;
};

export const getFollowerList = async (followee_id: any) => {
  const res = await FollowQuery.getFollowerList(followee_id);
  return res?.followers
    .map((f) => ({
      id: f.id,
      user_name: f.user_name,
      public_key: f.public_key,
      profile: f.profile,
      first_name: f.first_name,
      last_name: f.last_name,
    })).filter((f) => (f.id !== followee_id));
};

export const getFollowingList = async (follower_id: any) => {
  const res = await FollowQuery.getFollowingList(follower_id);
  return res?.followees.map((f) => ({
    id: f.id,
    user_name: f.user_name,
    profile: f.profile,
    first_name: f.first_name,
    last_name: f.last_name,
  })).filter((f) => (f.id !== follower_id));
};

export const getFollowerPKs = async (followee_id: any) => {
  const res = await FollowQuery.getFollowerList(followee_id);
  return res?.followers.map((f) => ({
    id: f.id,
    public_key: f.public_key,
  })).filter((f) => (f.id !== followee_id));
};

export const setDEK = async (followee_id: string, follower_id: string, dek: string) => {
  const res = await FollowQuery.setDEK(followee_id, follower_id, dek);
  return res;
};

export interface follower_dek_pair {
  follower_id: string,
  dek: string
}

export const updateFollowerDEKs = async (
  followee_id: string,
  follower_dek_pairs: follower_dek_pair[],
) => {
  follower_dek_pairs.forEach((f) => {
    setDEK(followee_id, f.follower_id, f.dek);
  });
};
