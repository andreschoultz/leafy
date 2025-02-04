class PlantListRequest {
  PlantListRequest({
    required this.filter,
  });

  final PlantFilterRequest filter;

  toJsonMap() {
    return {
      'filter': filter.toJsonMap(),
    };
  }
}

class PlantFilterRequest {
  PlantFilterRequest({
    required this.height,
    required this.diameter,
  });

  final NumberRangeFilterRequest height;
  final NumberRangeFilterRequest diameter;

  toJsonMap() {
    return {
      'height': {
        'from': height.from,
        'to': height.to,
      },
      'diameter': {
        'from': diameter.from,
        'to': diameter.to,
      },
    };
  }
}

class NumberRangeFilterRequest {
  NumberRangeFilterRequest({
    required this.from,
    required this.to,
  });

  final double from;
  final double to;

  toJsonMap() {
    return {
      'from': from,
      'to': to,
    };
  }
}
