import { sign, SignOptions, verify } from 'jsonwebtoken';

import { getUserAuthenticate, getUserExists, insertUser } from '../database/users.database';
import * as ENV_VAR from '../helpers/env';
import { hashPassword, validatePasswordAgainstHash } from '../utils/cryptography';

async function authenticateUser(email: string, password: string): Promise<{ AccessToken: string; RefreshToken: string } | string | null> {
    if (email.length == 0 || password.length == 0) {
        return null;
    }

    let userInfo: { Id: string; PasswordHash: string };

    try {
        userInfo = await getUserAuthenticate(email);
    } catch (error) {
        return <string>error;
    }

    if (!(await validatePasswordAgainstHash(password, userInfo.PasswordHash))) {
        return 'Invalid email or password.';
    }

    const accessToken = generateAccessToken(userInfo.Id, email);

    if (!accessToken) return null;

    const refreshToken = generateRefreshToken(userInfo.Id, email);

    return { AccessToken: accessToken, RefreshToken: refreshToken };
}

async function registerUser(email: string, password: string, firstName: string, surname: string): Promise<{ AccessToken: string; RefreshToken: string } | string | null> {
    if (email.length == 0 || password.length == 0 || firstName.length == 0) {
        return null;
    }

    if (await getUserExists(email)) {
        return 'A fellow leafy member with this email already exists.';
    }

    const passwordHash = await hashPassword(password);
    const userId = await insertUser({ email, passwordHash, firstName, surname });

    if (!userId) {
        return 'Unable to create user. Please try again later.';
    }

    const accessToken = generateAccessToken(userId, email);

    if (!accessToken) return null;

    const refreshToken = generateRefreshToken(userId, email);

    return { AccessToken: accessToken, RefreshToken: refreshToken };
}

async function refreshAccessToken(accessToken: string, refreshToken: string): Promise<string | null> {
    return new Promise((resolve, reject) => {
        verify(refreshToken, ENV_VAR.JWT.TOKEN, function (err, decoded) {
            if (err) {
                reject('Invalid token');
            }

            const newAccessToken = generateAccessToken((<any>decoded).userId, (<any>decoded).email);

            resolve(newAccessToken);
        });
    });
}

function generateAccessToken(userId: string, email: string): string {
    const jwtOptions: SignOptions = {
        expiresIn: '30m',
    };

    return sign({ userId, email }, ENV_VAR.JWT.TOKEN, jwtOptions);
}

function generateRefreshToken(userId: string, email: string): string {
    const jwtOptions: SignOptions = {
        expiresIn: '1d',
    };

    return sign({ userId, email }, ENV_VAR.JWT.TOKEN, jwtOptions);
}

export { authenticateUser, registerUser, refreshAccessToken };
