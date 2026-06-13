import 'package:equatable/equatable.dart';

class TemplateEntity extends Equatable {
  final String id;
  final String title;
  final double price;
  final String? thumbnail;
  final String description;
  final String? categoryId;
  final String? categoryName;
  final String? status;

  const TemplateEntity({
    required this.id,
    required this.title,
    required this.price,
    this.thumbnail,
    required this.description,
    this.categoryId,
    this.categoryName,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        thumbnail,
        description,
        categoryId,
        categoryName,
        status,
      ];
}
