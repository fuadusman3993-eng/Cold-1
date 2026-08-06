import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/features/home/presentation/pages/home_page.dart';
import 'package:ethiodrive/features/auth/presentation/pages/login_page.dart';
import 'package:ethiodrive/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:ethiodrive/features/auth/presentation/pages/profile_completion_page.dart';
import 'package:ethiodrive/features/search/presentation/pages/search_page.dart';
import 'package:ethiodrive/features/listing/presentation/pages/listing_detail_page.dart';
import 'package:ethiodrive/features/listing/presentation/pages/create_listing_page.dart';
import 'package:ethiodrive/features/chat/presentation/pages/chat_list_page.dart';
import 'package:ethiodrive/features/chat/presentation/pages/chat_detail_page.dart';
import 'package:ethiodrive/features/profile/presentation/pages/profile_page.dart';
import 'package:ethiodrive/features/favorites/presentation/pages/favorites_page.dart';
import 'package:ethiodrive/features/dealer/presentation/pages/dealer_page.dart';
import 'package:ethiodrive/features/offer/presentation/pages/make_offer_page.dart';
import 'package:ethiodrive/features/compare/presentation/pages/compare_page.dart';
import 'package:ethiodrive/features/admin/presentation/pages/admin_dashboard_page.dart';
import 'package:ethiodrive/core/shell/main_shell.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: '/login', builder: (ctx, state) => const LoginPage()),
      GoRoute(path: '/otp', builder: (ctx, state) => OtpVerificationPage(phone: state.extra as String? ?? '')),
      GoRoute(path: '/complete-profile', builder: (ctx, state) => const ProfileCompletionPage()),
      StatefulShellRoute.indexedStack(
        builder: (ctx, state, navigationShell) => MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [GoRoute(path: '/home', builder: (ctx, state) => const HomePage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/search', builder: (ctx, state) => const SearchPage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/sell', builder: (ctx, state) => const CreateListingPage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/chat', builder: (ctx, state) => const ChatListPage())],
          ),
          StatefulShellBranch(
            routes: [GoRoute(path: '/profile', builder: (ctx, state) => const ProfilePage())],
          ),
        ],
      ),
      GoRoute(path: '/listing/:id', builder: (ctx, state) => ListingDetailPage(listingId: state.pathParameters['id']!)),
      GoRoute(path: '/offer/:id', builder: (ctx, state) => MakeOfferPage(listingId: state.pathParameters['id']!)),
      GoRoute(path: '/compare', builder: (ctx, state) {
        final car1 = state.uri.queryParameters['car1'] ?? '1';
        final car2 = state.uri.queryParameters['car2'] ?? '2';
        return ComparePage(car1Id: car1, car2Id: car2);
      }),
      GoRoute(path: '/chat/:id', builder: (ctx, state) => ChatDetailPage(chatId: state.pathParameters['id']!)),
      GoRoute(path: '/dealer/:slug', builder: (ctx, state) => DealerPage(slug: state.pathParameters['slug']!)),
      GoRoute(path: '/favorites', builder: (ctx, state) => const FavoritesPage()),
      GoRoute(path: '/admin', builder: (ctx, state) => const AdminDashboardPage()),
    ],
  );
}
