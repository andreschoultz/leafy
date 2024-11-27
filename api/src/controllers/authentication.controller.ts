import { Request, Response, Router } from 'express';

import {
    authenticateUser, refreshAccessToken, registerUser
} from '../services/authentication.service';
import { delay } from '../utils/async';

const router = Router();

router.get('/login/:email/:password', async (req: Request, res: Response) => {
    await delay(300);
    
    const { email, password } = req.params;

    try {
        const token = await authenticateUser(email, password);

        if (token && typeof token !== 'string') {
            res.status(200).json({
                accessToken: token.AccessToken,
                refreshToken: token.RefreshToken
            });
        } else {
            res.status(400).json({
                message: token ? <string>token : 'Failed to authenticate user.',
            });
        }
    } catch (error) {
        res.status(500).json({
            message: 'Oops, something went wrong. Please try again.',
            error
        });
    }
});

router.post('/register', async (req: Request, res: Response) => {
    await delay(300);

    const { email, password, firstName, surname } = req.body;

    try {
        const token = await registerUser(email, password, firstName, surname);

        if (token && typeof token !== 'string') {
            res.status(200).json({
                accessToken: token.AccessToken,
                refreshToken: token.RefreshToken
            });
        } else {
            res.status(400).json({
                message: token ? <string>token : 'Unable to register.',
            });
        }
    } catch (error) {
        res.status(500).json({
            message: 'Oops, something went wrong. Please try again.',
            error
        });
    }
});

router.get('/refresh-access-token/:refreshToken/:accessToken', async (req: Request, res: Response) => {
    await delay(50);
    
    const { refreshToken, accessToken } = req.params;

    if (!accessToken || !refreshToken) {
        res.status(400).send('Missing required parameters.');

        return;
    }

    try {
        const newAccessToken = await refreshAccessToken(accessToken, refreshToken);

        if (!newAccessToken) {
            res.status(401).json({
                message: 'Invalid access | refresh tokens supplied.',
            });

            return;
        }

        res.status(200).json({
            token: newAccessToken
        });
    } catch (error) {
        res.status(500).json({
            message: 'Oops, something went wrong. Please try again.',
            error
        })
    }
});


export default router;