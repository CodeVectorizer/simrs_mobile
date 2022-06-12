class ServiceModel {
  int? id;
  String? title;
  String? open;
  String? time;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  ServiceModel({
    this.id,
    this.title,
    this.open,
    this.time,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as int?,
        title: json['title'] as String?,
        open: json['open'] as String?,
        time: json['time'] as String?,
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
        'open': open,
        'time': time,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
