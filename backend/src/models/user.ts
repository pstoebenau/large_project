import { Document } from 'mongoose';

export default interface User extends Document {
  profileImage: string;
  firstName: string;
  lastName: string;
  email: string;
  username: string;
  password: string;
  about: string
  active: boolean;
}