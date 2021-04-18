import { Document } from 'mongoose';

export default interface User extends Document {
<<<<<<< HEAD
  profileImage: string;
=======
  userId: string;
>>>>>>> master
  firstName: string;
  lastName: string;
  email: string;
  username: string;
  password: string;
  about: string
  active: boolean;
}