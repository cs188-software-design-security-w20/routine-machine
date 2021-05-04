import {
  AllowNull,
  Column, ForeignKey, Model, Table,
} from 'sequelize-typescript';
import User from './user-model';

export interface PendingFollowSchema {
  followee_id: string;
  follower_id: string;
}

@Table({ tableName: 'pending_follow' })
export default class PendingFollow extends Model<PendingFollowSchema> {
  @AllowNull(false)
  @ForeignKey(() => User)
  @Column
  followee_id: string;

  @AllowNull(false)
  @ForeignKey(() => User)
  @Column
  follower_id: string;
}
