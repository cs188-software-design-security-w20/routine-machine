'use strict';

const express = require('express');

const service = require('../service/habitDataService.js');

const habitDataRouter = express.Router();

habitDataRouter.get('/', async (req: any, res: any) => {
    try {
        const user_id = req.get('user_id');
        const habitData = await service.getUserProfile(user_id);
        res.status(200).json({ habitData });
    } catch (err) {
        console.log(err);
        res.status(500).json({ message: 'Server error' });
    }
});

export default habitDataRouter;
