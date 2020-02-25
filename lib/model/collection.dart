class Collection {
  int id;
  String name,banner;
  DateTime startDate;
  bool isCurrent;

  Collection({this.id, this.name, this.banner, this.startDate, this.isCurrent});

  factory Collection.fromJson(Map<String, dynamic> json) {
    String startDateString = json["StartDate"];
    return Collection(
      id: json["Id"],
      name: json["Name"],
      banner: json["Banner"],
      isCurrent: json["IsCurrent"],
    );
  }
}