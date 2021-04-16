import { Document, Schema } from 'mongoose';

export default interface Snippet extends Document {
  id: string,
  userId: string;
  imageURL: string;
  score: number;
}