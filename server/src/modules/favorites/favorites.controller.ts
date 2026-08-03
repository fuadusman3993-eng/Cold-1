import { Controller, Get, Post, Delete, Param, UseGuards, Request } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation } from '@nestjs/swagger';
import { FavoritesService } from './favorites.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Favorites')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('favorites')
export class FavoritesController {
  constructor(private favoritesService: FavoritesService) {}

  @Get()
  @ApiOperation({ summary: 'Get my favorite listings' })
  getMyFavorites(@Request() req: any) {
    return this.favoritesService.getMyFavorites(req.user.sub);
  }

  @Post(':listingId')
  @ApiOperation({ summary: 'Toggle favorite on a listing' })
  toggleFavorite(@Request() req: any, @Param('listingId') listingId: string) {
    return this.favoritesService.toggleFavorite(req.user.sub, listingId);
  }

  @Get(':listingId/check')
  @ApiOperation({ summary: 'Check if a listing is favorited' })
  checkFavorite(@Request() req: any, @Param('listingId') listingId: string) {
    return this.favoritesService.checkFavorite(req.user.sub, listingId);
  }
}
