import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/favorite_repository.dart';

class AddFavoriteUseCase implements UseCase<void, AddFavoriteParams> {
  final FavoriteRepository repository;

  AddFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddFavoriteParams params) async {
    return await repository.addFavorite(
      userId: params.userId,
      recipeId: params.recipeId,
    );
  }
}

class AddFavoriteParams extends Equatable {
  final String userId;
  final String recipeId;

  const AddFavoriteParams({required this.userId, required this.recipeId});

  @override
  List<Object?> get props => [userId, recipeId];
}
