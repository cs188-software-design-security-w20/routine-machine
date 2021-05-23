import {
  Table, Model, Column, PrimaryKey, DataType, BelongsToMany, AllowNull, Unique,
} from 'sequelize-typescript';
import Follow from './follow-model';
import PendingFollow from './pending-follow-model';

export interface UserSchema {
  id: string;
  user_name: string;
  public_key: string;
  first_name: string;
  last_name: string;
  profile?: object;
  habit_data?: string;
}

@Table({ modelName: 'user' })
export default class User extends Model<UserSchema> {
  @PrimaryKey
  @Column
  id: string;

  @Unique
  @AllowNull(false)
  @Column
  user_name: string;

  @Unique
  @AllowNull(false)
  @Column(DataType.TEXT)
  public_key: string;

  @AllowNull(false)
  @Column
  first_name: string;

  @AllowNull(false)
  @Column
  last_name: string;

  @Column(DataType.JSON)
  profile: object;

  @Column(DataType.TEXT)
  habit_data: string;

  @BelongsToMany(() => User, () => Follow, 'followee_id', 'follower_id')
  followers: User[];

  @BelongsToMany(() => User, () => PendingFollow, 'followee_id', 'follower_id')
  pending_follows: User[];

  @BelongsToMany(() => User, () => Follow, 'follower_id', 'followee_id')
  followees: User[];

  @BelongsToMany(() => User, () => PendingFollow, 'follower_id', 'followee_id')
  sent_pending_follows: User[];

  get full_name() {
    return `${this.first_name} ${this.last_name}`;
  }
}
