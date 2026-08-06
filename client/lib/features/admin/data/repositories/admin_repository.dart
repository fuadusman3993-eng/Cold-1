import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_models.dart';

class AdminRepository {
  final ApiClient _client;

  AdminRepository(this._client);

  Dio get _dio => _client.dio;

  // ─── STATS ──────────────────────────────────────────────────────────────────

  Future<AdminStats> getStats() async {
    final res = await _dio.get('/admin/stats');
    return AdminStats.fromJson(res.data);
  }

  // ─── AUDIT LOGS ─────────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> getAuditLogs({int page = 1, int limit = 50}) async {
    final res = await _dio.get('/admin/audit-logs', queryParameters: {'page': page, 'limit': limit});
    return res.data;
  }

  // ─── USERS ──────────────────────────────────────────────────────────────────

  Future<AdminPaginatedResult<AdminUser>> getUsers({
    int page = 1,
    int limit = 20,
    String? search,
    String? role,
    String? status,
    String sort = 'newest',
  }) async {
    final res = await _dio.get('/admin/users', queryParameters: {
      'page': page, 'limit': limit,
      if (search != null && search.isNotEmpty) 'search': search,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      'sort': sort,
    });
    final data = res.data;
    return AdminPaginatedResult<AdminUser>(
      data: (data['data'] as List).map((e) => AdminUser.fromJson(e)).toList(),
      total: data['total'],
      page: data['page'],
      limit: data['limit'],
      totalPages: data['totalPages'],
    );
  }

  Future<void> updateUserStatus(String userId, String status) async {
    await _dio.patch('/admin/users/$userId/status', data: {'status': status});
  }

  Future<void> updateUserRole(String userId, String role) async {
    await _dio.patch('/admin/users/$userId/role', data: {'role': role});
  }

  // ─── LISTINGS ───────────────────────────────────────────────────────────────

  Future<AdminPaginatedResult<AdminListing>> getListings({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
    String sort = 'newest',
  }) async {
    final res = await _dio.get('/admin/listings', queryParameters: {
      'page': page, 'limit': limit,
      if (search != null && search.isNotEmpty) 'search': search,
      if (status != null) 'status': status,
      'sort': sort,
    });
    final data = res.data;
    return AdminPaginatedResult<AdminListing>(
      data: (data['data'] as List).map((e) => AdminListing.fromJson(e)).toList(),
      total: data['total'],
      page: data['page'],
      limit: data['limit'],
      totalPages: data['totalPages'],
    );
  }

  Future<void> updateListingStatus(String listingId, String status) async {
    await _dio.patch('/admin/listings/$listingId/status', data: {'status': status});
  }

  Future<void> bulkUpdateListingStatus(List<String> ids, String status) async {
    await _dio.patch('/admin/listings/bulk/status', data: {'ids': ids, 'status': status});
  }

  Future<void> deleteListing(String listingId) async {
    await _dio.delete('/admin/listings/$listingId');
  }

  Future<void> bulkDeleteListings(List<String> ids) async {
    await _dio.delete('/admin/listings/bulk', data: {'ids': ids});
  }
}
