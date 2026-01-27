import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/user_repository.dart';

class DeleteAccountUseCase implements UseCase<void, String> {
  final UserRepository repository;

  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String userId) async {
    return await repository.deleteAccount(userId);
  }
}
