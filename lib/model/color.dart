class MColor {
  String name;
  int r,g,b,o;

  MColor({this.name, this.r, this.g, this.b, this.o});
  factory MColor.fromJson(Map<String, dynamic> json) {
    return MColor(
      name: json["Name"],
      r: json["R"],
      g: json["G"],
      b: json["B"],
      o: json["O"],
    );
  }
}