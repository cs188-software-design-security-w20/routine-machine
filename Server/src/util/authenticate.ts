import * as admin from 'firebase-admin';
import { NextFunction, Response, Request } from 'express';

admin.initializeApp({
  projectId: process.env.PROJECT_ID,
});

export default async function authenticate(req: Request, res: Response, next: NextFunction) {
  const authHeader = req.header('Authorization');
  if (!authHeader) {
    res.status(401).json({ error: 'Authorization header missing' });
    return;
  }
  const token = authHeader.split(' ')[1];
  try {
    const userData = await admin.auth().verifyIdToken(token);
    res.locals.userData = userData;
    next();
  } catch (err) {
    res.status(401).json({ error: err.message });
  }
}
