import 'speciality.dart';

class DoctorModel {
  int? id;
  String? name;
  int? specialityId;
  String? description;
  String? sunday;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;
  String? saturday;
  String? avatar;
  DateTime? createdAt;
  DateTime? updatedAt;
  Speciality? speciality;

  DoctorModel({
    this.id,
    this.name,
    this.specialityId,
    this.description,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.speciality,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) => DoctorModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        specialityId: json['speciality_id'] as int?,
        description: json['description'] as String?,
        sunday: json['sunday'] as String?,
        monday: json['monday'] as String?,
        tuesday: json['tuesday'] as String?,
        wednesday: json['wednesday'] as String?,
        thursday: json['thursday'] as String?,
        friday: json['friday'] as String?,
        saturday: json['saturday'] as String?,
        avatar: json['avatar'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        speciality: json['speciality'] == null
            ? null
            : Speciality.fromJson(json['speciality'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'speciality_id': specialityId,
        'description': description,
        'sunday': sunday,
        'monday': monday,
        'tuesday': tuesday,
        'wednesday': wednesday,
        'thursday': thursday,
        'friday': friday,
        'saturday': saturday,
        'avatar': avatar,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'speciality': speciality?.toJson(),
      };
}
