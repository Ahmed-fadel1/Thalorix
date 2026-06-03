import 'package:equatable/equatable.dart';
import '../../domain/entities/template_entity.dart';

abstract class TemplateDetailsState extends Equatable {
  const TemplateDetailsState();

  @override
  List<Object?> get props => [];
}

class TemplateDetailsInitial extends TemplateDetailsState {
  const TemplateDetailsInitial();
}

class TemplateDetailsLoading extends TemplateDetailsState {
  const TemplateDetailsLoading();
}

class TemplateDetailsSuccess extends TemplateDetailsState {
  final TemplateEntity template;

  const TemplateDetailsSuccess(this.template);

  @override
  List<Object?> get props => [template];
}

class TemplateDetailsError extends TemplateDetailsState {
  final String message;

  const TemplateDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
