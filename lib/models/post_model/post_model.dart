import 'category.dart';

class PostModel {
  int? id;
  int? categoryId;
  String? title;
  String? content;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;

  PostModel({
    this.id,
    this.categoryId,
    this.title,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        image: json['image'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        category: json['category'] == null
            ? null
            : Category.fromJson(json['category'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'title': title,
        'content': content,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'category': category?.toJson(),
      };
}
