import { Request, Response, Router } from 'express';

import { PlantListRequest } from '../models/requests/plants.model';
import { addUserPlant, getList, getPlant } from '../services/plant.service';
import { authenticateToken, getUserFromToken } from '../utils/tokens';

const router = Router();

export interface TypedRequestBody<T> extends Express.Request {
    body: T
}

router.post('/list', authenticateToken, async (req: TypedRequestBody<PlantListRequest>, res: Response) => {
    
    try {
        if (!req.body || !req.body.filter || !req.body.filter.height || !req.body.filter.diameter) {
            res.status(400).send('Missing required request body properties.');

            return;
        }

        const plants = await getList(req.body);

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

router.get('/:id', authenticateToken, async(req: Request, res: Response) => {
    try {
        const { id } = req.params;

        if (!id || id.length < 36) {
            res.status(400).send('Missing required parameters.');

            return;
        }

        const tokenInfo = await getUserFromToken(req);
        const plant = await getPlant(id, tokenInfo.userId);

        if (plant) {
            res.status(200).json(plant);
        } else {
            res.status(400).json({
                message: 'Failed to load plant.',
            });
        }
    } catch (error) {
        res.status(500).json({
            message: 'Oops, something went wrong. Please try again.',
            error
        });
    }
});

router.get('/add/:plantId', authenticateToken, async(req: Request, res: Response) => {
    try {
        const { plantId } = req.params;

        if (!plantId || plantId.length < 36) {
            res.status(400).send('Missing required parameters.');

            return;
        }

        const tokenInfo = await getUserFromToken(req);
        const plant = await addUserPlant(tokenInfo.userId, plantId);

        if (plant) {
            res.status(200).json(plant);
        } else {
            res.status(400).json({
                message: 'Failed to add plant.',
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