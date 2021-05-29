import { Router } from 'express';
import crypto from 'crypto';
import { getPK } from '../service/user-service';

const challengeRouter = Router();

const randomString = (size = 64) => crypto
  .randomBytes(size)
  .toString('base64')
  .slice(0, size);

challengeRouter.get('/', async (req, res) => {
  const id = res.locals.userData.user_id;
  try {
    const { public_key } = await getPK(id);
    const challengeString = randomString();
    const encryptedString = crypto.publicEncrypt(
      {
        key: `-----BEGIN PUBLIC KEY-----\n${public_key}\n-----END PUBLIC KEY-----\n`,
        padding: crypto.constants.RSA_PKCS1_PADDING,
      },
      Buffer.from(challengeString),
    );
    res.status(200).json({
      challengeString,
      encryptedString: encryptedString.toString('base64'),
    });
  } catch (err) {
    console.log(err);
    res.status(500).send(err);
  }
});

export default challengeRouter;
