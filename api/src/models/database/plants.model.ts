import { RowDataPacket } from 'mysql2';

interface Plant extends RowDataPacket {
    Id: string;
    Created?: Date;
    Modified?: Date;
    Deleted?: boolean;
    Name: string;
    Description?: string;
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

export type { Plant, PlantInfo, PlantTag };
