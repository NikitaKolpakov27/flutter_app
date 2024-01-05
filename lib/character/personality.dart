class Personality {
  final int _charID;
  final String _mbti;
  final String _temper;

  Personality(this._charID, this._mbti, this._temper);

  String getMbti() {
    return _mbti;
  }

  String getTemper() {
    return _temper;
  }

  factory Personality.fromJson(Map<String, Object?> jsonMap) {
    return Personality(
      jsonMap['charID'] as int,
      jsonMap['mbti'] as String,
      jsonMap['temper'] as String,
    );
  }

  Map toJson() => {
    "id": _charID,
    "mbti": _mbti,
    "temper": _temper,
  };

  @override
  String toString() {
    return "Personality: $_temper";
  }

}