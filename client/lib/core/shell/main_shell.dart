import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ethiodrive/core/theme/app_colors.dart';
import 'package:ethiodrive/core/theme/app_spacing.dart';
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
    final isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          Row(
            children: [
              if (isDesktop) _buildNavigationRail(context, idx),
              if (isDesktop) const VerticalDivider(thickness: 1, width: 1, color: AppColors.borderSubtle),
              Expanded(child: child),
            ],
          ),
          const Positioned(
            right: 24,
            bottom: 100, // Above nav
            child: SafeArea(child: AIAssistantWidget()),
          ),
          // Floating Sell Button (Center bottom above nav)
          if (!isDesktop)
            Positioned(
              bottom: 40, // Floating above nav
              left: 0,
              right: 0,
              child: Center(
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () => context.go('/sell'),
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: AppColors.goldGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppColors.goldPrimary.withOpacity(0.4), blurRadius: 24, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: const Icon(Icons.add, color: AppColors.bgPrimary, size: 32),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: isDesktop ? null : _buildBottomNavigationBar(context, idx),
    );
  }

  Widget _buildNavigationRail(BuildContext context, int idx) {
    return NavigationRail(
      backgroundColor: AppColors.bgPrimary,
      selectedIndex: idx == 2 ? null : idx,
      onDestinationSelected: (i) {
        switch (i) {
          case 0: context.go('/home'); break;
          case 1: context.go('/search'); break;
          case 3: context.go('/chat'); break;
          case 4: context.go('/profile'); break;
        }
      },
      selectedLabelTextStyle: const TextStyle(color: AppColors.goldPrimary, fontWeight: FontWeight.w600, fontSize: 12),
      unselectedLabelTextStyle: const TextStyle(color: AppColors.textTertiary, fontWeight: FontWeight.w400, fontSize: 12),
      selectedIconTheme: const IconThemeData(color: AppColors.goldPrimary, size: 26),
      unselectedIconTheme: const IconThemeData(color: AppColors.textTertiary, size: 26),
      useIndicator: false,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
              child: const Icon(Icons.directions_car, color: AppColors.textInverse, size: 24),
            ),
            const SizedBox(height: 32),
            FloatingActionButton(
              elevation: 0,
              backgroundColor: AppColors.goldPrimary,
              onPressed: () => context.go('/sell'),
              child: const Icon(Icons.add, color: AppColors.bgPrimary),
            ),
          ],
        ),
      ),
      destinations: const [
        NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: Text('Home')),
        NavigationRailDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: Text('Search')),
        NavigationRailDestination(icon: SizedBox.shrink(), label: SizedBox.shrink()), // Placeholder for sell
        NavigationRailDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: Text('Chat')),
        NavigationRailDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: Text('Profile')),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, int idx) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgPrimary,
        border: Border(top: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 78,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home', isActive: idx == 0, onTap: () => context.go('/home')),
              _NavItem(icon: Icons.search_outlined, activeIcon: Icons.search, label: 'Search', isActive: idx == 1, onTap: () => context.go('/search')),
              const SizedBox(width: 80), // Space for FAB
              _NavItem(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Chat', isActive: idx == 3, onTap: () => context.go('/chat')),
              _NavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile', isActive: idx == 4, onTap: () => context.go('/profile')),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.activeIcon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
              child: Icon(
                isActive ? activeIcon : icon,
                key: ValueKey(isActive),
                color: isActive ? AppColors.goldPrimary : AppColors.textTertiary, 
                size: 26,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 12, 
                color: isActive ? AppColors.goldPrimary : AppColors.textTertiary, 
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
