import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class FavoritesService {
  constructor(private prisma: PrismaService) {}

  async getMyFavorites(userId: string) {
    const favorites = await this.prisma.favorite.findMany({
      where: { userId },
      include: {
        listing: {
          include: {
            images: { orderBy: { order: 'asc' }, take: 1 },
            seller: { select: { id: true, fullName: true, avatarUrl: true } },
          },
        },
      },
      orderBy: { createdAt: 'desc' },
    });
    return { status: 'success', data: favorites.map(f => f.listing) };
  }

  async toggleFavorite(userId: string, listingId: string) {
    const existing = await this.prisma.favorite.findUnique({
      where: { userId_listingId: { userId, listingId } },
    });

    if (existing) {
      await this.prisma.favorite.delete({ where: { userId_listingId: { userId, listingId } } });
      return { status: 'success', isFavorited: false, message: 'Removed from favorites' };
    } else {
      await this.prisma.favorite.create({ data: { userId, listingId } });
      return { status: 'success', isFavorited: true, message: 'Added to favorites' };
    }
  }

  async checkFavorite(userId: string, listingId: string) {
    const fav = await this.prisma.favorite.findUnique({
      where: { userId_listingId: { userId, listingId } },
    });
    return { status: 'success', isFavorited: !!fav };
  }
}
