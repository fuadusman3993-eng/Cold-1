import { Injectable, NotFoundException, BadRequestException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async getProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      include: {
        dealerProfile: true,
        _count: { select: { listings: true, favorites: true } },
      },
    });
    if (!user) throw new NotFoundException('User not found');
    return { status: 'success', data: user };
  }

  async updateProfile(userId: string, dto: any) {
    const user = await this.prisma.user.update({
      where: { id: userId },
      data: {
        fullName: dto.fullName,
        email: dto.email,
        city: dto.city,
        language: dto.language,
        avatarUrl: dto.avatarUrl,
        isProfileComplete: !!(dto.fullName && dto.email),
      },
    });
    return { status: 'success', data: user };
  }

  async getPublicProfile(userId: string) {
    const user = await this.prisma.user.findUnique({
      where: { id: userId },
      select: {
        id: true,
        fullName: true,
        avatarUrl: true,
        role: true,
        city: true,
        createdAt: true,
        dealerProfile: { select: { businessName: true, logoUrl: true, isVerified: true, rating: true } },
        _count: { select: { listings: true } },
      },
    });
    if (!user) throw new NotFoundException('User not found');
    return { status: 'success', data: user };
  }

  async getMyListings(userId: string) {
    const listings = await this.prisma.listing.findMany({
      where: { sellerId: userId },
      include: { images: { orderBy: { order: 'asc' }, take: 1 } },
      orderBy: { createdAt: 'desc' },
    });
    return { status: 'success', data: listings };
  }

  async deleteAccount(userId: string) {
    await this.prisma.user.delete({ where: { id: userId } });
    return { status: 'success', message: 'Account deleted' };
  }
}
