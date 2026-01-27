import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/favorite_repository.dart';

class RemoveFavoriteUseCase implements UseCase<void, RemoveFavoriteParams> {
  final FavoriteRepository repository;

  RemoveFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveFavoriteParams params) async {
    return await repository.removeFavorite(
      userId: params.userId,
      recipeId: params.recipeId,
    );
  }
}

class RemoveFavoriteParams extends Equatable {
  final String userId;
  final String recipeId;

  const RemoveFavoriteParams({required this.userId, required this.recipeId});

  @override
  List<Object?> get props => [userId, recipeId];
}
