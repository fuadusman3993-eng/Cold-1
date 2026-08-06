import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/models/admin_models.dart';
import '../../data/repositories/admin_repository.dart';
import '../../../../core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/admin_cubit.dart';

// ─── Admin Section Enum ──────────────────────────────────────────────────────

enum _AdminSection {
  overview,
  users,
  listings,
  notifications,
  auditLogs,
  settings,
}

extension _AdminSectionExt on _AdminSection {
  String get label {
    switch (this) {
      case _AdminSection.overview: return 'Overview';
      case _AdminSection.users: return 'Users';
      case _AdminSection.listings: return 'Listings';
      case _AdminSection.notifications: return 'Notifications';
      case _AdminSection.auditLogs: return 'Audit Logs';
      case _AdminSection.settings: return 'Settings';
    }
  }

  IconData get icon {
    switch (this) {
      case _AdminSection.overview: return Icons.dashboard_rounded;
      case _AdminSection.users: return Icons.people_rounded;
      case _AdminSection.listings: return Icons.directions_car_rounded;
      case _AdminSection.notifications: return Icons.notifications_rounded;
      case _AdminSection.auditLogs: return Icons.history_rounded;
      case _AdminSection.settings: return Icons.settings_rounded;
    }
  }
}

// ─── Entry Point ─────────────────────────────────────────────────────────────

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  _AdminSection _section = _AdminSection.overview;
  late AdminCubit _cubit;

  @override
  void initState() {
    super.initState();
    _initCubit();
  }

  Future<void> _initCubit() async {
    final prefs = await SharedPreferences.getInstance();
    _cubit = AdminCubit(AdminRepository(ApiClient(prefs)));
    _cubit.loadStats();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const SizedBox.shrink();
    final mq = MediaQuery.of(context);
    final isDesktop = mq.size.width >= 800;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        appBar: isDesktop
            ? null
            : AppBar(
                backgroundColor: AppColors.bgSecondary,
                title: const Row(
                  children: [
                    Icon(Icons.admin_panel_settings_rounded, color: AppColors.goldPrimary, size: 22),
                    SizedBox(width: 8),
                    Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  ],
                ),
              ),
        drawer: isDesktop ? null : _buildDrawer(),
        body: isDesktop ? _buildDesktopLayout() : _buildBody(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        _buildSidebar(),
        const VerticalDivider(width: 1, thickness: 1, color: AppColors.borderSubtle),
        Expanded(child: _buildBody()),
      ],
    );
  }

  // ─── SIDEBAR ────────────────────────────────────────────────────────────────

  Widget _buildSidebar() {
    return SizedBox(
      width: 220,
      child: Container(
        color: AppColors.bgSecondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                    child: const Icon(Icons.directions_car_rounded, color: Colors.black, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EthioDrive', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.white)),
                      Text('Admin Panel', style: TextStyle(fontSize: 11, color: AppColors.goldPrimary)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.borderSubtle, height: 1),
            const SizedBox(height: 8),
            ..._AdminSection.values.map((s) => _SidebarItem(
              section: s,
              isActive: _section == s,
              onTap: () => _navigateTo(s),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.bgSecondary,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: const BoxDecoration(gradient: AppColors.goldGradient, shape: BoxShape.circle),
                    child: const Icon(Icons.directions_car_rounded, color: Colors.black, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EthioDrive', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.white)),
                      Text('Admin Panel', style: TextStyle(fontSize: 11, color: AppColors.goldPrimary)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.borderSubtle),
            ..._AdminSection.values.map((s) => _SidebarItem(
              section: s,
              isActive: _section == s,
              onTap: () {
                Navigator.pop(context);
                _navigateTo(s);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _navigateTo(_AdminSection s) {
    HapticFeedback.selectionClick();
    setState(() => _section = s);
    switch (s) {
      case _AdminSection.overview: _cubit.loadStats(); break;
      case _AdminSection.users: _cubit.loadUsers(); break;
      case _AdminSection.listings: _cubit.loadListings(); break;
      default: break;
    }
  }

  // ─── BODY ───────────────────────────────────────────────────────────────────

  Widget _buildBody() {
    switch (_section) {
      case _AdminSection.overview: return _OverviewSection(cubit: _cubit);
      case _AdminSection.users: return _UsersSection(cubit: _cubit);
      case _AdminSection.listings: return _ListingsSection(cubit: _cubit);
      case _AdminSection.notifications: return _PlaceholderSection(label: 'Notifications', icon: Icons.notifications_rounded);
      case _AdminSection.auditLogs: return _PlaceholderSection(label: 'Audit Logs', icon: Icons.history_rounded);
      case _AdminSection.settings: return _PlaceholderSection(label: 'Settings', icon: Icons.settings_rounded);
    }
  }
}

// ─── Sidebar Item ─────────────────────────────────────────────────────────────

class _SidebarItem extends StatelessWidget {
  final _AdminSection section;
  final bool isActive;
  final VoidCallback onTap;

  const _SidebarItem({required this.section, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.goldPrimary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isActive ? Border.all(color: AppColors.goldPrimary.withOpacity(0.3)) : null,
        ),
        child: Row(
          children: [
            Icon(section.icon, size: 18, color: isActive ? AppColors.goldPrimary : AppColors.textTertiary),
            const SizedBox(width: 10),
            Text(section.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                  color: isActive ? AppColors.goldPrimary : AppColors.textSecondary,
                )),
          ],
        ),
      ),
    );
  }
}

// ─── OVERVIEW SECTION ─────────────────────────────────────────────────────────

class _OverviewSection extends StatelessWidget {
  final AdminCubit cubit;
  const _OverviewSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (ctx, state) {
        return RefreshIndicator(
          color: AppColors.goldPrimary,
          backgroundColor: AppColors.bgSecondary,
          onRefresh: cubit.loadStats,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 4),
                const Text('Real-time dashboard statistics', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 20),

                if (state is AdminLoading)
                  const Center(child: CircularProgressIndicator(color: AppColors.goldPrimary))
                else if (state is AdminError)
                  _ErrorWidget(message: state.message, onRetry: cubit.loadStats)
                else if (state is AdminStatsLoaded) ...[
                  _buildUserStats(state.stats),
                  const SizedBox(height: 20),
                  _buildListingStats(state.stats),
                  const SizedBox(height: 28),
                  const Text('Recent Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 12),
                  ...state.stats.recentActivity.map((a) => _ActivityCard(activity: a)),
                ] else
                  const Center(child: Text('Loading...', style: TextStyle(color: AppColors.textSecondary))),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserStats(AdminStats s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('👥 Users', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _StatCard(label: 'Total Users', value: s.totalUsers.toString(), icon: Icons.people_rounded, color: AppColors.info)),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'Active', value: s.activeUsers.toString(), icon: Icons.check_circle_rounded, color: AppColors.success)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StatCard(label: 'Suspended', value: s.suspendedUsers.toString(), icon: Icons.block_rounded, color: AppColors.error)),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'This Month', value: '+${s.newUsersThisMonth}', icon: Icons.trending_up_rounded, color: AppColors.goldPrimary)),
          ],
        ),
      ],
    );
  }

  Widget _buildListingStats(AdminStats s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('🚗 Listings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textSecondary)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _StatCard(label: 'Total Listings', value: s.totalListings.toString(), icon: Icons.directions_car_rounded, color: AppColors.info)),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'Active', value: s.activeListings.toString(), icon: Icons.check_rounded, color: AppColors.success)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _StatCard(label: 'Pending Review', value: s.pendingListings.toString(), icon: Icons.pending_rounded, color: AppColors.warning)),
            const SizedBox(width: 12),
            Expanded(child: _StatCard(label: 'New Today', value: '+${s.newListingsToday}', icon: Icons.fiber_new_rounded, color: AppColors.goldPrimary)),
          ],
        ),
      ],
    );
  }
}

