import {
  Controller, Get, Patch, Delete, Param, Body, Query,
  UseGuards, Request,
} from '@nestjs/common';
import { AdminService } from './admin.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';
import { UserRole, ListingStatus, UserStatus } from '@prisma/client';

@Controller('admin')
@UseGuards(JwtAuthGuard, RolesGuard)
@Roles(UserRole.ADMIN, UserRole.SUPER_ADMIN, UserRole.MODERATOR)
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  // ─── STATS ─────────────────────────────────────────────────────────────────

  @Get('stats')
  getStats() {
    return this.adminService.getStats();
  }

  // ─── AUDIT LOGS ────────────────────────────────────────────────────────────

  @Get('audit-logs')
  getAuditLogs(@Query() query: { page?: number; limit?: number }) {
    return this.adminService.getAuditLogs(query);
  }

  // ─── NOTIFICATIONS ─────────────────────────────────────────────────────────

  @Get('notifications')
  getAdminNotifications() {
    return this.adminService.getAdminNotifications();
  }

  // ─── USERS ─────────────────────────────────────────────────────────────────

  @Get('users')
  getUsers(@Query() query: { page?: number; limit?: number; search?: string; role?: UserRole; status?: UserStatus; sort?: string }) {
    return this.adminService.getUsers(query);
  }

  @Get('users/:id')
  getUserById(@Param('id') id: string) {
    return this.adminService.getUserById(id);
  }

  @Patch('users/:id/status')
  updateUserStatus(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { status: UserStatus },
  ) {
    return this.adminService.updateUserStatus(req.user.id, id, body.status);
  }

  @Patch('users/:id/role')
  @Roles(UserRole.SUPER_ADMIN)  // Only Super Admins can change roles
  updateUserRole(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { role: UserRole },
  ) {
    return this.adminService.updateUserRole(req.user.id, id, body.role);
  }

  // ─── LISTINGS ──────────────────────────────────────────────────────────────

  @Get('listings')
  getListings(@Query() query: { page?: number; limit?: number; search?: string; status?: ListingStatus; sort?: string }) {
    return this.adminService.getListings(query);
  }

  @Get('listings/:id')
  getListingById(@Param('id') id: string) {
    return this.adminService.getListingById(id);
  }

  @Patch('listings/:id/status')
  updateListingStatus(
    @Request() req,
    @Param('id') id: string,
    @Body() body: { status: ListingStatus },
  ) {
    return this.adminService.updateListingStatus(req.user.id, id, body.status);
  }

  @Patch('listings/bulk/status')
  bulkUpdateListingStatus(
    @Request() req,
    @Body() body: { ids: string[]; status: ListingStatus },
  ) {
    return this.adminService.bulkUpdateListingStatus(req.user.id, body.ids, body.status);
  }

  @Delete('listings/:id')
  deleteListing(@Request() req, @Param('id') id: string) {
    return this.adminService.deleteListing(req.user.id, id);
  }

  @Delete('listings/bulk')
  bulkDeleteListings(@Request() req, @Body() body: { ids: string[] }) {
    return this.adminService.bulkDeleteListings(req.user.id, body.ids);
  }
}
