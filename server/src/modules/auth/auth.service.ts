import { Injectable, UnauthorizedException } from '@nestjs/common';

@Injectable()
export class AuthService {
  loginWithPhone(phone: string, otp: string) {
    // Mock implementation for Phase 1
    if (otp === '123456') {
      return {
        status: 'success',
        data: {
          user: {
            id: 'mock-user-uuid',
            phone: phone,
            role: 'buyer',
            isProfileComplete: true,
          },
          accessToken: 'mock-access-token',
          refreshToken: 'mock-refresh-token',
        }
      };
    }
    throw new UnauthorizedException('Invalid OTP');
  }
}
