import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { UserRole, UserStatus, ListingStatus } from '@prisma/client';

@Injectable()
export class AdminService {
  constructor(private prisma: PrismaService) {}

  // ─── AUDIT LOG ───────────────────────────────────────────────────────────────

  private async log(
    adminId: string,
    action: string,
    targetType: string,
    targetId: string,
    metadata?: object,
  ) {
    await this.prisma.auditLog.create({
      data: { adminId, action, targetType, targetId, metadata },
    });
  }

  // ─── NOTIFICATION ─────────────────────────────────────────────────────────────

  private async notify(
    userId: string,
    type: any,
    title: string,
    body: string,
    data?: object,
  ) {
    await this.prisma.notification.create({
      data: { userId, type, title, body, data },
    });
  }

  // ─── STATS ───────────────────────────────────────────────────────────────────

  async getStats() {
    const now = new Date();
    const startOfDay = new Date(now.setHours(0, 0, 0, 0));
    const startOfWeek = new Date(now);
    startOfWeek.setDate(now.getDate() - 7);
    const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1);

    const [
      totalUsers,
      activeUsers,
      suspendedUsers,
      totalListings,
      activeListings,
      pendingListings,
      soldListings,
      rejectedListings,
      newUsersToday,
      newUsersThisWeek,
      newUsersThisMonth,
      newListingsToday,
      newListingsThisWeek,
      newListingsThisMonth,
      recentAuditLogs,
      recentNotifications,
    ] = await this.prisma.$transaction([
      this.prisma.user.count(),
      this.prisma.user.count({ where: { status: 'ACTIVE' } }),
      this.prisma.user.count({ where: { status: 'SUSPENDED' } }),
      this.prisma.listing.count(),
      this.prisma.listing.count({ where: { status: 'ACTIVE' } }),
      this.prisma.listing.count({ where: { status: 'UNDER_REVIEW' } }),
      this.prisma.listing.count({ where: { status: 'SOLD' } }),
      this.prisma.listing.count({ where: { isFeatured: false, isPaused: true } }),
      this.prisma.user.count({ where: { createdAt: { gte: startOfDay } } }),
      this.prisma.user.count({ where: { createdAt: { gte: startOfWeek } } }),
      this.prisma.user.count({ where: { createdAt: { gte: startOfMonth } } }),
      this.prisma.listing.count({ where: { createdAt: { gte: startOfDay } } }),
      this.prisma.listing.count({ where: { createdAt: { gte: startOfWeek } } }),
      this.prisma.listing.count({ where: { createdAt: { gte: startOfMonth } } }),
      this.prisma.auditLog.findMany({ take: 10, orderBy: { createdAt: 'desc' }, include: { admin: { select: { fullName: true, email: true } } } }),
      this.prisma.notification.findMany({ take: 5, orderBy: { createdAt: 'desc' }, where: { isRead: false } }),
    ]);

