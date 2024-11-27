import { Request, Response, Router } from 'express';

import { getList } from '../services/plant.service';
import { authenticateToken } from '../utils/tokens';

const router = Router();

router.get('/list', authenticateToken, async (req: Request, res: Response) => {
    
    try {
        const plants = await getList();

        if (plants) {
            res.status(200).json(plants);
        } else {
            res.status(400).json({
                message: 'Failed to load plants.',
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