// ─── USERS SECTION ────────────────────────────────────────────────────────────

class _UsersSection extends StatefulWidget {
  final AdminCubit cubit;
  const _UsersSection({required this.cubit});

  @override
  State<_UsersSection> createState() => _UsersSectionState();
}

class _UsersSectionState extends State<_UsersSection> {
  final _searchCtrl = TextEditingController();
  String? _roleFilter;
  String? _statusFilter;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    widget.cubit.loadUsers();
  }

  void _reload() {
    widget.cubit.loadUsers(
      page: _page,
      search: _searchCtrl.text,
      role: _roleFilter,
      status: _statusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (ctx, state) {
        if (state is AdminActionSuccess) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.success,
          ));
          _reload();
        } else if (state is AdminError) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.error,
          ));
        }
      },
      builder: (ctx, state) {
        return Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Users', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search name, email, or phone...',
                      prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary),
                      suffixIcon: _searchCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.textTertiary),
                              onPressed: () { _searchCtrl.clear(); _reload(); },
                            )
                          : null,
                    ),
                    onChanged: (_) => _reload(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _FilterChip(
                        label: 'All Roles',
                        selected: _roleFilter == null,
                        onTap: () => setState(() { _roleFilter = null; _reload(); }),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Admin',
                        selected: _roleFilter == 'ADMIN',
                        onTap: () => setState(() { _roleFilter = _roleFilter == 'ADMIN' ? null : 'ADMIN'; _reload(); }),
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Suspended',
                        selected: _statusFilter == 'SUSPENDED',
                        onTap: () => setState(() { _statusFilter = _statusFilter == 'SUSPENDED' ? null : 'SUSPENDED'; _reload(); }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: state is AdminLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.goldPrimary))
                  : state is AdminError
                      ? _ErrorWidget(message: state.message, onRetry: _reload)
                      : state is AdminUsersLoaded
                          ? RefreshIndicator(
                              onRefresh: () async => _reload(),
                              color: AppColors.goldPrimary,
                              child: state.result.data.isEmpty
                                  ? const _EmptyState(label: 'No users found')
                                  : ListView.separated(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      itemCount: state.result.data.length,
                                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                                      itemBuilder: (_, i) => _UserCard(
                                        user: state.result.data[i],
                                        onStatusChange: (status) => _confirmAndUpdateUserStatus(ctx, state.result.data[i], status),
                                      ),
                                    ),
                            )
                          : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }

  void _confirmAndUpdateUserStatus(BuildContext ctx, AdminUser user, String status) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgSecondary,
        title: Text('${status == 'SUSPENDED' ? 'Suspend' : 'Activate'} User?',
            style: const TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to ${status == 'SUSPENDED' ? 'suspend' : 'activate'} ${user.fullName ?? user.email}?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: status == 'SUSPENDED' ? AppColors.error : AppColors.success,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              widget.cubit.updateUserStatus(user.id, status);
            },
            child: Text(status == 'SUSPENDED' ? 'Suspend' : 'Activate'),
          ),
        ],
      ),
    );
  }
}

