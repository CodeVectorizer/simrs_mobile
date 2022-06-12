class MitraModel {
  int? id;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  MitraModel({
    this.id,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory MitraModel.fromJson(Map<String, dynamic> json) => MitraModel(
        id: json['id'] as int?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
