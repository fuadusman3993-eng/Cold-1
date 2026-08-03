import { Controller, Get, Post, Patch, Delete, Body, Param, Query, UseGuards, Request, Optional } from '@nestjs/common';
import { ApiTags, ApiBearerAuth, ApiOperation, ApiQuery } from '@nestjs/swagger';
import { ListingsService } from './listings.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@ApiTags('Listings')
@Controller('listings')
export class ListingsController {
  constructor(private listingsService: ListingsService) {}

  @Get()
  @ApiOperation({ summary: 'Get all listings with filters' })
  getAll(@Query() query: any, @Request() req: any) {
    return this.listingsService.getAll(query);
  }

  @Get('featured')
  @ApiOperation({ summary: 'Get featured listings' })
  getFeatured() {
    return this.listingsService.getFeatured();
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get one listing by ID' })
  getOne(@Param('id') id: string, @Request() req: any) {
    const userId = req.user?.sub;
    return this.listingsService.getOne(id, userId);
  }

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Create a new listing' })
  create(@Request() req: any, @Body() dto: any) {
    return this.listingsService.create(req.user.sub, dto);
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Update a listing' })
  update(@Param('id') id: string, @Request() req: any, @Body() dto: any) {
    return this.listingsService.update(id, req.user.sub, dto);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Delete a listing' })
  remove(@Param('id') id: string, @Request() req: any) {
    return this.listingsService.remove(id, req.user.sub, req.user.role);
  }

  @Patch(':id/sold')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: 'Mark listing as sold' })
  markSold(@Param('id') id: string, @Request() req: any) {
    return this.listingsService.markSold(id, req.user.sub);
  }
}
