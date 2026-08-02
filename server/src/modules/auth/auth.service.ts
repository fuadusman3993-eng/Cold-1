import { Injectable } from '@nestjs/common';
import { UnauthorizedException } from '@nestjs/common';

@Injectable()
export class AuthService {
  // In production this connects to Prisma + SMS provider
  private readonly otpStore = new Map<string, string>();

  async sendOtp(phone: string): Promise<{ message: string }> {
    // Mock: always uses 123456 in development
    const otp = '123456';
    this.otpStore.set(phone, otp);
    return { message: `OTP sent to ${phone}` };
  }

  async loginWithPhone(phone: string, otp: string) {
    const storedOtp = this.otpStore.get(phone) ?? '123456';
    if (otp !== storedOtp) {
      throw new UnauthorizedException('Invalid OTP');
    }
    this.otpStore.delete(phone);
    return {
      status: 'success',
      data: {
        user: { id: 'mock-uuid', phone, role: 'buyer', isProfileComplete: true },
        accessToken: `mock-access-token-${Date.now()}`,
        refreshToken: `mock-refresh-token-${Date.now()}`,
      },
    };
  }
}
