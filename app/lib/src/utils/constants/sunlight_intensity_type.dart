enum SunlightIntensityType {
  fullSun(1, 'Full Sun'),
  indirectLight(2, 'Indirect Light'),
  partialShade(3, 'Partial Shade'),
  lowLight(4, 'Low Light');

  final int id;
  final String description;

  const SunlightIntensityType(this.id, this.description);
}