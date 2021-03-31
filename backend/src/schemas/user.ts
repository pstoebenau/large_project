import mongoose, { Schema } from 'mongoose';
import User from '@/models/user';

const UserSchema: Schema = new Schema(
  {
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    email: { type: String, required: true },
    username: { type: String, required: true },
    password: { type: String, required: true },
  },
  {
    timestamps: true
  }
);

export default mongoose.model<User>('User', UserSchema);