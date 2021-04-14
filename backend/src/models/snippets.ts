import { Document, Schema } from 'mongoose';

export default interface Snippet extends Document {
  _id: string;
  imageURL: string;
  scores: number;
}