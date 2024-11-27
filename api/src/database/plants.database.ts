

import { Plant } from '../models/database/plants.model';
import { pool } from './index.database';

async function getList(): Promise<Plant[]> {
    try {
        const [result] = await pool.query(`CALL Plant_List_GET()`);

        if (Array.isArray(result) && result.length > 0) {
            return result[0] as Plant[];
        } else {
            return Promise.reject('No plants found.');
        }
    } catch (error) {
        return Promise.reject(error);
    }
}
export { getList };
