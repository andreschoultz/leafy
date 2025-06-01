import * as PlantDB from '../database/plants.database';
import { PlantListRequest } from '../models/requests/plants.model';
import {
    AddUserPlantResponse, GetPlantListResponse, GetPlantResponse
} from '../models/responses/plants.model';

async function getList(request: PlantListRequest): Promise<GetPlantListResponse> {
    let result = await PlantDB.getList(request.filter.height, request.filter.diameter);

    const response: GetPlantListResponse = {
        plants: result.map((x) => ({
            id: x.Id,
            name: x.Name,
            imageURL: x.ImageURL,
            weeklyWater: x.WeeklyWater ?? 0,
        })),
    };

    return response;
}

async function getPlant(id: string, userId: string): Promise<GetPlantResponse> {
    let [result, tags] = await Promise.all([
        PlantDB.getPlant(id, userId),
        PlantDB.getPlantTags(id)
    ]);

    const response: GetPlantResponse = {
        id: result.Id,
        name: result.Name,
        description: result.Description,
        imageURL: result.ImageURL,
        idealHumidityPerc: result.IdealHumidityPerc,
        avgHeight: result.AvgHeight,
        avgDiameter: result.AvgDiameter,
        idealSunlightK: result.IdealSunlightK,
        weeklyWater: result.WeeklyWater,
        userHasPlant: result.UserPlantId != null,
        tags: tags.map((x) => ({ tagId: x.TagId, name: x.Name })),
    };

    return response;
}

async function addUserPlant(userId: string, plantId: string): Promise<AddUserPlantResponse> {
    let result = await PlantDB.insertUserPlant({ userId, plantId });

    return { id: result };
}

export { getList, getPlant, addUserPlant };
