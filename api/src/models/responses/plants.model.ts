interface GetPlantListResponse {
    plants: {
        id: string;
        name: string;
        weeklyWater: number;
    }[];
}

export type { GetPlantListResponse };
