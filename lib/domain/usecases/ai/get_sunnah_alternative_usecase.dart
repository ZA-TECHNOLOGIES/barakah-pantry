import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/ai_repository.dart';

class GetSunnahAlternativeUseCase implements UseCase<String, String> {
  final AIRepository repository;

  GetSunnahAlternativeUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String ingredient) async {
    return await repository.getSunnahAlternative(ingredient);
  }
}
