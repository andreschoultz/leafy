import { NumberRangeFilter } from '../utility/ranges.model';

interface PlantListRequest {
    filter: PlantFilter;
}

interface PlantFilter {
    height: NumberRangeFilter;
    diameter: NumberRangeFilter;
}

export type { PlantListRequest, PlantFilter };