import { ProcedureCallPacket, RowDataPacket } from 'mysql2';
import { v4 as uuidV4 } from 'uuid';

import { User } from '../models/database/users.model';
import { pool } from './index.database';

async function getUser(id: string): Promise<User> {
    try {
        const [result] = await pool.query<ProcedureCallPacket<User[]>>(`CALL User_GET('${id}')`);

        if (result?.[0].length > 0) {
            return { ...result?.[0][0], Id: id };
        } else {
            return new Promise<User>((_, reject) => {
                reject('User not found.');
            });
        }
    } catch (error) {
        return new Promise<User>((_, reject) => {
            reject(error);
        });
    }
}

async function getUserAuthenticate(email: string): Promise<{ Id: string; PasswordHash: string }> {
    try {
        interface _RowPacket extends RowDataPacket {
            Id: string;
            PasswordHash: string;
        }

        const [result] = await pool.query<ProcedureCallPacket<_RowPacket[]>>(`CALL User_Authenticate_GET('${email}')`);

        if (result?.[0].length > 0) {
            return result?.[0][0];
        } else {
            return new Promise<User>((_, reject) => {
                reject('User not found.');
            });
        }
    } catch (error) {
        return new Promise<User>((_, reject) => {
            reject(error);
        });
    }
}

async function insertUser(params: { email: string; passwordHash: string; firstName: string; surname: string }): Promise<string> {
    const { email, passwordHash, firstName, surname } = params;
    const id = uuidV4();
    const values = [id, email, passwordHash, firstName, surname];

    try {
        const _ = await pool.query(`CALL User_INSERT(?, ?, ?, ?, ?)`, values);
    } catch (error) {
        return new Promise<string>((_, reject) => {
            reject(error);
        });
    }

    return id;
}

async function getUserExists(email: string): Promise<boolean> {
    try {
        const [result] = await pool.query<ProcedureCallPacket<User[]>>(`CALL User_Exists_GET('${email}')`);

        if (result?.[0].length > 0) {
            return true;
        } else {
            return false
        }
    } catch (error) {
        return new Promise<boolean>((_, reject) => {
            reject(error);
        });
    }
}

export { getUser, getUserAuthenticate, insertUser, getUserExists };
