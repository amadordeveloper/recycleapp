class Tip {
  final int id;
  final String tip;

  Tip({required this.id, required this.tip});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id'],
      tip: json['tip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tip': tip,
    };
  }
}
