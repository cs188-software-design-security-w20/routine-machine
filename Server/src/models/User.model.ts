import {
  Table, Model, Column, PrimaryKey, DataType, BelongsToMany, AllowNull, IsUUID,
} from 'sequelize-typescript';
import Follow from './Follow.model';
import PendingFollow from './PendingFollow.model';

export interface UserSchema {
  id: string;
  public_key: string;
  first_name: string;
  last_name: string;
  profile?: object;
  habit_data?: string;
}

@Table({ modelName: 'user' })
export default class User extends Model<UserSchema> {
  @IsUUID(4)
  @PrimaryKey
  @Column(DataType.UUID)
  id: string;

  @AllowNull(false)
  @Column
  public_key: string;

  @AllowNull(false)
  @Column
  first_name: string;

  @AllowNull(false)
  @Column
  last_name: string;

  @Column(DataType.JSON)
  profile: object;

  @Column
  habit_data: string;

  @BelongsToMany(() => User, () => Follow, 'followee_id', 'follower_id')
  followers: User[];

  @BelongsToMany(() => User, () => PendingFollow, 'followee_id', 'follower_id')
  pending_follows: User[];

  get full_name() {
    return `${this.first_name} ${this.last_name}`;
  }
}
