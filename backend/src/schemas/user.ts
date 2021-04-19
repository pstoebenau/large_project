import mongoose, { Schema } from 'mongoose';
import User from '@/models/user';

const UserSchema: Schema = new Schema(
  {
    profileImage: { type: String, required: true },
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    email: { type: String, required: true, unique: true, match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/ },
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    about: { type: String, required: false },
    active: { type: Boolean, required: true },
  },
  {
    timestamps: true
  }
);

export default mongoose.model<User>('User', UserSchema);