import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';

class LoginDto {
  phone: string;
  otp: string;
}

@ApiTags('auth')
@Controller('api/v1/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login/phone')
  @ApiOperation({ summary: 'Login with phone and OTP' })
  @ApiResponse({ status: 200, description: 'Return access and refresh tokens.' })
  login(@Body() loginDto: LoginDto) {
    return this.authService.loginWithPhone(loginDto.phone, loginDto.otp);
  }
}
