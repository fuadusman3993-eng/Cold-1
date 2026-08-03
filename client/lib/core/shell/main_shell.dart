import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/features/ai/presentation/widgets/ai_assistant_widget.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/sell')) return 2;
    if (location.startsWith('/chat')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final idx = _selectedIndex(context);
    final mq = MediaQuery.of(context);
    final isDesktop = mq.size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: isDesktop ? _buildDesktopLayout(context, idx, child) : child,
      bottomNavigationBar:
          isDesktop ? null : _buildBottomNav(context, idx, mq),
    );
  }

  // ── DESKTOP ──────────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout(BuildContext ctx, int idx, Widget content) {
    return Row(
      children: [
        _buildDesktopRail(ctx, idx),
        const VerticalDivider(thickness: 1, width: 1, color: AppColors.borderSubtle),
        Expanded(
          child: Stack(
            children: [
              content,
              const Positioned(
                right: 24,
                bottom: 24,
                child: AIAssistantWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopRail(BuildContext ctx, int idx) {
    return NavigationRail(
      backgroundColor: AppColors.bgPrimary,
      selectedIndex: (idx == 2) ? null : idx,
      onDestinationSelected: (i) {
        HapticFeedback.selectionClick();
        switch (i) {
          case 0: ctx.go('/home'); break;
          case 1: ctx.go('/search'); break;
          case 3: ctx.go('/chat'); break;
          case 4: ctx.go('/profile'); break;
        }
      },
      selectedLabelTextStyle: const TextStyle(
          color: AppColors.goldPrimary, fontWeight: FontWeight.w700, fontSize: 12),
      unselectedLabelTextStyle: const TextStyle(
          color: AppColors.textTertiary, fontWeight: FontWeight.w400, fontSize: 12),
      selectedIconTheme: const IconThemeData(color: AppColors.goldPrimary, size: 26),
      unselectedIconTheme: const IconThemeData(color: AppColors.textTertiary, size: 26),
      useIndicator: true,
      indicatorColor: AppColors.goldPrimary.withOpacity(0.12),
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                  gradient: AppColors.goldGradient, shape: BoxShape.circle),
              child: const Icon(Icons.directions_car_rounded,
                  color: Colors.black, size: 22),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () => ctx.go('/sell'),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.goldPrimary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4))
                  ],
                ),
                child: const Icon(Icons.add_rounded, color: Colors.black, size: 24),
              ),
            ),
          ],
        ),
      ),
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search_rounded),
          label: Text('Search'),
        ),
        NavigationRailDestination(
          icon: SizedBox.shrink(),
          label: SizedBox.shrink(),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded),
          label: Text('Chat'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: Text('Profile'),
        ),
      ],
    );
  }

  // ── BOTTOM NAV ────────────────────────────────────────────────────────────────

  Widget _buildBottomNav(BuildContext ctx, int idx, MediaQueryData mq) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondary,
        border: Border(top: BorderSide(color: AppColors.borderSubtle, width: 0.5)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _NavItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home_rounded,
                      label: 'Home',
                      isActive: idx == 0,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        ctx.go('/home');
                      },
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.search_outlined,
                      activeIcon: Icons.search_rounded,
                      label: 'Search',
                      isActive: idx == 1,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        ctx.go('/search');
                      },
                    ),
                  ),
                  // Center gap for FAB
                  const SizedBox(width: 72),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      activeIcon: Icons.chat_bubble_rounded,
                      label: 'Chat',
                      isActive: idx == 3,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        ctx.go('/chat');
                      },
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.person_outline_rounded,
                      activeIcon: Icons.person_rounded,
                      label: 'Profile',
                      isActive: idx == 4,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        ctx.go('/profile');
                      },
                    ),
                  ),
                ],
              ),
              // Centre FAB
              Positioned(
                top: -18,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ctx.go('/sell');
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.goldPrimary.withOpacity(0.45),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add_rounded,
                        color: Colors.black, size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── NavItem ──────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, anim) =>
                  ScaleTransition(scale: anim, child: child),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive ? AppColors.goldPrimary : AppColors.textTertiary,
                size: 24,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive ? AppColors.goldPrimary : AppColors.textTertiary,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
