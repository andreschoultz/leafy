interface GetPlantListResponse {
    plants: {
        id: string;
        name: string;
        imageURL: string;
        weeklyWater: number;
    }[];
}

interface GetPlantResponse {
    id: string;
    name: string;
    description: string;
    imageURL: string;
    idealHumidityPerc: number;
    avgHeight: number;
    avgDiameter: number;
    idealSunlightK: number;
    weeklyWater: number;
    userHasPlant: boolean;
    tags: { tagId: string; name: string }[];
}

interface AddUserPlantResponse {
    id: string;
}

export type { GetPlantListResponse, GetPlantResponse, AddUserPlantResponse };
