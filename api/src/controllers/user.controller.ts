import { Request, Response, Router } from 'express';

import { getUser } from '../services/user.service';
import { authenticateToken, getUserFromToken } from '../utils/tokens';

const router = Router();

router.get('/', authenticateToken, async (req: Request, res: Response) => {
    
    const tokenInfo = await getUserFromToken(req);

    try {
        const user = await getUser(tokenInfo.userId);

        if (user) {
            res.status(200).json(user);
        } else {
            res.status(400).json({
                message: 'Failed to load user.',
            });
        }
    } catch (error) {
        res.status(500).json({
            message: 'Oops, something went wrong. Please try again.',
            error
        });
    }
});

export default router;