// ─── LISTINGS SECTION ─────────────────────────────────────────────────────────

class _ListingsSection extends StatefulWidget {
  final AdminCubit cubit;
  const _ListingsSection({required this.cubit});

  @override
  State<_ListingsSection> createState() => _ListingsSectionState();
}

class _ListingsSectionState extends State<_ListingsSection> {
  final _searchCtrl = TextEditingController();
  String? _statusFilter;
  int _page = 1;
  final Set<String> _selected = {};
  bool _bulkMode = false;

  @override
  void initState() {
    super.initState();
    widget.cubit.loadListings();
  }

  void _reload() {
    setState(() => _selected.clear());
    widget.cubit.loadListings(
      page: _page,
      search: _searchCtrl.text,
      status: _statusFilter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (ctx, state) {
        if (state is AdminActionSuccess) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(state.message), backgroundColor: AppColors.success,
          ));
          _reload();
        } else if (state is AdminError) {
          ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
            content: Text(state.message), backgroundColor: AppColors.error,
          ));
        }
      },
      builder: (ctx, state) {
        final listings = state is AdminListingsLoaded ? state.result.data : <AdminListing>[];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Listings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
                      const Spacer(),
                      if (_selected.isNotEmpty) ...[
                        _ActionBtn(
                          label: 'Approve (${_selected.length})',
                          color: AppColors.success,
                          onTap: () => _confirmBulkAction(ctx, 'ACTIVE'),
                        ),
                        const SizedBox(width: 8),
                        _ActionBtn(
                          label: 'Reject (${_selected.length})',
                          color: AppColors.error,
                          onTap: () => _confirmBulkAction(ctx, 'PAUSED'),
                        ),
                      ],
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => setState(() { _bulkMode = !_bulkMode; _selected.clear(); }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _bulkMode ? AppColors.goldPrimary.withOpacity(0.2) : AppColors.bgSecondary,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _bulkMode ? AppColors.goldPrimary : AppColors.borderSubtle),
                          ),
                          child: Text('Bulk', style: TextStyle(
                            fontSize: 12,
                            color: _bulkMode ? AppColors.goldPrimary : AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search by make, model or location...',
                      prefixIcon: Icon(Icons.search, color: AppColors.textTertiary),
                    ),
                    onChanged: (_) => _reload(),
                  ),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ['All', 'UNDER_REVIEW', 'ACTIVE', 'PAUSED', 'SOLD'].map((s) {
                        final selected = s == 'All' ? _statusFilter == null : _statusFilter == s;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _FilterChip(
                            label: s == 'UNDER_REVIEW' ? 'Pending' : s == 'All' ? 'All' : s.capitalize(),
                            selected: selected,
                            onTap: () => setState(() {
                              _statusFilter = s == 'All' ? null : s;
                              _reload();
                            }),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: state is AdminLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.goldPrimary))
                  : state is AdminError
                      ? _ErrorWidget(message: state.message, onRetry: _reload)
                      : listings.isEmpty
                          ? const _EmptyState(label: 'No listings found')
                          : RefreshIndicator(
                              onRefresh: () async => _reload(),
                              color: AppColors.goldPrimary,
                              child: ListView.separated(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: listings.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 8),
                                itemBuilder: (_, i) => _ListingCard(
                                  listing: listings[i],
                                  bulkMode: _bulkMode,
                                  isSelected: _selected.contains(listings[i].id),
                                  onSelect: (v) => setState(() {
                                    if (v) _selected.add(listings[i].id);
                                    else _selected.remove(listings[i].id);
                                  }),
                                  onApprove: () => _confirmSingleAction(ctx, listings[i], 'ACTIVE'),
                                  onReject: () => _confirmSingleAction(ctx, listings[i], 'PAUSED'),
                                  onDelete: () => _confirmDelete(ctx, listings[i]),
                                ),
                              ),
                            ),
            ),
          ],
        );
      },
    );
  }

  void _confirmBulkAction(BuildContext ctx, String status) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgSecondary,
        title: Text('Bulk ${status == 'ACTIVE' ? 'Approve' : 'Reject'}?',
            style: const TextStyle(color: Colors.white)),
        content: Text(
          '${status == 'ACTIVE' ? 'Approve' : 'Reject'} ${_selected.length} selected listings?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: status == 'ACTIVE' ? AppColors.success : AppColors.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              widget.cubit.bulkUpdateListingStatus(_selected.toList(), status);
            },
            child: Text(status == 'ACTIVE' ? 'Approve All' : 'Reject All'),
          ),
        ],
      ),
    );
  }

  void _confirmSingleAction(BuildContext ctx, AdminListing listing, String status) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgSecondary,
        title: Text('${status == 'ACTIVE' ? 'Approve' : 'Reject'} Listing?',
            style: const TextStyle(color: Colors.white)),
        content: Text('${listing.year} ${listing.make} ${listing.model}',
            style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: status == 'ACTIVE' ? AppColors.success : AppColors.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              widget.cubit.updateListingStatus(listing.id, status);
            },
            child: Text(status == 'ACTIVE' ? 'Approve' : 'Reject'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext ctx, AdminListing listing) {
    showDialog(
      context: ctx,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.bgSecondary,
        title: const Text('Delete Listing?', style: TextStyle(color: Colors.white)),
        content: Text('This will permanently delete ${listing.year} ${listing.make} ${listing.model}.',
            style: const TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.pop(ctx);
              widget.cubit.deleteListing(listing.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── PLACEHOLDER SECTION ──────────────────────────────────────────────────────

class _PlaceholderSection extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderSection({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: AppColors.textTertiary),
          const SizedBox(height: 16),
          Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
          const SizedBox(height: 8),
          const Text('Coming soon...', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }
}

// ─── REUSABLE WIDGETS ─────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activity;
  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final createdAt = activity['createdAt'] != null
        ? DateFormat('MMM d, h:mm a').format(DateTime.parse(activity['createdAt']))
        : '';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.goldPrimary, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity['action'] ?? '', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
                Text('by ${activity['admin']?['fullName'] ?? 'Admin'}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(createdAt, style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final AdminUser user;
  final void Function(String) onStatusChange;
  const _UserCard({required this.user, required this.onStatusChange});

  @override
  Widget build(BuildContext context) {
    final isSuspended = user.status == 'SUSPENDED';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bgSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isSuspended ? AppColors.error.withOpacity(0.3) : AppColors.borderSubtle),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.goldPrimary.withOpacity(0.2),
            child: Text(
              (user.fullName ?? user.email ?? '?')[0].toUpperCase(),
              style: const TextStyle(color: AppColors.goldPrimary, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName ?? 'Unknown', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
                Text(user.email ?? user.phone ?? '', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _RoleBadge(role: user.role),
                    const SizedBox(width: 6),
                    if (isSuspended)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.error.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                        child: const Text('SUSPENDED', style: TextStyle(fontSize: 9, color: AppColors.error, fontWeight: FontWeight.w700)),
                      ),
                    const Spacer(),
                    Text('${user.listingCount} listings', style: const TextStyle(fontSize: 11, color: AppColors.textTertiary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            color: AppColors.bgTertiary,
            icon: const Icon(Icons.more_vert, color: AppColors.textTertiary, size: 18),
            onSelected: onStatusChange,
            itemBuilder: (_) => [
              PopupMenuItem(
                value: isSuspended ? 'ACTIVE' : 'SUSPENDED',
                child: Row(
                  children: [
                    Icon(isSuspended ? Icons.check_circle : Icons.block, size: 16, color: isSuspended ? AppColors.success : AppColors.error),
                    const SizedBox(width: 8),
                    Text(isSuspended ? 'Activate' : 'Suspend', style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final AdminListing listing;
  final bool bulkMode;
  final bool isSelected;
  final ValueChanged<bool> onSelect;
  final VoidCallback onApprove;
  final VoidCallback onReject;
  final VoidCallback onDelete;

  const _ListingCard({
    required this.listing,
    required this.bulkMode,
    required this.isSelected,
    required this.onSelect,
    required this.onApprove,
    required this.onReject,
    required this.onDelete,
  });

  Color get _statusColor {
    switch (listing.status) {
      case 'ACTIVE': return AppColors.success;
      case 'UNDER_REVIEW': return AppColors.warning;
      case 'PAUSED': return AppColors.error;
      case 'SOLD': return AppColors.info;
      default: return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: bulkMode ? () => onSelect(!isSelected) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.goldPrimary.withOpacity(0.08) : AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.goldPrimary : AppColors.borderSubtle,
          ),
        ),
        child: Row(
          children: [
            if (bulkMode) ...[
              Checkbox(
                value: isSelected,
                onChanged: (v) => onSelect(v ?? false),
                activeColor: AppColors.goldPrimary,
              ),
              const SizedBox(width: 8),
            ],
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60, height: 52,
                color: AppColors.bgTertiary,
                child: listing.imageUrl != null
                    ? Image.network(listing.imageUrl!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.directions_car, color: AppColors.textTertiary))
                    : const Icon(Icons.directions_car, color: AppColors.textTertiary),
              ),
            ),
            const SizedBox(width: 12),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${listing.year} ${listing.make} ${listing.model}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('ETB ${NumberFormat('#,###').format(listing.price)}',
                      style: const TextStyle(fontSize: 12, color: AppColors.goldPrimary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: _statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(listing.status, style: TextStyle(fontSize: 9, color: _statusColor, fontWeight: FontWeight.w700)),
                      ),
                      const SizedBox(width: 6),
                      Flexible(child: Text(listing.sellerName ?? '', style: const TextStyle(fontSize: 10, color: AppColors.textTertiary), overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ],
              ),
            ),
            if (!bulkMode)
              PopupMenuButton<String>(
                color: AppColors.bgTertiary,
                icon: const Icon(Icons.more_vert, color: AppColors.textTertiary, size: 18),
                onSelected: (v) {
                  if (v == 'approve') onApprove();
                  if (v == 'reject') onReject();
                  if (v == 'delete') onDelete();
                },
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'approve', child: Row(children: [Icon(Icons.check_circle, size: 16, color: AppColors.success), SizedBox(width: 8), Text('Approve', style: TextStyle(color: Colors.white))])),
                  const PopupMenuItem(value: 'reject', child: Row(children: [Icon(Icons.cancel, size: 16, color: AppColors.error), SizedBox(width: 8), Text('Reject', style: TextStyle(color: Colors.white))])),
                  const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete, size: 16, color: AppColors.error), SizedBox(width: 8), Text('Delete', style: TextStyle(color: Colors.white))])),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String role;
  const _RoleBadge({required this.role});

  Color get _color {
    switch (role) {
      case 'ADMIN': return AppColors.error;
      case 'SUPER_ADMIN': return AppColors.goldPrimary;
      case 'MODERATOR': return AppColors.info;
      case 'DEALER': return AppColors.success;
      default: return AppColors.textTertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: _color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
      child: Text(role, style: TextStyle(fontSize: 9, color: _color, fontWeight: FontWeight.w700)),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.goldPrimary : AppColors.bgSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.goldPrimary : AppColors.borderSubtle),
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
            color: selected ? Colors.black : AppColors.textSecondary)),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn({required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.4))),
        child: Text(label, style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 48, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(color: AppColors.textSecondary), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, color: AppColors.goldPrimary),
            label: const Text('Retry', style: TextStyle(color: AppColors.goldPrimary)),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String label;
  const _EmptyState({required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox_rounded, size: 56, color: AppColors.textTertiary),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
        ],
      ),
    );
  }
}

extension StringExt on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
}
