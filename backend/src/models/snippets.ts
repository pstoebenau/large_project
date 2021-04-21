import { Document, Schema } from 'mongoose';

export default interface Snippet extends Document {
  _id: string,
  userId: string;
  imageURL: string;
  score: number;
}