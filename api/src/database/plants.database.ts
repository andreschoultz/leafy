

import { ProcedureCallPacket } from 'mysql2';
import { v4 as uuidV4 } from 'uuid';

import { Plant, PlantInfoGET, PlantTagGet } from '../models/database/plants.model';
import { NumberRangeFilter } from '../models/utility/ranges.model';
import { pool } from './index.database';

async function getList(heightRange: NumberRangeFilter, diameterRange: NumberRangeFilter): Promise<Plant[]> {
    try {
        const [result] = await pool.query(`CALL Plant_List_GET(${heightRange.from}, ${heightRange.to}, ${diameterRange.from}, ${diameterRange.to})`);

        if (Array.isArray(result) && result.length > 0) {
            return result[0] as Plant[];
        } else {
            return Promise.reject('No plants found.');
        }
    } catch (error) {
        return Promise.reject(error);
    }
}

 async function getPlant(id: string, userId: string): Promise<PlantInfoGET> {
    try {
        const [result] = await pool.query<ProcedureCallPacket<PlantInfoGET[]>>(`CALL Plant_Info_GET('${id}', '${userId}')`);

        if (result?.[0].length > 0) {
            return { ...result?.[0][0] };
        } else {
            return new Promise<PlantInfoGET>((_, reject) => {
                reject('Plant not found.');
            });
        }
    } catch (error) {
        return new Promise<PlantInfoGET>((_, reject) => {
            reject(error);
        });
    }
 }

 async function getPlantTags(plantId: string): Promise<PlantTagGet[]> {
    try {
        const [result] = await pool.query(`CALL PlantTag_GET('${plantId}')`);

        if (Array.isArray(result) && result.length > 0) {
            return result[0] as PlantTagGet[];
        } else {
            return Promise.reject('No tags found.');
        }
    } catch (error) {
        return Promise.reject(error);
    }
}


 async function insertUserPlant(params: {userId: string, plantId: string}): Promise<string> {
     const { plantId, userId } = params;

     const id = uuidV4();
     const values = [id, userId, plantId];

     try {
         const _ = await pool.query(`CALL UserPlant_INSERT(?, ?, ?)`, values);
     } catch (error) {
         return new Promise<string>((_, reject) => {
             reject(error);
         });
     }

     return id;
 }

export { getList, getPlant, insertUserPlant, getPlantTags };
