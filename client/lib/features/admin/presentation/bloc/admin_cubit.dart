import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/admin_models.dart';
import '../../data/repositories/admin_repository.dart';

// ─── States ──────────────────────────────────────────────────────────────────

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}
class AdminLoading extends AdminState {}
class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override List<Object?> get props => [message];
}

class AdminStatsLoaded extends AdminState {
  final AdminStats stats;
  const AdminStatsLoaded(this.stats);
  @override List<Object?> get props => [stats];
}

class AdminUsersLoaded extends AdminState {
  final AdminPaginatedResult<AdminUser> result;
  const AdminUsersLoaded(this.result);
  @override List<Object?> get props => [result];
}

class AdminListingsLoaded extends AdminState {
  final AdminPaginatedResult<AdminListing> result;
  const AdminListingsLoaded(this.result);
  @override List<Object?> get props => [result];
}

class AdminActionSuccess extends AdminState {
  final String message;
  const AdminActionSuccess(this.message);
  @override List<Object?> get props => [message];
}

// ─── Cubit ───────────────────────────────────────────────────────────────────

class AdminCubit extends Cubit<AdminState> {
  final AdminRepository _repo;

  AdminCubit(this._repo) : super(AdminInitial());

  Future<void> loadStats() async {
    emit(AdminLoading());
    try {
      final stats = await _repo.getStats();
      emit(AdminStatsLoaded(stats));
    } catch (e) {
      emit(AdminError('Failed to load stats: $e'));
    }
  }

  Future<void> loadUsers({
    int page = 1,
    String? search,
    String? role,
    String? status,
  }) async {
    emit(AdminLoading());
    try {
      final result = await _repo.getUsers(page: page, search: search, role: role, status: status);
      emit(AdminUsersLoaded(result));
    } catch (e) {
      emit(AdminError('Failed to load users: $e'));
    }
  }

  Future<void> loadListings({
    int page = 1,
    String? search,
    String? status,
  }) async {
    emit(AdminLoading());
    try {
      final result = await _repo.getListings(page: page, search: search, status: status);
      emit(AdminListingsLoaded(result));
    } catch (e) {
      emit(AdminError('Failed to load listings: $e'));
    }
  }

  Future<void> updateUserStatus(String userId, String status) async {
    try {
      await _repo.updateUserStatus(userId, status);
      emit(AdminActionSuccess('User status updated'));
    } catch (e) {
      emit(AdminError('Failed to update user: $e'));
    }
  }

  Future<void> updateUserRole(String userId, String role) async {
    try {
      await _repo.updateUserRole(userId, role);
      emit(AdminActionSuccess('User role updated'));
    } catch (e) {
      emit(AdminError('Failed to update role: $e'));
    }
  }

  Future<void> updateListingStatus(String listingId, String status) async {
    try {
      await _repo.updateListingStatus(listingId, status);
      emit(AdminActionSuccess('Listing $status successfully'));
    } catch (e) {
      emit(AdminError('Failed to update listing: $e'));
    }
  }

  Future<void> bulkUpdateListingStatus(List<String> ids, String status) async {
    try {
      await _repo.bulkUpdateListingStatus(ids, status);
      emit(AdminActionSuccess('${ids.length} listings $status'));
    } catch (e) {
      emit(AdminError('Bulk update failed: $e'));
    }
  }

  Future<void> deleteListing(String listingId) async {
    try {
      await _repo.deleteListing(listingId);
      emit(const AdminActionSuccess('Listing deleted'));
    } catch (e) {
      emit(AdminError('Failed to delete listing: $e'));
    }
  }

  Future<void> bulkDeleteListings(List<String> ids) async {
    try {
      await _repo.bulkDeleteListings(ids);
      emit(AdminActionSuccess('${ids.length} listings deleted'));
    } catch (e) {
      emit(AdminError('Bulk delete failed: $e'));
    }
  }
}