    return {
      users: { total: totalUsers, active: activeUsers, suspended: suspendedUsers, newToday: newUsersToday, newThisWeek: newUsersThisWeek, newThisMonth: newUsersThisMonth },
      listings: { total: totalListings, active: activeListings, pending: pendingListings, sold: soldListings, rejected: rejectedListings, newToday: newListingsToday, newThisWeek: newListingsThisWeek, newThisMonth: newListingsThisMonth },
      recentActivity: recentAuditLogs,
      unreadNotifications: recentNotifications,
    };
  }

  // ─── USERS ────────────────────────────────────────────────────────────────────

  async getUsers(query: { page?: number; limit?: number; search?: string; role?: UserRole; status?: UserStatus; sort?: string }) {
    const { page = 1, limit = 20, search, role, status, sort = 'newest' } = query;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (search) {
      where.OR = [
        { fullName: { contains: search, mode: 'insensitive' } },
        { email: { contains: search, mode: 'insensitive' } },
        { phone: { contains: search, mode: 'insensitive' } },
      ];
    }
    if (role) where.role = role;
    if (status) where.status = status;

    const orderBy = sort === 'oldest' ? { createdAt: 'asc' } : { createdAt: 'desc' };

    const [total, users] = await this.prisma.$transaction([
      this.prisma.user.count({ where }),
      this.prisma.user.findMany({
        where,
        skip,
        take: Number(limit),
        orderBy,
        select: {
          id: true, fullName: true, email: true, phone: true,
          role: true, status: true, isVerified: true, createdAt: true,
          lastLoginAt: true, _count: { select: { listings: true } },
        },
      }),
    ]);

    return { data: users, total, page: Number(page), limit: Number(limit), totalPages: Math.ceil(total / limit) };
  }

  async getUserById(id: string) {
    return this.prisma.user.findUniqueOrThrow({
      where: { id },
      include: {
        listings: { select: { id: true, make: true, model: true, year: true, status: true, createdAt: true } },
        _count: { select: { listings: true, favorites: true } },
      },
    });
  }

  async updateUserStatus(adminId: string, userId: string, status: UserStatus) {
    const user = await this.prisma.user.update({ where: { id: userId }, data: { status } });
    await this.log(adminId, status === 'SUSPENDED' ? 'SUSPEND_USER' : 'ACTIVATE_USER', 'USER', userId, { newStatus: status });
    return user;
  }

  async updateUserRole(adminId: string, userId: string, role: UserRole) {
    const user = await this.prisma.user.update({ where: { id: userId }, data: { role } });
    await this.log(adminId, 'CHANGE_USER_ROLE', 'USER', userId, { newRole: role });
    return user;
  }

  // ─── LISTINGS ─────────────────────────────────────────────────────────────────

  async getListings(query: { page?: number; limit?: number; search?: string; status?: ListingStatus; sort?: string }) {
    const { page = 1, limit = 20, search, status, sort = 'newest' } = query;
    const skip = (page - 1) * limit;

    const where: any = {};
    if (search) {
      where.OR = [
        { make: { contains: search, mode: 'insensitive' } },
        { model: { contains: search, mode: 'insensitive' } },
        { location: { contains: search, mode: 'insensitive' } },
      ];
    }
    if (status) where.status = status;

    const orderBy = sort === 'oldest' ? { createdAt: 'asc' } : { createdAt: 'desc' };

    const [total, listings] = await this.prisma.$transaction([
      this.prisma.listing.count({ where }),
      this.prisma.listing.findMany({
        where, skip, take: Number(limit), orderBy,
        include: {
          seller: { select: { id: true, fullName: true, phone: true } },
          images: { take: 1, orderBy: { order: 'asc' } },
        },
      }),
    ]);

    return { data: listings, total, page: Number(page), limit: Number(limit), totalPages: Math.ceil(total / limit) };
  }

  async getListingById(id: string) {
    return this.prisma.listing.findUniqueOrThrow({
      where: { id },
      include: { seller: true, images: true, _count: { select: { offers: true, favorites: true } } },
    });
  }

  async updateListingStatus(adminId: string, listingId: string, status: ListingStatus) {
    const listing = await this.prisma.listing.update({ where: { id: listingId }, data: { status } });

    const action = status === 'ACTIVE' ? 'APPROVE_LISTING' : 'REJECT_LISTING';
    await this.log(adminId, action, 'LISTING', listingId, { newStatus: status });

    // Notify the seller
    const notifType = status === 'ACTIVE' ? 'LISTING_APPROVED' : 'LISTING_REJECTED';
    const title = status === 'ACTIVE' ? '✅ Your listing was approved!' : '❌ Your listing was rejected';
    const body = status === 'ACTIVE'
      ? `Your ${listing.year} ${listing.make} ${listing.model} is now live.`
      : `Your ${listing.year} ${listing.make} ${listing.model} did not meet our guidelines.`;

    await this.notify(listing.sellerId, notifType, title, body, { listingId });

    return listing;
  }

  async bulkUpdateListingStatus(adminId: string, ids: string[], status: ListingStatus) {
    await this.prisma.listing.updateMany({ where: { id: { in: ids } }, data: { status } });
    for (const id of ids) {
      await this.updateListingStatus(adminId, id, status);
    }
    return { updated: ids.length };
  }

  async deleteListing(adminId: string, listingId: string) {
    const listing = await this.prisma.listing.findUnique({ where: { id: listingId } });
    await this.prisma.listing.delete({ where: { id: listingId } });
    await this.log(adminId, 'DELETE_LISTING', 'LISTING', listingId, { make: listing?.make, model: listing?.model });
    return { deleted: true };
  }

  async bulkDeleteListings(adminId: string, ids: string[]) {
    await this.prisma.listing.deleteMany({ where: { id: { in: ids } } });
    for (const id of ids) {
      await this.log(adminId, 'DELETE_LISTING', 'LISTING', id, {});
    }
    return { deleted: ids.length };
  }

  // ─── AUDIT LOG LISTING ────────────────────────────────────────────────────────

  async getAuditLogs(query: { page?: number; limit?: number }) {
    const { page = 1, limit = 50 } = query;
    const skip = (page - 1) * limit;
    const [total, logs] = await this.prisma.$transaction([
      this.prisma.auditLog.count(),
      this.prisma.auditLog.findMany({
        skip, take: Number(limit),
        orderBy: { createdAt: 'desc' },
        include: { admin: { select: { fullName: true, email: true } } },
      }),
    ]);
    return { data: logs, total, page: Number(page), limit: Number(limit) };
  }

  // ─── NOTIFICATIONS ────────────────────────────────────────────────────────────

  async getAdminNotifications() {
    // Get all unread notifications across admin-relevant events
    return this.prisma.notification.findMany({
      where: { type: { in: ['LISTING_SUBMITTED', 'LISTING_REPORTED'] } },
      orderBy: { createdAt: 'desc' },
      take: 50,
    });
  }

  async notifyAdminsOfNewListing(listingId: string, makeName: string) {
    // Find all admins and notify them
    const admins = await this.prisma.user.findMany({
      where: { role: { in: ['ADMIN', 'SUPER_ADMIN', 'MODERATOR'] } },
      select: { id: true },
    });

    await Promise.all(admins.map(admin =>
      this.notify(admin.id, 'LISTING_SUBMITTED', '🚗 New Listing Submitted', `A new listing (${makeName}) has been submitted and needs review.`, { listingId })
    ));
  }
}
