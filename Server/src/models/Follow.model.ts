import {
  Model, Table, Column, ForeignKey, Unique, AllowNull,
} from 'sequelize-typescript';
import User from './User.model';

export interface FollowSchema {
  followee_id: string;
  follower_id: string;
  dek: string;
}

@Table({ tableName: 'follow' })
export default class Follow extends Model<FollowSchema> {
  @AllowNull(false)
  @ForeignKey(() => User)
  @Column
  followee_id: string;

  @AllowNull(false)
  @ForeignKey(() => User)
  @Column
  follower_id: string;

  @Unique
  @AllowNull(false)
  @Column
  dek: string;
}
