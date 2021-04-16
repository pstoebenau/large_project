import { Document } from 'mongoose';

export default interface User extends Document {
  userId: string;
  firstName: string;
  lastName: string;
  email: string;
  username: string;
  password: string;
  active: boolean;
}