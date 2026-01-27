import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/favorite_repository.dart';
import '../../entities/recipe_entity.dart';

class GetFavoritesUseCase
    implements UseCase<List<RecipeEntity>, GetFavoritesParams> {
  final FavoriteRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(
      GetFavoritesParams params) async {
    return await repository.getFavorites(params.userId);
  }
}

class GetFavoritesParams extends Equatable {
  final String userId;

  const GetFavoritesParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
