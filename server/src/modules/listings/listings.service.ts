import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

interface ListingFilters {
  make?: string;
  model?: string;
  minPrice?: number;
  maxPrice?: number;
  minYear?: number;
  maxYear?: number;
  minMileage?: number;
  maxMileage?: number;
  bodyType?: string;
  fuelType?: string;
  transmission?: string;
  condition?: string;
  location?: string;
  isVerified?: boolean;
  isFeatured?: boolean;
  sort?: string;
  page?: number;
  limit?: number;
}

@Injectable()
export class ListingsService {
  constructor(private prisma: PrismaService) {}

  async getAll(filters: ListingFilters) {
    const {
      make, model, minPrice, maxPrice, minYear, maxYear,
      bodyType, fuelType, transmission, condition, location,
      isVerified, isFeatured, sort = 'createdAt_desc',
      page = 1, limit = 20,
    } = filters;

    const where: any = { status: 'ACTIVE', isSold: false };
    if (make) where.make = { contains: make, mode: 'insensitive' };
    if (model) where.model = { contains: model, mode: 'insensitive' };
    if (bodyType) where.bodyType = bodyType;
    if (fuelType) where.fuelType = fuelType;
    if (transmission) where.transmission = transmission;
    if (condition) where.condition = condition;
    if (location) where.location = { contains: location, mode: 'insensitive' };
    if (isVerified !== undefined) where.isVerified = isVerified;
    if (isFeatured !== undefined) where.isFeatured = isFeatured;
    if (minPrice || maxPrice) where.price = { gte: minPrice ? +minPrice : 0, lte: maxPrice ? +maxPrice : 999999999 };
    if (minYear || maxYear) where.year = { gte: minYear ? +minYear : 1900, lte: maxYear ? +maxYear : 2100 };

    const [field, dir] = sort.split('_');
    const orderBy: any = { [field === 'price' ? 'price' : field === 'mileage' ? 'mileage' : 'createdAt']: dir === 'asc' ? 'asc' : 'desc' };

    const skip = (Number(page) - 1) * Number(limit);

    const [listings, total] = await Promise.all([
      this.prisma.listing.findMany({
        where,
        include: {
          images: { orderBy: { order: 'asc' }, take: 1 },
          seller: { select: { id: true, fullName: true, avatarUrl: true, phone: true, role: true } },
        },
        orderBy,
        skip,
        take: Number(limit),
      }),
      this.prisma.listing.count({ where }),
    ]);

    return {
      status: 'success',
      data: listings,
      meta: { total, page: Number(page), limit: Number(limit), totalPages: Math.ceil(total / Number(limit)) },
    };
  }

  async getOne(id: string, userId?: string) {
    const listing = await this.prisma.listing.findUnique({
      where: { id },
      include: {
        images: { orderBy: { order: 'asc' } },
        seller: {
          select: {
            id: true, fullName: true, avatarUrl: true, phone: true, role: true,
            dealerProfile: { select: { businessName: true, logoUrl: true, isVerified: true, rating: true, phone: true } },
          },
        },
        _count: { select: { offers: true, favorites: true } },
      },
    });

    if (!listing) throw new NotFoundException('Listing not found');

    // Increment view count
    await this.prisma.listing.update({ where: { id }, data: { viewCount: { increment: 1 } } });

    // Check if current user favorited this
    let isFavorited = false;
    if (userId) {
      const fav = await this.prisma.favorite.findUnique({ where: { userId_listingId: { userId, listingId: id } } });
      isFavorited = !!fav;
    }

    return { status: 'success', data: { ...listing, isFavorited } };
  }

  async create(userId: string, dto: any) {
    const listing = await this.prisma.listing.create({
      data: {
        sellerId: userId,
        make: dto.make,
        model: dto.model,
        year: +dto.year,
        price: +dto.price,
        mileage: +dto.mileage,
        transmission: dto.transmission,
        fuelType: dto.fuelType,
        bodyType: dto.bodyType,
        condition: dto.condition,
        color: dto.color,
        description: dto.description,
        location: dto.location,
        latitude: dto.latitude ? +dto.latitude : null,
        longitude: dto.longitude ? +dto.longitude : null,
        images: dto.images?.length
          ? { create: dto.images.map((url: string, i: number) => ({ url, order: i })) }
          : undefined,
      },
      include: { images: true },
    });

    return { status: 'success', data: listing };
  }

  async update(id: string, userId: string, dto: any) {
    const listing = await this.prisma.listing.findUnique({ where: { id } });
    if (!listing) throw new NotFoundException('Listing not found');
    if (listing.sellerId !== userId) throw new ForbiddenException('Not your listing');

    const updated = await this.prisma.listing.update({
      where: { id },
      data: {
        make: dto.make,
        model: dto.model,
        year: dto.year ? +dto.year : undefined,
        price: dto.price ? +dto.price : undefined,
        mileage: dto.mileage ? +dto.mileage : undefined,
        transmission: dto.transmission,
        fuelType: dto.fuelType,
        bodyType: dto.bodyType,
        condition: dto.condition,
        color: dto.color,
        description: dto.description,
        location: dto.location,
        status: dto.status,
      },
    });
    return { status: 'success', data: updated };
  }

  async remove(id: string, userId: string, userRole: string) {
    const listing = await this.prisma.listing.findUnique({ where: { id } });
    if (!listing) throw new NotFoundException('Listing not found');
    if (listing.sellerId !== userId && userRole !== 'ADMIN') throw new ForbiddenException();
    await this.prisma.listing.delete({ where: { id } });
    return { status: 'success', message: 'Listing deleted' };
  }

  async getFeatured() {
    const listings = await this.prisma.listing.findMany({
      where: { isFeatured: true, status: 'ACTIVE', isSold: false },
      include: { images: { orderBy: { order: 'asc' }, take: 1 }, seller: { select: { id: true, fullName: true } } },
      take: 10,
    });
    return { status: 'success', data: listings };
  }

  async markSold(id: string, userId: string) {
    const listing = await this.prisma.listing.findUnique({ where: { id } });
    if (!listing) throw new NotFoundException();
    if (listing.sellerId !== userId) throw new ForbiddenException();
    const updated = await this.prisma.listing.update({ where: { id }, data: { isSold: true, status: 'SOLD' } });
    return { status: 'success', data: updated };
  }
}
