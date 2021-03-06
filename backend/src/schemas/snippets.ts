import mongoose, { Schema } from 'mongoose';
import User from '@/models/user';
import Snippet from '@/models/snippets';

const SnippetSchema: Schema = new Schema(
  {
    userId: { type: String, required: true},
    imageURL: { type: String, required: true },
    score: {type: Number, required: true}
  });

export default mongoose.model<Snippet>('Snippet', SnippetSchema);