class Appereance {
  final int _charID;
  final int weight;
  final int height;

  Appereance(this._charID, this.weight, this.height);


  factory Appereance.fromJson(Map<String, Object?> jsonMap) {
    return Appereance(
      jsonMap['charID'] as int,
      jsonMap['weight'] as int,
      jsonMap['height'] as int,
    );
  }

  Map toJson() => {
    "id": _charID,
    "weight": weight,
    "height": height,
  };

  @override
  String toString() {
    return "Appereance. Weight = $weight";
  }

}