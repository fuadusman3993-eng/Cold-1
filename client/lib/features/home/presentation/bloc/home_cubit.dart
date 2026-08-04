import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../listing/domain/models/listing_model.dart';
import '../../data/repositories/listing_repository.dart';

// ─── States ──────────────────────────────────────────────────────────────────

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

// ─── Cubit ───────────────────────────────────────────────────────────────────

class HomeCubit extends Cubit<HomeState> {
  final ListingRepository _repository;

  HomeCubit(this._repository) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      // Try fetching from backend
      final results = await Future.wait([
        _repository.getListings(queryParams: {'limit': '6'}),
        _repository.getFeaturedListings(),
        _repository.getListings(queryParams: {'minPrice': '4000000', 'limit': '4'}),
        _repository.getListings(queryParams: {'sort': 'createdAt_desc', 'limit': '6'}),
      ]);

      // If DB is empty, fall back to mock data so app always shows content
      final allEmpty = results.every((r) => r.isEmpty);
      if (allEmpty) {
        emit(HomeLoaded(
          recommended: mockListings,
          featured: mockListings.where((l) => l.isFeatured).toList(),
          luxury: mockListings.where((l) => l.price > 4000000).toList(),
          recent: mockListings.reversed.toList(),
        ));
      } else {
        emit(HomeLoaded(
          recommended: results[0],
          featured: results[1].isNotEmpty ? results[1] : results[0],
          luxury: results[2].isNotEmpty ? results[2] : results[0],
          recent: results[3],
        ));
      }
    } catch (e) {
      // If there's a network error (e.g. no internet), show the error state
      // so the user knows they are offline.
      emit(const HomeError('No internet connection. Please check your network and try again.'));
    }
  }
}
