import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../listing/domain/models/listing_model.dart';
import '../../data/repositories/listing_repository.dart';

// State
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ListingModel> recommended;
  final List<ListingModel> featured;
  final List<ListingModel> luxury;
  final List<ListingModel> recent;

  const HomeLoaded({
    required this.recommended,
    required this.featured,
    required this.luxury,
    required this.recent,
  });

  @override
  List<Object> get props => [recommended, featured, luxury, recent];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  @override
  List<Object> get props => [message];
}

// Cubit
class HomeCubit extends Cubit<HomeState> {
  final ListingRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final recommended = await _repository.getListings(queryParams: {'limit': 4});
      final featured = await _repository.getFeaturedListings();
      final luxury = await _repository.getListings(queryParams: {'minPrice': 4000000, 'limit': 4});
      final recent = await _repository.getListings(queryParams: {'sort': 'createdAt_desc', 'limit': 4});

      emit(HomeLoaded(
        recommended: recommended,
        featured: featured,
        luxury: luxury,
        recent: recent,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
