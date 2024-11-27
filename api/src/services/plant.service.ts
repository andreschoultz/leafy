import * as PlantDB from '../database/plants.database';
import { GetPlantListResponse } from '../models/responses/plants.model';

async function getList(): Promise<GetPlantListResponse> {
    let result = await PlantDB.getList();

    const response: GetPlantListResponse = {
        plants: result.map(x => ({id: x.Id, name: x.Name, weeklyWater: x.WeeklyWater ?? 0}))
    };
    
    return response;
}

export { getList };