import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { AuthService } from './auth.service';
import { ApiTags, ApiOperation, ApiBody } from '@nestjs/swagger';
import { IsString, IsNotEmpty, Length } from 'class-validator';

class SendOtpDto {
  @IsString() @IsNotEmpty()
  phone: string;
}

class VerifyOtpDto {
  @IsString() @IsNotEmpty()
  phone: string;
  @IsString() @Length(6, 6)
  otp: string;
}

@ApiTags('auth')
@Controller('api/v1/auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('send-otp')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Send OTP to phone number' })
  sendOtp(@Body() dto: SendOtpDto) {
    return this.authService.sendOtp(dto.phone);
  }

  @Post('login/phone')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ summary: 'Login with phone and OTP' })
  login(@Body() dto: VerifyOtpDto) {
    return this.authService.loginWithPhone(dto.phone, dto.otp);
  }
}
