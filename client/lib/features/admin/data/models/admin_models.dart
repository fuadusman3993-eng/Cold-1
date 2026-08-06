import 'package:dio/dio.dart';

class AdminStats {
  final int totalUsers;
  final int activeUsers;
  final int suspendedUsers;
  final int newUsersToday;
  final int newUsersThisWeek;
  final int newUsersThisMonth;
  final int totalListings;
  final int activeListings;
  final int pendingListings;
  final int soldListings;
  final int newListingsToday;
  final int newListingsThisWeek;
  final int newListingsThisMonth;
  final List<Map<String, dynamic>> recentActivity;

  const AdminStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.suspendedUsers,
    required this.newUsersToday,
    required this.newUsersThisWeek,
    required this.newUsersThisMonth,
    required this.totalListings,
    required this.activeListings,
    required this.pendingListings,
    required this.soldListings,
    required this.newListingsToday,
    required this.newListingsThisWeek,
    required this.newListingsThisMonth,
    required this.recentActivity,
  });

  factory AdminStats.fromJson(Map<String, dynamic> j) => AdminStats(
        totalUsers: j['users']?['total'] ?? 0,
        activeUsers: j['users']?['active'] ?? 0,
        suspendedUsers: j['users']?['suspended'] ?? 0,
        newUsersToday: j['users']?['newToday'] ?? 0,
        newUsersThisWeek: j['users']?['newThisWeek'] ?? 0,
        newUsersThisMonth: j['users']?['newThisMonth'] ?? 0,
        totalListings: j['listings']?['total'] ?? 0,
        activeListings: j['listings']?['active'] ?? 0,
        pendingListings: j['listings']?['pending'] ?? 0,
        soldListings: j['listings']?['sold'] ?? 0,
        newListingsToday: j['listings']?['newToday'] ?? 0,
        newListingsThisWeek: j['listings']?['newThisWeek'] ?? 0,
        newListingsThisMonth: j['listings']?['newThisMonth'] ?? 0,
        recentActivity: List<Map<String, dynamic>>.from(j['recentActivity'] ?? []),
      );

  factory AdminStats.empty() => const AdminStats(
        totalUsers: 0, activeUsers: 0, suspendedUsers: 0,
        newUsersToday: 0, newUsersThisWeek: 0, newUsersThisMonth: 0,
        totalListings: 0, activeListings: 0, pendingListings: 0, soldListings: 0,
        newListingsToday: 0, newListingsThisWeek: 0, newListingsThisMonth: 0,
        recentActivity: [],
      );
}

class AdminUser {
  final String id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String role;
  final String status;
  final bool isVerified;
  final DateTime createdAt;
  final int listingCount;

  const AdminUser({
    required this.id,
    this.fullName,
    this.email,
    this.phone,
    required this.role,
    required this.status,
    required this.isVerified,
    required this.createdAt,
    required this.listingCount,
  });

  factory AdminUser.fromJson(Map<String, dynamic> j) => AdminUser(
        id: j['id'],
        fullName: j['fullName'],
        email: j['email'],
        phone: j['phone'],
        role: j['role'],
        status: j['status'] ?? 'ACTIVE',
        isVerified: j['isVerified'] ?? false,
        createdAt: DateTime.parse(j['createdAt']),
        listingCount: j['_count']?['listings'] ?? 0,
      );
}

class AdminListing {
  final String id;
  final String make;
  final String model;
  final int year;
  final double price;
  final String status;
  final String location;
  final String? imageUrl;
  final String? sellerName;
  final String? sellerPhone;
  final DateTime createdAt;

  const AdminListing({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    required this.status,
    required this.location,
    this.imageUrl,
    this.sellerName,
    this.sellerPhone,
    required this.createdAt,
  });

  factory AdminListing.fromJson(Map<String, dynamic> j) => AdminListing(
        id: j['id'],
        make: j['make'],
        model: j['model'],
        year: j['year'],
        price: (j['price'] as num).toDouble(),
        status: j['status'],
        location: j['location'],
        imageUrl: j['images'] != null && (j['images'] as List).isNotEmpty
            ? j['images'][0]['url']
            : null,
        sellerName: j['seller']?['fullName'],
        sellerPhone: j['seller']?['phone'],
        createdAt: DateTime.parse(j['createdAt']),
      );
}

class AdminPaginatedResult<T> {
  final List<T> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const AdminPaginatedResult({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });
}
