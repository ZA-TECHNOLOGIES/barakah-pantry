import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/user_repository.dart';
import '../../entities/user_entity.dart';

class UpdateProfileUseCase implements UseCase<UserEntity, UserEntity> {
  final UserRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UserEntity user) async {
    return await repository.updateProfile(user);
  }
}
