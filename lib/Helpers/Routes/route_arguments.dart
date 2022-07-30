class RouteArguments {
  int? personID;
  String? imagePath;

  RouteArguments({
    this.personID,
    this.imagePath,
  });

  @override
  String toString() {
    return 'current route argument';
  }
}
