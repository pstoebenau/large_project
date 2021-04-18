import User from "@/models/user";
import UserSchema from '@/schemas/user';

export default class UserFunctions {
  constructor(){}

  static async getUser(_id: string): Promise<User | null> {
    return await UserSchema.findById(_id);
  }
}