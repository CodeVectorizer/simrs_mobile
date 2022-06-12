class Speciality {
  int? id;
  String? speciality;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Speciality({
    this.id,
    this.speciality,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) => Speciality(
        id: json['id'] as int?,
        speciality: json['speciality'] as String?,
        description: json['description'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'speciality': speciality,
        'description': description,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
