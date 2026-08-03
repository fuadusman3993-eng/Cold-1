import { Injectable, UnauthorizedException, ConflictException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AuthService {
  // In-memory OTP store (replace with Redis in production)
  private readonly otpStore = new Map<string, { otp: string; expiresAt: Date }>();

  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService,
  ) {}

  async sendOtp(phone: string): Promise<{ message: string }> {
    // Generate 6-digit OTP
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000); // 5 minutes
    this.otpStore.set(phone, { otp, expiresAt });

    // TODO: integrate with real SMS provider (e.g. Twilio, AfricasTalking)
    console.log(`OTP for ${phone}: ${otp}`); // Log for development

    return { message: `OTP sent to ${phone}` };
  }

  async verifyOtp(phone: string, otp: string) {
    const record = this.otpStore.get(phone);

    // For development, accept 123456 as universal OTP
    const isDevOtp = otp === '123456';
    const isValidOtp = record && record.otp === otp && record.expiresAt > new Date();

    if (!isDevOtp && !isValidOtp) {
      throw new UnauthorizedException('Invalid or expired OTP');
    }

    this.otpStore.delete(phone);

    // Find or create user
    let user = await this.prisma.user.findUnique({ where: { phone } });
    if (!user) {
      user = await this.prisma.user.create({
        data: { phone, role: 'BUYER' },
      });
    }

    return this._generateTokens(user);
  }

  async loginWithEmail(email: string, password: string) {
    const user = await this.prisma.user.findUnique({ where: { email } });
    if (!user) throw new UnauthorizedException('Invalid credentials');
    // Password check would go here if we store hashed passwords
    return this._generateTokens(user);
  }

  async refreshToken(userId: string) {
    const user = await this.prisma.user.findUnique({ where: { id: userId } });
    if (!user) throw new UnauthorizedException('User not found');
    return this._generateTokens(user);
  }

  async getMe(userId: string) {
    return this.prisma.user.findUnique({
      where: { id: userId },
      include: { dealerProfile: true },
    });
  }

  private _generateTokens(user: any) {
    const payload = { sub: user.id, phone: user.phone, role: user.role };
    return {
      status: 'success',
      data: {
        user: {
          id: user.id,
          phone: user.phone,
          email: user.email,
          fullName: user.fullName,
          avatarUrl: user.avatarUrl,
          role: user.role,
          isProfileComplete: user.isProfileComplete,
          city: user.city,
        },
        accessToken: this.jwtService.sign(payload),
        refreshToken: this.jwtService.sign(payload, { expiresIn: '30d' }),
      },
    };
  }
}
