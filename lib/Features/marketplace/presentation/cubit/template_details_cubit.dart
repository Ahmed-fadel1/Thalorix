import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/get_template_details_usecase.dart';
import 'template_details_state.dart';

class TemplateDetailsCubit extends Cubit<TemplateDetailsState> {
  final GetTemplateDetailsUseCase getTemplateDetailsUseCase;

  TemplateDetailsCubit({
    required this.getTemplateDetailsUseCase,
  }) : super(const TemplateDetailsInitial());

  Future<void> getTemplateDetails(String id) async {
    emit(const TemplateDetailsLoading());

    final result = await getTemplateDetailsUseCase(id);

    result.fold(
      (failure) => emit(TemplateDetailsError(failure.message)),
      (template) => emit(TemplateDetailsSuccess(template)),
    );
  }
}
