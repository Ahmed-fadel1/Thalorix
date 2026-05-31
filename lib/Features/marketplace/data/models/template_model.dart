import '../../domain/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  const TemplateModel({
    required super.id,
    required super.title,
    required super.price,
    super.thumbnail,
    required super.description,
    super.categoryId,
    super.categoryName,
    super.status,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    String? catId;
    String? catName;

    if (json['categoryId'] != null) {
      if (json['categoryId'] is Map) {
        catId = json['categoryId']['_id']?.toString();
        catName = json['categoryId']['name']?.toString();
      } else if (json['categoryId'] is String) {
        catId = json['categoryId'];
      }
    }

    return TemplateModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? json['fileUrl'],
      categoryId: catId,
      categoryName: catName,
      status: json['status'],
    );
  }
}