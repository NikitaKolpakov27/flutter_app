class Personality {
  int _charID;
  String mbti;
  String temper;

  Personality(this._charID, this.mbti, this.temper);

  set setMBTI(String val) => mbti = val;
  set setTemper(String val) => temper = val;
  set setID(int val) => _charID = val;

  String get getMBTI => mbti;
  String get getTemper => temper;
  int get getID => _charID;

  factory Personality.fromJson(Map<String, Object?> jsonMap) {
    return Personality(
      jsonMap['charID'] as int,
      jsonMap['mbti'] as String,
      jsonMap['temper'] as String,
    );
  }

  Map toJson() => {
    "id": _charID,
    "mbti": mbti,
    "temper": temper,
  };

  @override
  String toString() {
    return "Personality: $temper";
  }

}