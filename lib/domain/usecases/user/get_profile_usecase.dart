import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/user_repository.dart';
import '../../entities/user_entity.dart';

class GetProfileUseCase implements UseCase<UserEntity, GetProfileParams> {
  final UserRepository repository;

  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(GetProfileParams params) async {
    return await repository.getProfile(params.userId);
  }
}

class GetProfileParams extends Equatable {
  final String userId;

  const GetProfileParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
