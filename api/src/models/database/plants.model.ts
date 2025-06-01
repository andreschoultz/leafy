import { RowDataPacket } from 'mysql2';

interface Plant extends RowDataPacket {
    Id: string;
    Created?: Date;
    Modified?: Date;
    Deleted?: boolean;
    Name: string;
    Description?: string;
    ImageURL: string;
    PlantInfoId?: string | null;
    WeeklyWater?: number | null;
    Infos?: PlantInfo;
    Tags?: PlantTag[];
}

interface PlantInfo extends RowDataPacket {
    Id: string;
    Created?: Date;
    Modified?: Date;
    Deleted?: boolean;
    IdealHumidityPerc: number;
    AvgHeight: number;
    AvgDiameter: number;
    IdealSunlightK: number;
}

interface PlantTag extends RowDataPacket {
    Id: string;
    Created?: Date;
    Modified?: Date;
    Deleted?: boolean;
    Name: string;
    PlantId: string;
}

interface PlantInfoGET extends RowDataPacket {
    Id: string;
    Name: string;
    Description: string;
    ImageURL: string;
    IdealHumidityPerc: number;
    AvgHeight: number;
    AvgDiameter: number;
    IdealSunlightK: number;
    WeeklyWater: number;
    UserPlantId?: string;
}

interface PlantTagGet extends RowDataPacket {
    TagId: string;
    Name: string;
}

export type { Plant, PlantInfo, PlantTag, PlantInfoGET, PlantTagGet };
