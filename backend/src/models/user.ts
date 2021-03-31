import { Document } from 'mongoose';

export default interface User extends Document {
  firstName: string;
  lastName: string;
  email: string;
  username: string;
  password: string;
  active: boolean;
}