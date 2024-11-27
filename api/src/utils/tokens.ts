import { NextFunction, Request, Response } from 'express';
import { verify } from 'jsonwebtoken';

import * as ENV_VAR from '../helpers/env';

function authenticateToken(req: Request, res: Response, next: NextFunction): void {
    const token = req.headers.authorization?.split(' ')[1] ?? null;

    if (token == null) {
        res.sendStatus(401);

        return;
    }

    verify(token, ENV_VAR.JWT.TOKEN, (err: any) => {
        if (err) {
            return res.sendStatus(401);
        }
        next();
    });
}

async function getUserFromToken(req: Request): Promise<{ userId: string; email: string }> {
    const decoded = await decodeToken(req.headers.authorization?.split(' ')[1] ?? '');

    return {
        userId: <string>decoded.userId,
        email: <string>decoded.email,
    };
}

async function decodeToken(token: string): Promise<any> {
    return new Promise((resolve, reject) => {
        verify(token, ENV_VAR.JWT.TOKEN, function (err, decoded) {
            if (err) {
                reject('Invalid token');
            }

            resolve(<any>decoded);
        });
    });
}

export { authenticateToken, getUserFromToken };
