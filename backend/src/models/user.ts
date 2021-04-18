import { Document } from 'mongoose';

export default interface User extends Document {
  userId: string;
  profileImage: string;
  firstName: string;
  lastName: string;
  email: string;
  username: string;
  password: string;
<<<<<<< HEAD
  about: string
=======
  about: string;
>>>>>>> master
  active: boolean;
}