class Personality {
  final int _charID;
  final String mbti;
  final String temper;

  Personality(this._charID, this.mbti, this.temper);


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