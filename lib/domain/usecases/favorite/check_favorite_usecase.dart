import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/favorite_repository.dart';

class CheckFavoriteUseCase implements UseCase<bool, CheckFavoriteParams> {
  final FavoriteRepository repository;

  CheckFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteParams params) async {
    return await repository.isFavorite(
      userId: params.userId,
      recipeId: params.recipeId,
    );
  }
}

class CheckFavoriteParams extends Equatable {
  final String userId;
  final String recipeId;

  const CheckFavoriteParams({required this.userId, required this.recipeId});

  @override
  List<Object?> get props => [userId, recipeId];
}
