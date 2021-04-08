import mongoose, { Schema } from 'mongoose';
import User from '@/models/user';
import Snippet from '@/models/snippets';

const SnippetSchema: Schema = new Schema(
  {
    _id: { type: String, required: true},
    imageURL: { type: String, required: true },
  });

export default mongoose.model<Snippet>('Snippet', SnippetSchema);