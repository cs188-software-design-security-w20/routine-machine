'use strict';

const express = require('express');

const service = require('../service/userService.js');

const userRouter = express.Router();

userRouter.get('/profile', async (req: any, res: any) => {
    try {
        const user_name = req.get('user_name');
        const profile = await service.getUserProfile(user_name);
        res.status(200).json({ profile });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

userRouter.get('/publickey', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const publicKey = await service.getPublicKey(user_id);
        res.status(200).json({ publicKey });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

userRouter.post('/publickey', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        await service.updatePublicKey(user_id,req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

userRouter.get('/dek', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const dek = await service.getDEK(user_id);
        res.status(200).json({ dek });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

userRouter.post('/dek', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        await service.updateDEK(user_id, req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

export default userRouter;
