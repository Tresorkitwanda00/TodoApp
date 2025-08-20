class Tache {
  final int? id;
  final bool? status;
  final String tache;
  Tache({this.id, this.status, required this.tache});
  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(id: json['id'], status: json['status'], tache: json['tache']);
  }
  Map<String, dynamic> toJson() {
    return {"tache": tache};
  }
}
