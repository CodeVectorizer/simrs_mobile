class FacilityModel {
  int? id;
  String? title;
  int? price;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  FacilityModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) => FacilityModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        price: json['price'] as int?,
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
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
