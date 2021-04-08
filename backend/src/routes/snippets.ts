import express, { NextFunction, Request, Response } from 'express';
import User from '@/schemas/user';
import Snippet from '@/schemas/snippets';
import mongoose from 'mongoose';

const router = express.Router();

router.post('/addSnippet/:id', async (req: Request, res: Response, next: NextFunction) => {

    if (!req.body) {
        return res.status(500).json({
            message: "Invalid input"
        });
    }

    let { _id, imageURL } = req.body;

    const snippet = new Snippet({
        _id,
        imageURL
    });
    
    try {
        let results = await snippet.save()
        
        return res.status(200).json({
            snippet: results
        });
    } catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
});

router.get('/find', async (req: Request, res: Response, next: NextFunction) => {
    try {
        let results = await Snippet.find().exec();
        
        return res.status(200).json({
            snippet: results,
            count: results.length
        });
    } catch (error) {
        return res.status(500).json({
            message: error.message
        });
    }
});

export default router;