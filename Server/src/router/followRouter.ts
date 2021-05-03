'use strict';

const express = require('express');

const service = require('../service/followService.js');

const followRouter = express.Router();

followRouter.post('/request', async (req: any, res: any) => {
    try {
        await service.sendFollowRequest(req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.post('/approve', async (req: any, res: any) => {
    try {
        await service.approveFollowRequest(req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.delete('/remove_follower', async (req: any, res: any) => {
    try {
        await service.removeFollower(req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.delete('/unfollow', async (req: any, res: any) => {
    try {
        await service.unfollow(req.params.id);
        res.status(200).json({ message: 'OK' });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.get('/following/requests', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const followingRequests = await service.getFollowingRequests(user_id);
        res.status(200).json({ followingRequests });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.get('/following', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const following = await service.getFollowing(user_id);
        res.status(200).json({ following });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.get('/followers/requests', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const followerRequests = await service.getFollowerRequests(user_id);
        res.status(200).json({ followerRequests });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

followRouter.get('/followers', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const followers = await service.getFollowers(user_id);
        res.status(200).json({ followers });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

export default followRouter;
