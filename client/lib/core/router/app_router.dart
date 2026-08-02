import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/profile_completion_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/listing/presentation/pages/listing_detail_page.dart';
import '../../features/listing/presentation/pages/create_listing_page.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';
import '../../features/chat/presentation/pages/chat_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/dealer/presentation/pages/dealer_page.dart';
import '../shell/main_shell.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      // Auth routes
      GoRoute(path: '/login', builder: (ctx, state) => const LoginPage()),
      GoRoute(path: '/otp', builder: (ctx, state) => OtpVerificationPage(phone: state.extra as String)),
      GoRoute(path: '/complete-profile', builder: (ctx, state) => const ProfileCompletionPage()),

      // Main shell with bottom nav
      ShellRoute(
        builder: (ctx, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/home', builder: (ctx, state) => const HomePage()),
          GoRoute(path: '/search', builder: (ctx, state) => const SearchPage()),
          GoRoute(path: '/sell', builder: (ctx, state) => const CreateListingPage()),
          GoRoute(path: '/chat', builder: (ctx, state) => const ChatListPage()),
          GoRoute(path: '/profile', builder: (ctx, state) => const ProfilePage()),
        ],
      ),

      // Detail routes
      GoRoute(
        path: '/listing/:id',
        builder: (ctx, state) => ListingDetailPage(listingId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/chat/:id',
        builder: (ctx, state) => ChatDetailPage(chatId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: '/dealer/:slug',
        builder: (ctx, state) => DealerPage(slug: state.pathParameters['slug']!),
      ),
      GoRoute(path: '/favorites', builder: (ctx, state) => const FavoritesPage()),
    ],
  );
}
