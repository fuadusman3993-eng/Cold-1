# 🚗 EthioDrive — Premium Ethiopian Car Marketplace

<div align="center">

**The Most Trusted and Premium Digital Automotive Marketplace in Ethiopia**

*Connecting buyers, sellers, and dealers through a secure, AI-powered, and luxurious digital experience.*

![Version](https://img.shields.io/badge/version-1.0.0-gold)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-blue)
![License](https://img.shields.io/badge/license-Proprietary-red)

</div>

---

## Table of Contents

1.  [Project Vision](#1-project-vision)
2.  [Supported Platforms](#2-supported-platforms)
3.  [UI/UX Design System](#3-uiux-design-system)
4.  [Complete Feature Specification](#4-complete-feature-specification)
5.  [Technical Architecture (Flutter)](#5-technical-architecture-flutter)
6.  [Backend Architecture](#6-backend-architecture)
7.  [Database Design](#7-database-design)
8.  [Firebase Integration](#8-firebase-integration)
9.  [Security](#9-security)
10. [AI Features](#10-ai-features)
11. [Revenue Model](#11-revenue-model)
12. [Admin Dashboard](#12-admin-dashboard)
13. [API Documentation](#13-api-documentation)
14. [Scalability](#14-scalability)
15. [Deployment & Infrastructure](#15-deployment--infrastructure)
16. [Release Management](#16-release-management)
17. [Development Roadmap](#17-development-roadmap)
18. [Coding Standards](#18-coding-standards)

---

## 1. Project Vision

### 1.1. Vision

To become **the** definitive, most trusted, and most technologically advanced digital automotive marketplace in Ethiopia and the broader East African region. EthioDrive aspires to fundamentally transform how vehicles are discovered, evaluated, transacted, and owned—replacing informal, trust-deficient processes with a transparent, AI-powered, and verified digital ecosystem.

### 1.2. Mission

To empower every Ethiopian buyer, seller, and dealer with a secure, transparent, and beautifully crafted digital platform that eliminates information asymmetry, prevents fraud, and makes every vehicle transaction fair, efficient, and delightful. We achieve this through rigorous vehicle verification, AI-driven market intelligence, encrypted communication channels, and a world-class user experience.

### 1.3. Goals

| # | Goal | Key Results |
|---|------|-------------|
| 1 | Eliminate fraud and scams | < 0.1% fraudulent listing rate after moderation; 100% of dealer accounts KYC-verified |
| 2 | Streamline vehicle transactions | Average time-to-sale reduced by 40% vs. traditional channels |
| 3 | Provide AI-powered valuations | Price estimation accuracy within ±8% of actual sale price |
| 4 | Deliver premium UX across all devices | ≥ 4.7 star average rating on App Store and Play Store |
| 5 | Become the market leader | 500,000+ monthly active users within 18 months of launch |
| 6 | Generate sustainable revenue | Positive unit economics by Month 12 |

### 1.4. Problem Statement

The Ethiopian automotive market faces several critical, systemic challenges:

1. **Fraud & Scams**: The absence of a verified, centralized platform means buyers frequently encounter fake listings, misrepresented vehicle conditions, odometer rollbacks, and title washing. There is no reliable way to vet sellers before committing to a transaction.
2. **Information Asymmetry**: Sellers hold significantly more information about a vehicle's true condition and history than buyers. No standardized inspection or history reporting mechanism exists.
3. **Fragmented Discovery**: Vehicles are listed across Telegram groups, Facebook Marketplace, roadside displays, and word-of-mouth networks. Buyers must manually search across dozens of disconnected channels with no way to filter, compare, or save searches.
4. **Inconsistent Pricing**: Without transparent market data, both buyers and sellers operate with inaccurate price expectations, leading to protracted negotiations and unfair outcomes.
5. **Lack of Dealer Accountability**: No rating, review, or verification system exists for dealers, making it impossible for buyers to distinguish reputable businesses from unscrupulous operators.
6. **Inefficient Processes**: Document preparation, vehicle inspection scheduling, financing applications, and ownership transfers are entirely manual, paper-based processes.

### 1.5. Market Opportunity

Ethiopia presents a uniquely compelling market opportunity for a digital automotive platform:

- **Population**: 130 million+ with a median age of ~19, representing a massive future consumer base.
- **Smartphone Penetration**: Growing rapidly, with an estimated 40 million smartphone users projected by 2027.
- **Internet Access**: Ethio Telecom's 4G/5G expansion and the entry of Safaricom Ethiopia are dramatically increasing connectivity.
- **Vehicle Demand**: Consistently high demand for both new and used vehicles, with approximately 60,000–80,000 vehicles imported annually, in addition to the active domestic resale market.
- **Digital Adoption**: Rapid adoption of digital payment systems (CBE Birr, telebirr, Amole) signals readiness for digital commerce.
- **Competitive Landscape**: No dominant, well-funded, technology-first platform currently owns this market vertical.
- **Regulatory Tailwinds**: Government initiatives promoting digital transformation and e-commerce create a favorable regulatory environment.

### 1.6. Business Model

EthioDrive operates as a **multi-sided marketplace platform** with diversified revenue streams:

```mermaid
graph LR
    A[Buyers] -->|Browse & Purchase| P[EthioDrive Platform]
    B[Individual Sellers] -->|List Vehicles| P
    C[Dealers] -->|Subscriptions & Inventory| P
    P -->|Featured Listings Revenue| R[Revenue]
    P -->|Subscription Revenue| R
    P -->|Ad Revenue| R
    P -->|Inspection Commissions| R
    P -->|Financing Lead Fees| R
    P -->|Data & Insights Revenue| R
```

**Revenue Streams (detailed in Section 11)**:
1. Featured/Promoted Listings (pay-per-day, pay-per-click)
2. Dealer Subscription Tiers (monthly/annual SaaS)
3. In-app Advertising (native ad placements for automotive services and accessories)
4. Inspection Partnerships (commission on booked inspections)
5. Financing Partnerships (lead generation fees from banks and MFIs)
6. Premium Data & Market Insights (dealer analytics packages)

---

## 2. Supported Platforms

EthioDrive is built as a single Flutter codebase that compiles to **all major platforms**, ensuring maximum reach and a consistent brand experience.

### 📱 Mobile Apps

| Platform | Distribution | Minimum OS | Target |
|----------|-------------|------------|--------|
| **Android** | Google Play Store, direct APK download | Android 6.0 (API 23) | Android 14 (API 34) |
| **iOS** | Apple App Store | iOS 14.0 | iOS 17 |

- Optimized for phones with screen sizes ranging from 4.7" to 6.9".
- Support for notched, hole-punch, and Dynamic Island displays.
- Deep link support for sharing vehicle listings via URLs.

### 💻 Desktop Apps

| Platform | Distribution | Minimum OS |
|----------|-------------|------------|
| **Windows** | Microsoft Store, direct `.msix` installer | Windows 10 (1903+) |
| **macOS** | Mac App Store, direct `.dmg` download | macOS 11.0 (Big Sur) |
| **Linux** | Snap Store, `.deb`, `.AppImage` packages | Ubuntu 20.04 / Fedora 35+ |

- Native window management (resizing, minimize, maximize, full-screen).
- Keyboard shortcuts for power users (e.g., `Ctrl+F` for search, `Ctrl+K` for command palette).
- Multi-monitor support.
- System tray integration for notification badges.

### 🌐 Web Version

| Feature | Details |
|---------|---------|
| **Responsive Design** | Fluid layouts adapting from 320px mobile to 2560px ultrawide |
| **PWA** | Installable Progressive Web App with offline browsing of cached listings |
| **SEO** | Server-side rendering (SSR) or pre-rendering for search engine indexing of public listings |
| **Browser Support** | Chrome 90+, Firefox 88+, Safari 14+, Edge 90+ |

- Service Worker for caching static assets and previously viewed listings.
- Web push notification support via Firebase Cloud Messaging.
- URL-based deep links for every listing, dealer page, and search query.
- Open Graph and Twitter Card meta tags for rich social media link previews.

### 📟 Tablet Version

| Platform | Screen Sizes | Orientations |
|----------|-------------|-------------|
| **Android Tablets** | 7"–13" displays | Portrait & Landscape |
| **iPad** | iPad Mini, iPad Air, iPad Pro (all sizes) | Portrait & Landscape |

- Adaptive layouts using Flutter's `LayoutBuilder` and `MediaQuery`:
  - **Portrait**: Single-column layout similar to phone but with larger cards and more generous spacing.
  - **Landscape**: Master-detail (split-view) layout—listing grid on the left, detail panel on the right.
- Stylus/Apple Pencil support for annotation features in inspection workflows.
- Multi-window/Split-screen support on iPadOS and Android 12+.

### 🖥 Admin Dashboard

| Feature | Details |
|---------|---------|
| **Primary Target** | Desktop browsers (Chrome, Firefox, Edge, Safari) at 1280px+ |
| **Secondary Target** | Tablet browsers (landscape mode, 1024px+) |
| **Technology** | Flutter Web or dedicated React/Next.js application |

- Optimized for productivity: dense information layouts, keyboard navigation, bulk action support.
- Responsive grid that collapses gracefully from 3-column to 2-column to single-column layouts.
- Role-based view rendering—Super Admin, Moderator, Support Agent, and Analyst each see only their relevant tools.

---

## 3. UI/UX Design System

### 3.1. Premium Luxury Design Language

EthioDrive's visual identity communicates **trust, prestige, and sophistication**. Every pixel is intentional. The design must make the user feel they are interacting with a world-class product—comparable to premium automotive brands' own digital experiences (e.g., Mercedes-Benz, BMW configurators).

**Design Principles**:
1. **Obsidian Elegance** — Dark surfaces reduce visual noise and let vehicle imagery take center stage.
2. **Golden Confidence** — Gold accents signal premium quality and guide user attention to key actions.
3. **Effortless Flow** — Every interaction feels smooth, fast, and intuitive. Zero cognitive friction.
4. **Photographic Priority** — Vehicle images are the hero content. The UI serves as a frame for automotive photography.
5. **Consistent Luxury** — Every screen, every component, every micro-interaction must maintain the same level of polish.

### 3.2. Obsidian Dark Theme

The primary application theme is a deeply layered dark palette that creates visual depth and hierarchy.

| Token | Hex Value | Usage |
|-------|-----------|-------|
| `--color-bg-primary` | `#0B0C10` | Main app background, full-screen surfaces |
| `--color-bg-secondary` | `#121418` | Card backgrounds, bottom sheets, dialogs |
| `--color-bg-tertiary` | `#1A1D23` | Elevated surfaces, navigation bars, input fields |
| `--color-bg-quaternary` | `#22262E` | Hover states, selected items, dividers |
| `--color-surface-overlay` | `rgba(255,255,255,0.04)` | Glassmorphism overlays, frosted panels |
| `--color-text-primary` | `#F5F5F7` | Headings, primary body text |
| `--color-text-secondary` | `#A0A4AD` | Subtitles, metadata, timestamps |
| `--color-text-tertiary` | `#6B7080` | Placeholders, disabled text, hints |
| `--color-text-inverse` | `#0B0C10` | Text on gold/light backgrounds |
| `--color-border-subtle` | `rgba(255,255,255,0.08)` | Card borders, dividers, separators |
| `--color-border-active` | `rgba(212,175,55,0.5)` | Focused input borders, active tab indicators |

### 3.3. Gold Accent System

Gold is the signature accent color, used sparingly to denote primary actions, premium features, and critical call-to-action elements.

| Token | Hex Value | Usage |
|-------|-----------|-------|
| `--color-gold-primary` | `#D4AF37` | Primary CTA buttons, active navigation icons, price highlights |
| `--color-gold-light` | `#E8D48B` | Hover states on gold elements, secondary highlights |
| `--color-gold-dark` | `#B8960C` | Pressed/active states on gold elements |
| `--color-gold-gradient-start` | `#D4AF37` | Start of linear gradient for premium banners |
| `--color-gold-gradient-end` | `#F0D060` | End of linear gradient for premium banners |
| `--color-gold-shimmer` | `rgba(212,175,55,0.15)` | Subtle shimmer effect on featured listing cards |

**Supplementary Status Colors**:

| Token | Hex Value | Usage |
|-------|-----------|-------|
| `--color-success` | `#34D399` | Verified badges, successful actions, available status |
| `--color-warning` | `#FBBF24` | Pending states, caution notices |
| `--color-error` | `#F87171` | Error messages, rejection badges, destructive actions |
| `--color-info` | `#60A5FA` | Informational tooltips, link text |

### 3.4. Typography

Typography uses the **Inter** font family (Google Fonts) for its exceptional readability across all screen sizes, extensive weight range, and professional character.

| Style Name | Font | Weight | Size | Line Height | Letter Spacing | Usage |
|-----------|------|--------|------|-------------|----------------|-------|
| `display-large` | Inter | 700 (Bold) | 36px | 44px | -0.5px | Hero headings, splash screens |
| `display-medium` | Inter | 700 (Bold) | 28px | 36px | -0.3px | Section headings |
| `display-small` | Inter | 600 (SemiBold) | 24px | 32px | -0.2px | Card titles, dialog headers |
| `headline` | Inter | 600 (SemiBold) | 20px | 28px | 0px | Sub-section headings |
| `title-large` | Inter | 600 (SemiBold) | 18px | 26px | 0px | List item titles, navigation labels |
| `title-medium` | Inter | 500 (Medium) | 16px | 24px | 0.1px | Card subtitles, button labels |
| `body-large` | Inter | 400 (Regular) | 16px | 24px | 0.2px | Primary body text, descriptions |
| `body-medium` | Inter | 400 (Regular) | 14px | 20px | 0.2px | Secondary body text, metadata |
| `body-small` | Inter | 400 (Regular) | 12px | 16px | 0.3px | Captions, timestamps, fine print |
| `label` | Inter | 500 (Medium) | 12px | 16px | 0.5px | Badges, tags, chip labels (UPPERCASE) |
| `price` | Inter | 700 (Bold) | 22px | 28px | 0px | Vehicle price display |
| `price-small` | Inter | 600 (SemiBold) | 16px | 22px | 0px | Price in list/grid view |

**Amharic Typography**: For Amharic language support, use **Noto Sans Ethiopic** as the fallback font family, ensuring proper rendering of Ge'ez script characters. All font sizes and line heights remain the same; letter spacing should be set to `0` for Ethiopic script.

### 3.5. Spacing System

An **8-point grid system** ensures consistent, harmonious spacing throughout the application.

| Token | Value | Usage |
|-------|-------|-------|
| `--space-0` | 0px | No spacing |
| `--space-1` | 4px | Tight internal padding (icon-to-label gap) |
| `--space-2` | 8px | Compact padding, small gaps between inline elements |
| `--space-3` | 12px | Standard padding inside chips, badges, small cards |
| `--space-4` | 16px | Default content padding, gap between stacked elements |
| `--space-5` | 20px | Medium section spacing |
| `--space-6` | 24px | Card internal padding, form field spacing |
| `--space-8` | 32px | Section gaps, large content padding |
| `--space-10` | 40px | Major section separators |
| `--space-12` | 48px | Page-level top/bottom padding |
| `--space-16` | 64px | Hero section padding, large visual breaks |
| `--space-20` | 80px | Full-bleed section padding on desktop |

**Border Radius Scale**:

| Token | Value | Usage |
|-------|-------|-------|
| `--radius-xs` | 4px | Chips, small badges |
| `--radius-sm` | 8px | Input fields, small cards |
| `--radius-md` | 12px | Standard cards, dialogs |
| `--radius-lg` | 16px | Large cards, bottom sheets |
| `--radius-xl` | 24px | Pill buttons, search bars |
| `--radius-full` | 9999px | Circular avatars, round icon buttons |

### 3.6. Iconography

- **Icon Library**: Custom icon set based on Lucide Icons (open-source, consistent stroke width).
- **Style**: 1.5px stroke weight, rounded line caps and joins.
- **Sizes**: 16px (inline), 20px (standard), 24px (navigation), 32px (feature icons), 48px (empty state illustrations).
- **Colors**: Icons inherit text color by default. Active/selected navigation icons use `--color-gold-primary`.
- **Custom Icons Required**:
  - Vehicle body type silhouettes (Sedan, SUV, Hatchback, Pickup, Van, Bus, Truck)
  - Fuel type icons (Petrol, Diesel, Hybrid, Electric)
  - Transmission icons (Automatic, Manual, CVT)
  - Verification badge (Shield with checkmark, gold-filled)
  - EthioDrive logo mark (stylized steering wheel with Ethiopian flag colors subtly embedded)

### 3.7. Components

#### 3.7.1. Buttons

| Variant | Background | Text Color | Border | Height | Border Radius | Usage |
|---------|-----------|------------|--------|--------|---------------|-------|
| **Primary** | Linear gradient `gold-primary → gold-gradient-end` | `text-inverse` | None | 48px | `radius-xl` | Main CTAs: "Post Listing", "Send Offer", "Contact Seller" |
| **Secondary** | Transparent | `gold-primary` | 1px solid `gold-primary` | 48px | `radius-xl` | Secondary actions: "Save", "Compare", "Share" |
| **Tertiary** | `bg-tertiary` | `text-primary` | None | 40px | `radius-lg` | Filters, sort options, minor actions |
| **Destructive** | Transparent | `color-error` | 1px solid `color-error` | 48px | `radius-xl` | "Delete Listing", "Block User", "Report" |
| **Ghost** | Transparent | `text-secondary` | None | 40px | `radius-lg` | Inline text actions, "See More", "Skip" |
| **Icon Button** | `bg-tertiary` | `text-primary` | None | 40px × 40px | `radius-full` | Favorite heart, share, menu dots |
| **FAB** | Gradient gold | `text-inverse` | None | 56px × 56px | `radius-full` | "Post New Listing" floating action |

**Button States**: Every button has five visual states—Default, Hover (cursor pointer, slight brightness increase), Focused (gold border ring), Pressed (scale to 0.97, darker shade), Disabled (40% opacity, no pointer events).

**Loading State**: When a button triggers an async action, the label text is replaced with a centered `CircularProgressIndicator` (16px, gold color) and the button is disabled until the operation completes.

#### 3.7.2. Cards

**Vehicle Listing Card** (the most important component in the entire app):

```
┌─────────────────────────────────────┐
│  [Vehicle Image - 16:10 aspect]     │
│  ┌─────┐                   ┌─────┐  │
│  │ NEW │                   │ ♥   │  │
│  └─────┘                   └─────┘  │
│  ┌──────────┐  ┌──────────────────┐ │
│  │ VERIFIED │  │ 📍 Addis Ababa  │ │
│  └──────────┘  └──────────────────┘ │
├─────────────────────────────────────┤
│  2022 Toyota Corolla                │
│  ★★★★☆ 4.2 · 15 reviews            │
│                                     │
│  ETB 3,500,000                      │
│  45,000 km · Automatic · Petrol     │
│                                     │
│  [Contact]  [Compare]  [Save]       │
└─────────────────────────────────────┘
```

- **Image Section**: 16:10 aspect ratio, lazy-loaded with a shimmer placeholder. Swipeable carousel if multiple images exist. Overlay badges for "NEW", "FEATURED", "PRICE DROP". Heart icon (favorite toggle) in top-right corner.
- **Info Section**: Vehicle title (Year + Make + Model), star rating, price in bold gold text, key specs (mileage, transmission, fuel type) as inline chips, location tag.
- **Action Bar**: Up to three action buttons at the bottom: primary CTA ("Contact Seller"), and secondary actions ("Compare", "Save/Favorite").
- **Card Behavior**: On tap, navigates to full Vehicle Detail Screen with a Hero animation on the vehicle image. On long-press (mobile), shows a quick-action context menu (Save, Share, Report).

**Dealer Card**:
- Dealer logo/avatar, business name, verification badge, location, total listings count, average rating, "View Showroom" button.

**Chat Message Card**:
- Sender avatar, message bubble (left-aligned for received, right-aligned for sent), timestamp, read receipt indicators (single check = sent, double check = delivered, blue double check = read).

**Offer Card**:
- Buyer/seller avatar, vehicle thumbnail, offered amount vs. listed price, offer status (Pending / Accepted / Rejected / Countered / Expired), action buttons (Accept, Reject, Counter).

#### 3.7.3. Navigation

**Bottom Navigation Bar (Mobile)**:

A floating bottom navigation bar with 5 tabs, elevated above the screen content with a subtle shadow and blur backdrop.

| Tab | Icon | Label | Destination |
|-----|------|-------|-------------|
| 1 | 🏠 Home | Home | Home feed with featured & recent listings |
| 2 | 🔍 Search | Search | Full search experience with filters |
| 3 | ➕ Post | Sell | New listing creation wizard |
| 4 | 💬 Chat | Chat | All conversations |
| 5 | 👤 Profile | Profile | User profile & settings |

- The center "Post" tab has a larger, elevated gold circular button to draw attention to listing creation.
- Active tab: Gold icon color + gold dot indicator below the icon.
- Inactive tabs: `text-tertiary` color.
- Badge indicators: Red dot with count for unread messages on Chat tab, notification count on Home tab.

**Side Navigation (Desktop/Tablet Landscape)**:

A persistent left sidebar navigation replacing the bottom bar on larger screens.

- Collapsible: Full labels visible by default; can collapse to icon-only mode.
- Sections: Home, Search, My Listings, Messages, Favorites, Notifications, Profile, Settings.
- Dealers see additional sections: Inventory, Leads, Analytics, Subscription.
- Admins see the full Admin Dashboard navigation.

**App Bar (Top)**:

| Element | Position | Description |
|---------|----------|-------------|
| Back Arrow / Hamburger | Left | Context-dependent: back navigation on detail pages, menu on home |
| Page Title / Logo | Center | EthioDrive wordmark on home; page title on sub-pages |
| Search Icon | Right | Opens search overlay / navigates to search |
| Notification Bell | Right | Badge count indicator, opens notification panel |
| User Avatar | Right | Opens profile dropdown/bottom sheet |

#### 3.7.4. Search Experience

**Home Screen Search Bar**: A prominent, pill-shaped search bar at the top of the home screen with placeholder text: *"Search make, model, or keyword..."*. On focus, it expands to full-screen search mode.

**Full Search Screen**:
1. **Text Input**: Auto-complete suggestions as the user types (makes, models, common queries).
2. **AI Search Toggle**: A toggle to switch between standard keyword search and AI natural language search (e.g., "Family SUV under 4 million birr with less than 50k km").
3. **Filter Panel**: Slide-up bottom sheet (mobile) or persistent sidebar (desktop) with the following filters:

| Filter | Type | Options |
|--------|------|---------|
| Make | Multi-select dropdown | Toyota, Honda, Hyundai, Suzuki, Nissan, Mitsubishi, Ford, etc. |
| Model | Dependent multi-select | Populated based on selected make(s) |
| Year Range | Range slider | 1990–current year |
| Price Range | Range slider + manual input | ETB 100,000 – ETB 50,000,000 |
| Mileage Range | Range slider | 0 – 500,000 km |
| Body Type | Icon chips | Sedan, SUV, Hatchback, Pickup, Van, Bus, Truck, Coupe, Wagon |
| Fuel Type | Chips | Petrol, Diesel, Hybrid, Electric |
| Transmission | Chips | Automatic, Manual, CVT |
| Color | Color swatches | White, Black, Silver, Red, Blue, Green, Grey, Gold, Other |
| Condition | Chips | New, Used (Excellent), Used (Good), Used (Fair), Salvage |
| Location | City/sub-city dropdown | Addis Ababa (with sub-cities), Regional cities |
| Distance | Radius slider | 5km – 200km from current location |
| Features | Multi-select checkboxes | Sunroof, Leather Seats, Navigation, Backup Camera, Bluetooth, etc. |
| Seller Type | Chips | Individual, Dealer |
| Verified Only | Toggle switch | Show only verified listings |

4. **Sort Options**: Price (Low→High, High→Low), Date Posted (Newest, Oldest), Mileage (Low→High), Relevance (default for AI search).
5. **Search Results**: Grid view (2 columns mobile, 3–4 columns desktop) or List view (toggle). Infinite scroll pagination. Result count displayed at top.
6. **Saved Searches**: Users can save any search configuration with a custom name and receive push notifications when new matching listings appear.

### 3.8. Animations & Transitions

All animations must run at **60fps** and use Flutter's built-in animation framework or the `animations` package.

| Animation | Type | Duration | Curve | Description |
|-----------|------|----------|-------|-------------|
| Page transitions | Shared axis (horizontal) | 300ms | `easeInOutCubic` | Standard forward/backward navigation |
| Hero image | Hero animation | 350ms | `easeInOutCubic` | Vehicle image from card to detail page |
| Bottom sheet | Slide up + fade | 250ms | `easeOutCubic` | Filter panels, action menus |
| Card appearance | Fade in + slide up | 200ms | `easeOut` | Staggered entry (50ms delay between cards) |
| Button press | Scale (0.97) | 100ms | `easeInOut` | Tactile press feedback |
| Favorite toggle | Scale bounce (1.0 → 1.3 → 1.0) | 300ms | `elasticOut` | Heart icon animation with particle burst |
| Loading skeleton | Shimmer gradient sweep | 1500ms (loop) | `linear` | Placeholder while content loads |
| Pull to refresh | Custom spring | 400ms | `spring` | Elastic rubber band effect |
| Tab switch | Cross-fade | 200ms | `easeInOut` | Content swap between bottom nav tabs |
| Snackbar | Slide in from bottom | 250ms | `easeOutCubic` | Notification toast, auto-dismiss after 4s |
| Image gallery | Swipe + parallax | Gesture-driven | `linear` | Parallax depth effect on gallery swipe |
| Price counter | Animated count up | 600ms | `easeOutCubic` | Price animates from 0 to actual value on load |
| Verification badge | Pulse glow | 2000ms (loop) | `easeInOut` | Subtle gold pulse on verified badges |

### 3.9. Accessibility

EthioDrive must meet **WCAG 2.1 AA** compliance:

- **Contrast Ratios**: All text meets minimum 4.5:1 contrast ratio against its background. Large text (18px+) meets 3:1.
- **Semantic Labels**: Every interactive element has a `Semantics` widget with a descriptive label for screen readers (TalkBack on Android, VoiceOver on iOS).
- **Touch Targets**: All tappable elements have a minimum touch target of 48×48 dp.
- **Font Scaling**: The UI gracefully handles system font scaling up to 200% without content overflow or truncation.
- **Color Independence**: Information is never conveyed by color alone (e.g., error states use both red color AND an error icon AND descriptive text).
- **Focus Management**: Logical tab order, visible focus indicators (gold ring), and proper focus restoration after dialog dismissal.
- **Reduced Motion**: Respect the `MediaQuery.disableAnimations` flag and provide static alternatives when the system's "Reduce Motion" setting is enabled.
- **Language**: Full Amharic (አማርኛ) localization alongside English. Right-to-left text direction is not needed for Amharic but proper Ge'ez script rendering is essential.

### 3.10. Responsive Design Breakpoints

| Breakpoint Name | Width Range | Layout Strategy | Columns |
|----------------|-------------|-----------------|---------|
| `compact` | 0 – 599px | Single column, bottom nav | 1 |
| `medium` | 600 – 839px | Adjusted single column, bottom nav | 2 |
| `expanded` | 840 – 1199px | Two-pane master-detail, side nav | 2–3 |
| `large` | 1200 – 1599px | Multi-pane, persistent side nav | 3–4 |
| `extra-large` | 1600px+ | Full desktop, max-width container (1440px) | 4–6 |

- Use Flutter's `LayoutBuilder` and `MediaQuery` for responsive breakpoints.
- Vehicle listing grids dynamically adjust column count based on available width.
- On `compact` and `medium`: bottom navigation bar + full-screen pages.
- On `expanded` and above: side navigation rail/drawer + master-detail layouts.

---

## 4. Complete Feature Specification

### 4.1. Authentication

#### 4.1.1. Registration Methods

| Method | Flow | Details |
|--------|------|---------|
| **Phone (OTP)** | User enters Ethiopian phone number → receives 6-digit OTP via SMS → enters OTP → creates profile | Primary method. Supports Ethio Telecom (+251 9xx) and Safaricom formats. OTP expires after 5 minutes. Max 3 resend attempts per session. |
| **Email/Password** | User enters email + creates password → receives verification email → clicks verification link → account activated | Password requirements: min 8 chars, 1 uppercase, 1 lowercase, 1 digit, 1 special character. |
| **Google OAuth** | Tap "Continue with Google" → Google OAuth consent screen → redirect back with token → auto-create account if new | Uses Firebase Auth Google provider. |
| **Apple Sign-In** | Tap "Continue with Apple" → Apple auth dialog → redirect back → auto-create account if new | Required for iOS App Store compliance. Handles Apple's email relay service. |

#### 4.1.2. Login Methods

- Phone + OTP
- Email + Password
- Google OAuth
- Apple Sign-In
- Biometric (fingerprint / Face ID) — enabled after first successful login; unlocks a locally stored encrypted refresh token.

#### 4.1.3. Profile Completion

After first registration, users are guided through a profile completion flow:

1. **Full Name** (required)
2. **Profile Photo** (optional, can upload or take photo)
3. **City / Sub-city** (dropdown selection, required)
4. **User Type Selection** (Buyer, Seller, Dealer — determines available features)
5. **Language Preference** (English or Amharic)

#### 4.1.4. Account Recovery

- **Forgot Password**: Email-based password reset with a time-limited (1 hour) reset link.
- **Phone Number Change**: Requires OTP verification on both old and new numbers.
- **Account Deletion**: Self-service deletion with 30-day grace period before permanent erasure (GDPR-inspired compliance).

### 4.2. Buyer Features

| Feature | Description | Details |
|---------|-------------|---------|
| **Browse Listings** | Discover vehicles through curated feeds, search, and categories | Home screen shows: Featured Listings (promoted), Recently Added, Nearby Listings (GPS-based), Popular Makes, Price Drops |
| **Advanced Search** | Find specific vehicles with powerful filters | See Section 3.7.4 for complete filter specification |
| **Saved Searches** | Save search criteria for future use | Stored server-side. Users receive push notifications when new listings match saved search criteria. Max 20 saved searches per user. |
| **Favorites / Wishlist** | Save individual listings for later | Heart icon toggle on any listing card or detail page. Favorites are synced across all devices. Organized into custom collections (e.g., "Toyota Options", "Under 3M"). |
| **Vehicle Comparison** | Compare up to 4 vehicles side-by-side | Comparison table showing: Price, Year, Mileage, Engine, Transmission, Fuel Type, Body Type, Color, Features, Seller Rating, Verification Status. Highlight differences in green/red. |
| **Price Alerts** | Get notified when a listing's price drops | Users can set a "Target Price" on any listing. Push notification sent if seller reduces price to or below that threshold. |
| **Contact Seller** | Initiate communication | Opens in-app chat thread. Phone number revealed only after initial chat exchange (anti-spam measure). |
| **Make an Offer** | Submit a formal purchase offer | Structured offer form: Offered Amount, Message to Seller, Validity Period (24h/48h/72h). Offer statuses: Pending, Accepted, Rejected, Countered, Expired, Withdrawn. |
| **Schedule Test Drive** | Request to view/drive the vehicle | Calendar-based scheduling with proposed date/time. Seller confirms or suggests alternatives. Location can be seller's location or a neutral meeting point. |
| **Financing Calculator** | Estimate monthly payments | Inputs: vehicle price, down payment percentage, loan term (months), interest rate. Outputs: monthly payment, total interest, total cost. Pre-configured with typical Ethiopian bank rates. |
| **Vehicle History Request** | Request verified history of a vehicle | Triggers a data lookup against available records (accident history, service records, ownership count). Results displayed as a structured report. |
| **Report Listing** | Flag suspicious or fraudulent listings | Report reasons: Fake listing, Wrong information, Stolen vehicle, Inappropriate content, Duplicate listing, Scam/fraud. Reports reviewed by moderation team within 24 hours. |

### 4.3. Seller Features

| Feature | Description | Details |
|---------|-------------|---------|
| **Listing Creation Wizard** | Step-by-step guided flow to create a vehicle listing | **Step 1 — Vehicle Info**: Make (dropdown), Model (dependent dropdown), Year (picker), Trim/Variant (text). **Step 2 — Details**: Mileage, Transmission, Fuel Type, Body Type, Drivetrain, Engine Size, Number of Cylinders, Color (exterior + interior), Number of Seats, Number of Doors, Condition (New/Excellent/Good/Fair/Salvage). **Step 3 — Features**: Multi-select checklist (ABS, Airbags, AC, Power Windows, Sunroof, Leather Seats, Navigation, Backup Camera, Bluetooth, Keyless Entry, Cruise Control, Heated Seats, etc.). **Step 4 — Photos & Video**: Upload 5–30 photos (required: front, rear, left side, right side, dashboard, odometer; optional: engine, trunk, seats, any damage). Optional 60-second video walkthrough. **Step 5 — Pricing**: Asking price (ETB), negotiable flag, trade-in considered flag. AI price suggestion displayed based on vehicle details. **Step 6 — Location**: Auto-detect GPS or manual city/sub-city selection. **Step 7 — Description**: Free-text description with character counter (min 50, max 2000). **Step 8 — Review & Publish**: Summary of all entered data. Publish or Save as Draft. |
| **Draft Listings** | Save incomplete listings | Auto-save after each wizard step. Drafts listed in seller dashboard. Resume from last completed step. |
| **Listing Management** | Edit, pause, or delete active listings | Edit any field. "Pause" removes from search results without deleting. "Mark as Sold" records sale and asks for sale price (for market data). |
| **Performance Analytics** | Track listing engagement | Views count, unique viewers, favorites count, contact inquiries, offer count, search impressions. Daily/weekly/monthly charts. |
| **Offer Management** | Review and respond to buyer offers | View all offers sorted by date or amount. Accept, Reject, or Counter with a new amount. Counter-offer includes optional message. |
| **Document Upload** | Attach verification documents | Upload: Vehicle registration (libre), insurance certificate, inspection report, import customs declaration. Documents are reviewed by moderation team and result in a "Verified Listing" badge. |
| **Promote Listing** | Pay to boost visibility | See Revenue Model section for pricing tiers. Options: "Featured" (homepage carousel), "Highlighted" (colored border in search results), "Top of Search" (pinned to top for selected keywords). |
| **Renewal** | Keep listings fresh | Listings auto-expire after 60 days. Sellers can renew for another 60 days (free for first renewal, nominal fee for subsequent renewals). |

### 4.4. Dealer Features

All seller features are included, plus the following dealer-exclusive capabilities:

| Feature | Description | Details |
|---------|-------------|---------|
| **Dealer Application** | Apply for a dealer account | Application form: Business name, Business license number, TIN number, Physical address, Years in business, Website (optional), Social media links, Contact person details. Requires upload of: Business license scan, TIN certificate, Kebele ID of contact person. Application reviewed by admin team within 48 hours. |
| **Branded Dealer Page** | Custom showroom storefront | Customizable header banner, logo, About Us text, Operating hours, Google Maps embed of dealership location, Contact information, Full inventory grid. Public URL: `ethiodrive.com/dealers/{dealer-slug}`. |
| **Bulk Inventory Upload** | Import multiple listings at once | CSV/Excel template provided. Fields map to listing wizard fields. Upload file → preview parsed data → confirm → bulk publish. Supports up to 500 listings per import. |
| **Inventory Management** | Central dashboard for all dealer listings | Table view with sort/filter. Bulk actions: Select multiple → Pause, Delete, Adjust Price (percentage or fixed amount). Inventory status overview: Active, Paused, Sold, Expired, Draft. |
| **Lead Management CRM** | Track and manage buyer interactions | Every buyer inquiry (chat message, offer, test drive request) creates a "Lead" record. Lead stages: New → Contacted → Interested → Negotiating → Closed (Won/Lost). Notes and follow-up reminders on each lead. |
| **Staff Accounts** | Multi-user access for dealership staff | Dealer owner invites staff via email/phone. Staff roles: Manager (full access), Sales Agent (listings + leads), Viewer (read-only analytics). Activity log shows which staff member performed each action. |
| **Analytics Dashboard** | Advanced business intelligence | Inventory performance, lead conversion funnel, revenue from promoted listings, customer acquisition channels, competitor pricing analysis (average prices for same make/model from other dealers). |
| **Subscription Management** | Manage dealer subscription tier | View current plan, usage (listing count vs. plan limit), billing history, upgrade/downgrade, payment method management. |
| **Verified Dealer Badge** | Trust indicator | Awarded after: business license verified, physical location confirmed, minimum 3 months active with < 2% report rate, average rating ≥ 4.0. Badge appears on all dealer listings and dealer page. |

### 4.5. Admin Features

See Section 12 (Admin Dashboard) for the complete admin specification.

### 4.6. AI Assistant

A conversational AI chatbot accessible from any screen via a floating "Ask AI" button (bottom-right corner, gold accent).

**Capabilities**:
- Answer questions about listings: *"What's the average price for a 2020 Toyota Corolla in Addis?"*
- Help find vehicles: *"Find me an SUV good for a family of 5, preferably Japanese make, under 5 million birr"*
- Explain features: *"What does CVT transmission mean?"*
- Provide buying advice: *"Should I buy a hybrid in Ethiopia? Are spare parts available?"*
- Navigate the app: *"Take me to my saved listings"*

**Technical Implementation**: Uses a fine-tuned LLM (OpenAI GPT-4 or Google Gemini API) with Retrieval-Augmented Generation (RAG) over the EthioDrive listing database and a curated automotive knowledge base. Responses are streamed token-by-token for a natural conversational feel.

**UI**: Chat bubble interface, pinned to bottom-right. Expandable to a chat panel (mobile: full-screen bottom sheet; desktop: side panel). Conversation history persisted per user. Quick-reply suggestion chips below AI responses.

### 4.7. Smart Search

Beyond the standard filter-based search, EthioDrive offers an AI-powered natural language search.

**Examples of supported queries**:
- *"Silver Toyota Vitz under 2 million ETB in Bole"*
- *"Cheap reliable car for a university student"*
- *"Family SUV, low mileage, automatic, 2018 or newer"*
- *"Cars similar to Toyota Corolla but cheaper"*

**How it works**: The user's natural language query is processed by the AI backend, which extracts structured filters (make, model, price range, location, etc.) and optionally generates a semantic embedding for similarity search. Results are returned ranked by relevance.

### 4.8. Vehicle Comparison

- Users can add vehicles to a comparison tray (persistent bar at bottom of screen, showing thumbnails of compared vehicles).
- Maximum 4 vehicles at a time.
- Comparison screen: horizontal scroll table with vehicles as columns and attributes as rows.
- Attributes compared: Price, Year, Make, Model, Mileage, Engine Size, Horsepower (if available), Transmission, Fuel Type, Body Type, Exterior Color, Interior Color, Condition, Number of Owners, All listed features (checked/unchecked per vehicle), Seller Type, Verification Status, AI Estimated Value.
- Differences between vehicles are highlighted with color coding (green for best-in-class, red for worst).
- "Remove" and "View Listing" actions per vehicle column.

### 4.9. Favorites & Collections

- **Quick Favorite**: Tap heart icon on any listing card.
- **Collections**: Users can create named collections (e.g., "Budget Options", "For Dad", "Dream Cars"). Default collection is "All Favorites".
- **Collection Sharing**: Generate a shareable link to a collection for friends/family.
- **Sync**: Favorites are synced in real-time across all user devices via the backend.
- **Notifications**: Optional price drop alerts for all favorited listings.
- **Max Favorites**: 500 per user account.

### 4.10. Notifications

**Notification Types**:

| Type | Channel | Trigger |
|------|---------|---------|
| New message | Push + In-app | Another user sends a chat message |
| Offer received | Push + In-app | Buyer submits an offer on your listing |
| Offer accepted/rejected | Push + In-app | Seller responds to your offer |
| Counter-offer | Push + In-app | Seller counters your offer |
| Price drop | Push + In-app | A favorited listing's price decreases |
| Saved search match | Push + In-app | New listing matches a saved search |
| Listing expiring | Push + In-app | Your listing expires in 7 days / 1 day |
| Listing approved/rejected | Push + In-app | Admin moderates your listing |
| Verification complete | Push + In-app | Your documents/dealer application are verified |
| System announcement | Push + In-app | Platform updates, maintenance notices |
| Review received | In-app only | Someone reviews your dealer page |
| Weekly digest | Email only | Summary of listing performance (sellers/dealers) |

**Notification Settings**: Users can granularly enable/disable each notification type per channel (push, in-app, email) from Settings.

**In-App Notification Center**: Accessible from the bell icon. Grouped by date. Each notification has: icon, title, body, timestamp, read/unread indicator. Tap navigates to relevant screen. "Mark all as read" action.

### 4.11. Chat & Messaging

**Architecture**: Real-time messaging powered by WebSocket connections with message persistence in PostgreSQL.

**Features**:
- **1:1 Conversations**: Buyer↔Seller, Buyer↔Dealer, User↔Admin Support.
- **Listing Context**: Every conversation is associated with a specific listing. The listing card is pinned at the top of the chat screen for context.
- **Message Types**: Text (max 2000 chars), Image (up to 5 per message, max 10MB each), Location pin (Google Maps), Offer (structured offer card embedded in chat), System message (e.g., "Offer accepted").
- **Read Receipts**: Single check (sent to server), double check (delivered to recipient's device), blue double check (read by recipient).
- **Typing Indicator**: Shows "Seller is typing..." in real-time.
- **Online Status**: Green dot for online, grey for offline, "Last seen X minutes ago".
- **Message Search**: Search within a conversation by keyword.
- **Block & Report**: Block a user from sending further messages. Report conversation to moderation team.
- **Auto-Responses**: Sellers can configure auto-response messages for when they are offline (e.g., "Thanks for your interest! I'll respond within 24 hours.").
- **Chat Archival**: Conversations are archived when a listing is marked as sold. Archived chats are accessible from a separate "Archived" tab.

### 4.12. Offer System

A structured system for formalizing price negotiations.

**Offer Flow**:

```mermaid
stateDiagram-v2
    [*] --> Pending: Buyer submits offer
    Pending --> Accepted: Seller accepts
    Pending --> Rejected: Seller rejects
    Pending --> Countered: Seller counter-offers
    Pending --> Withdrawn: Buyer withdraws
    Pending --> Expired: Validity period lapses
    Countered --> Pending: Buyer accepts counter (new offer)
    Countered --> Rejected: Buyer rejects counter
    Countered --> Expired: Buyer doesn't respond
    Accepted --> [*]: Transaction initiated
    Rejected --> [*]: Negotiation ends
    Withdrawn --> [*]: Buyer cancels
    Expired --> [*]: Timed out
```

**Offer Details**:
- **Offered Amount**: Must be ≥ 50% of listed price (prevents spam offers).
- **Message**: Optional message to the seller (max 500 chars).
- **Validity**: 24 hours, 48 hours, or 72 hours (selected by buyer).
- **Counter-Offer**: Seller can counter with any amount and their own message.
- **Binding Terms**: All offers are non-binding expressions of interest. Legal disclaimer displayed before submission.
- **Limit**: A buyer can have at most 3 active offers simultaneously (to prevent spam).

### 4.13. Reviews & Ratings

**What can be reviewed**:
- **Dealers**: Rated by buyers who have interacted with the dealer (initiated chat or submitted an offer). Reviews include: Overall Rating (1–5 stars), Communication (1–5), Vehicle Accuracy (1–5), Professionalism (1–5), Written Review (50–1000 chars).
- **Individual Sellers**: Simplified review after transaction: Overall Rating (1–5 stars), Written Review (50–500 chars).

**Review Policies**:
- One review per buyer per dealer/seller per transaction.
- Reviews are moderated before publication (checked for profanity, spam, personal information).
- Dealers can respond publicly to reviews (one response per review).
- Reviews cannot be edited after 48 hours.
- Reviews cannot be deleted by the reviewer (only by admin moderation).
- Aggregate rating is a weighted average (more recent reviews carry slightly higher weight).

### 4.14. Vehicle Verification

A multi-level verification system to build trust:

| Level | Badge | Requirements | Process |
|-------|-------|-------------|---------|
| **Basic** | ✓ (grey checkmark) | Phone number verified, listing photos uploaded | Automatic |
| **Documents Verified** | ✓✓ (blue checkmark) | Vehicle registration (libre) and insurance uploaded and confirmed by admin | Admin reviews uploaded documents within 24h |
| **Inspection Verified** | 🛡️ (gold shield) | Passed physical inspection by EthioDrive-certified mechanic | User books inspection via app → mechanic visits vehicle → completes digital checklist → uploads report + photos → admin approves |

**Inspection Checklist** (digital form completed by certified mechanic):
- Exterior condition (paint, body panels, glass, lights, tires — each rated Excellent/Good/Fair/Poor with photos)
- Interior condition (seats, dashboard, electronics, AC, controls)
- Engine bay (oil leaks, belt condition, fluid levels, unusual noises)
- Underneath (rust, frame damage, exhaust, suspension)
- Test drive (braking, steering, transmission smoothness, engine performance, unusual sounds)
- Odometer verification (cross-reference with service records if available)
- VIN/chassis number verification (matches documents)
- Overall condition score (0–100)
- Mechanic's comments and recommendations

### 4.15. Dealer Verification

| Verification Step | Description | Required Documents |
|-------------------|-------------|-------------------|
| Business License | Confirm valid Ethiopian trade license | Business license scan (renewed for current year) |
| TIN Verification | Confirm tax registration | TIN certificate |
| Physical Location | Confirm dealership exists at stated address | Google Maps verification + optional EthioDrive staff visit |
| Identity | Confirm identity of primary contact | Kebele ID or Passport of business owner |
| Track Record | Confirm good standing | No criminal record affidavit (optional, for Premium dealers) |

### 4.16. Fraud Prevention

**Automated Detection**:

| Check | Method | Action |
|-------|--------|--------|
| **Duplicate Listings** | Perceptual image hashing (pHash) to detect identical/near-identical photos across listings | Auto-flag for moderation review |
| **Stolen Images** | Reverse image search against known automotive stock photos and other platform listings | Auto-flag and warn user |
| **Unrealistic Pricing** | Statistical outlier detection (price < 40% of mean for same make/model/year) | Auto-flag, require seller to confirm price |
| **Rapid Relisting** | Same user posting identical listing within 7 days of deletion | Block and warn |
| **Fake Phone Numbers** | Validation against Ethio Telecom and Safaricom number formats | Reject at registration |
| **IP/Device Fingerprinting** | Track device IDs and IP addresses | Flag if single device creates 5+ accounts |
| **Behavioral Analysis** | ML model tracking suspicious patterns (rapid listing creation, identical descriptions, contact harvesting) | Score each user 0–100 fraud risk. Auto-flag users with score > 70 |
| **Text Analysis** | NLP scan of descriptions for known scam patterns ("urgently selling", "traveling abroad", "send deposit") | Auto-flag for review |

**Manual Moderation**:
- Dedicated moderation queue in Admin Dashboard.
- Moderators can: Approve, Reject (with reason), Request More Info, Ban User.
- SLA: All flagged items reviewed within 24 hours.

### 4.17. Vehicle History Support

A structured report aggregating available historical data for a vehicle:

- **Ownership History**: Number of previous owners (if data is available from registration records).
- **Accident History**: Records of reported accidents (if data is available from insurance databases or police reports).
- **Service Records**: Maintenance history from partnered service centers (oil changes, major repairs, part replacements).
- **Import Information**: Country of origin, import date, customs value declared, duty paid.
- **Odometer Readings**: Historical mileage readings from service records to detect rollback.

**Note**: Ethiopian vehicle history infrastructure is still developing. EthioDrive will initially provide data from its own partnered service centers and verified inspection reports. As national vehicle registries digitize, integration with government databases will be added.

### 4.18. Image Gallery & Video Support

**Image Handling**:
- **Upload**: Sellers upload 5–30 images per listing.
- **Required Angles**: Front, rear, left side, right side, dashboard (minimum 5 photos enforced).
- **File Requirements**: JPEG or PNG, min 800×600px, max 10MB per image.
- **Processing Pipeline**: Uploaded images are processed server-side: resized to multiple variants (thumbnail 200px, card 600px, detail 1200px, full 2400px), compressed (WebP format for web, JPEG for older clients), EXIF data stripped (for privacy), watermarked with subtle EthioDrive logo.
- **Gallery UI**: Full-screen swipeable gallery with pinch-to-zoom. Thumbnail strip at bottom. Counter showing current position (e.g., "3 / 15").
- **360° View**: Optional. Sellers can upload a series of 36 photos taken at 10° intervals around the vehicle. The app stitches these into an interactive 360° spin view.

**Video Support**:
- **Upload**: Optional 60-second video walkthrough per listing.
- **File Requirements**: MP4 or MOV, max 100MB, min 720p resolution.
- **Processing**: Server-side transcoding to H.264/AAC MP4, multiple quality levels (360p, 720p, 1080p) for adaptive streaming.
- **Playback**: In-app video player with play/pause, mute, full-screen. Auto-play muted in listing detail (below image gallery).

### 4.19. Maps Integration & Location Services

**Google Maps API Integration**:
- **Listing Location**: Every listing displays a map showing the vehicle's approximate location (city/sub-city level, never exact address for privacy). Tappable to open in Google Maps for directions.
- **Dealer Location**: Dealer pages embed a Google Map with the exact dealership pin, operating hours, and a "Get Directions" button.
- **Proximity Search**: Users can search for vehicles within a specified radius (5km–200km) of their current GPS location or a manually entered location.
- **Cluster View**: A map-based browsing mode where vehicle listings appear as pins on a Google Map. Clusters show count (e.g., "42 vehicles") and expand on zoom. Tapping a pin shows a mini listing card.

**Location Permissions**:
- Location access is optional. Users who deny location permission can manually select their city.
- Location is requested only when needed (search, posting a listing) with a clear explanation of why it's being requested.
- Location data is never shared with other users beyond city/sub-city level.

---

## 5. Technical Architecture (Flutter)

### 5.1. Architecture Overview

EthioDrive follows **Clean Architecture** with a **feature-first folder structure**, ensuring separation of concerns, testability, and scalability.

```mermaid
graph TB
    subgraph "Presentation Layer"
        A[Screens / Pages]
        B[Widgets]
        C[BLoC / Cubit]
    end
    subgraph "Domain Layer"
        D[Entities]
        E[Use Cases]
        F[Repository Interfaces]
    end
    subgraph "Data Layer"
        G[Repository Implementations]
        H[Remote Data Sources]
        I[Local Data Sources]
        J[Data Models / DTOs]
    end
    A --> C
    C --> E
    E --> F
    F -.-> G
    G --> H
    G --> I
    H --> K[REST API / WebSocket]
    I --> L[Hive / Isar Local DB]
    J --> G
```

**Layer Rules**:
- **Presentation**: Knows about Domain. Never imports Data.
- **Domain**: Pure Dart. No Flutter imports, no external package dependencies. Contains business logic only.
- **Data**: Knows about Domain (implements repository interfaces). Contains API calls, local database operations, and data serialization.

### 5.2. Feature-First Folder Structure

```
lib/
├── app/
│   ├── app.dart                          # MaterialApp configuration
│   ├── app_bloc_observer.dart            # Global BLoC observer for logging
│   └── routes/
│       ├── app_router.dart               # GoRouter configuration
│       └── route_names.dart              # Route name constants
│
├── core/
│   ├── constants/
│   │   ├── api_constants.dart            # Base URLs, API versions
│   │   ├── app_constants.dart            # App-wide constants
│   │   ├── storage_constants.dart        # Hive box names, keys
│   │   └── asset_paths.dart              # Image/icon asset paths
│   ├── di/
│   │   └── injection_container.dart      # GetIt service locator setup
│   ├── error/
│   │   ├── exceptions.dart               # Custom exception classes
│   │   └── failures.dart                 # Failure classes (for Either returns)
│   ├── network/
│   │   ├── api_client.dart               # Dio HTTP client with interceptors
│   │   ├── network_info.dart             # Connectivity checker
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart      # Attach JWT to requests
│   │       ├── error_interceptor.dart     # Map HTTP errors to exceptions
│   │       ├── logging_interceptor.dart   # Log requests/responses
│   │       └── retry_interceptor.dart     # Retry on 5xx or network errors
│   ├── theme/
│   │   ├── app_colors.dart               # Color palette tokens
│   │   ├── app_text_styles.dart          # Typography tokens
│   │   ├── app_spacing.dart              # Spacing tokens
│   │   ├── app_theme.dart                # ThemeData configuration
│   │   └── app_decorations.dart          # BoxDecoration presets
│   ├── utils/
│   │   ├── date_formatter.dart
│   │   ├── currency_formatter.dart       # ETB formatting with commas
│   │   ├── validators.dart               # Email, phone, password validation
│   │   ├── debouncer.dart
│   │   └── image_utils.dart              # Image compression, cropping
│   └── widgets/
│       ├── app_bar.dart                  # Custom EthioDrive app bar
│       ├── bottom_nav.dart               # Bottom navigation bar
│       ├── loading_indicator.dart         # Gold shimmer loading
│       ├── error_widget.dart             # Styled error display
│       ├── empty_state.dart              # No results illustration
│       ├── gold_button.dart              # Primary CTA button
│       ├── cached_image.dart             # CachedNetworkImage wrapper
│       └── verification_badge.dart       # Verification level badge
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── user_model.dart
│   │   │   │   └── token_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_with_phone.dart
│   │   │       ├── login_with_email.dart
│   │   │       ├── login_with_google.dart
│   │   │       ├── register_user.dart
│   │   │       ├── verify_otp.dart
│   │   │       ├── logout.dart
│   │   │       └── get_current_user.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── auth_bloc.dart
│   │       │   ├── auth_event.dart
│   │       │   └── auth_state.dart
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   ├── otp_verification_page.dart
│   │       │   └── profile_completion_page.dart
│   │       └── widgets/
│   │           ├── phone_input_field.dart
│   │           ├── otp_input_field.dart
│   │           └── social_login_buttons.dart
│   │
│   ├── listings/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── vehicle_listing.dart
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   │       ├── get_listings.dart
│   │   │       ├── get_listing_detail.dart
│   │   │       ├── create_listing.dart
│   │   │       ├── update_listing.dart
│   │   │       ├── delete_listing.dart
│   │   │       ├── search_listings.dart
│   │   │       └── promote_listing.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── home_page.dart
│   │       │   ├── listing_detail_page.dart
│   │       │   ├── create_listing_page.dart
│   │       │   └── my_listings_page.dart
│   │       └── widgets/
│   │           ├── listing_card.dart
│   │           ├── listing_grid.dart
│   │           ├── image_gallery.dart
│   │           └── price_display.dart
│   │
│   ├── search/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       │   ├── search_page.dart
│   │       │   └── filter_page.dart
│   │       └── widgets/
│   │           ├── filter_chips.dart
│   │           ├── search_bar.dart
│   │           └── search_suggestions.dart
│   │
│   ├── chat/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── offers/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── favorites/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── comparison/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── notifications/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── profile/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── dealer/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── reviews/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── inspection/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   ├── ai_assistant/
│   │   ├── data/ ...
│   │   ├── domain/ ...
│   │   └── presentation/ ...
│   │
│   └── settings/
│       ├── data/ ...
│       ├── domain/ ...
│       └── presentation/ ...
│
├── l10n/
│   ├── app_en.arb                        # English translations
│   └── app_am.arb                        # Amharic translations
│
└── main.dart                              # Entry point
```

### 5.3. State Management

**Primary**: `flutter_bloc` (BLoC pattern) for all feature-level state management.

**Why BLoC**:
- Enforces unidirectional data flow (Event → BLoC → State).
- Excellent testability (unit test BLoCs without any UI).
- Built-in support for stream transformations, debouncing, and concurrency handling.
- `BlocObserver` for centralized logging of all state transitions.
- `HydratedBloc` for automatic state persistence (offline support).

**State Conventions**:
- Every feature's state extends a sealed class with four substates: `Initial`, `Loading`, `Loaded(data)`, `Error(message)`.
- Complex features may have additional substates as needed.
- States are immutable. Use `copyWith()` for state updates.
- UI widgets use `BlocBuilder`, `BlocListener`, or `BlocConsumer` to react to state changes.

### 5.4. Repository Pattern

Every data operation is abstracted behind a repository interface defined in the Domain layer.

```dart
// domain/repositories/listing_repository.dart (INTERFACE)
abstract class ListingRepository {
  Future<Either<Failure, List<VehicleListing>>> getListings(ListingFilter filter);
  Future<Either<Failure, VehicleListing>> getListingById(String id);
  Future<Either<Failure, VehicleListing>> createListing(CreateListingParams params);
  Future<Either<Failure, void>> deleteListing(String id);
}

// data/repositories/listing_repository_impl.dart (IMPLEMENTATION)
class ListingRepositoryImpl implements ListingRepository {
  final ListingRemoteDataSource remoteDataSource;
  final ListingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  // Checks network, tries remote, falls back to local cache
}
```

**`Either<Failure, T>` Pattern**: All repository methods return `Either` from the `dartz` or `fpdart` package. `Left` contains a `Failure` object (with user-friendly message and optional error code). `Right` contains the success data. This eliminates try-catch blocks in the presentation layer and makes error handling explicit.

### 5.5. Dependency Injection

**Package**: `get_it` + `injectable` for compile-time-safe service locator setup.

- All dependencies are registered in `injection_container.dart`.
- `@injectable` annotation on implementation classes.
- `@lazySingleton` for services that should be instantiated once (API client, repositories, BLoCs that manage global state).
- `@factoryMethod` for BLoCs that are scoped to a specific page lifecycle.
- Environment-based registration (`@Environment('dev')`, `@Environment('prod')`) for swapping implementations (e.g., mock data source in development).

### 5.6. Error Handling

**Exception Hierarchy**:

```
AppException (base)
├── ServerException (HTTP 5xx, timeout)
├── NetworkException (no internet)
├── AuthException (401, 403)
│   ├── TokenExpiredException
│   └── UnauthorizedException
├── ValidationException (400, bad input)
├── NotFoundException (404)
├── ConflictException (409, duplicate)
├── RateLimitException (429)
└── CacheException (local storage failure)
```

**Failure Hierarchy** (mirrors exceptions, used in Domain layer):

```
Failure (base)
├── ServerFailure
├── NetworkFailure
├── AuthFailure
├── ValidationFailure
├── NotFoundFailure
├── CacheFailure
└── UnexpectedFailure
```

Each `Failure` carries:
- `message`: User-friendly error message (localized).
- `code`: Optional error code for programmatic handling.
- `details`: Optional map of field-level validation errors.

### 5.7. Logging

**Package**: `logger` (for local development) + Firebase Crashlytics (for production crash/error logging).

**Log Levels**:
- `verbose`: Detailed data (API request/response bodies). Development only.
- `debug`: Flow information (use case called, state transitions). Development only.
- `info`: Significant events (user logged in, listing created). All environments.
- `warning`: Recoverable issues (cache miss, retry attempt). All environments.
- `error`: Errors that affect user experience. All environments. Sent to Crashlytics.
- `fatal`: Unrecoverable errors. All environments. Sent to Crashlytics with full stack trace.

**Structured Logging**: All log entries include: timestamp, log level, feature module name, message, optional metadata map. In production, errors and fatals are reported to Firebase Crashlytics with user ID and device info attached.

### 5.8. Offline Support & Caching Strategy

**Local Database**: Hive (for simple key-value caching) or Isar (for complex queryable data).

**Caching Tiers**:

| Data | Cache Duration | Strategy | Local Storage |
|------|---------------|----------|---------------|
| User profile | Until logout | Write-through | Hive |
| Vehicle listing details | 1 hour | Cache-first, refresh in background | Isar |
| Search results | 15 minutes | Network-first, fallback to cache | Isar |
| Chat messages | Permanent (synced) | Write-through + WebSocket sync | Isar |
| Favorites list | Until change | Write-through | Isar |
| App configuration | 24 hours | Cache-first | Hive |
| Images | Disk cache, 200MB max | LRU eviction | `cached_network_image` |
| Auth tokens | Until expiry | Encrypted storage | `flutter_secure_storage` |

**Offline Behavior**:
- Users can browse previously loaded listings, view their favorites, and read cached chat history while offline.
- Actions that require network (posting listing, sending message, making offer) are queued and executed when connectivity is restored (using a local action queue in Hive).
- A persistent banner appears at the top of the screen when offline: "You are offline. Some features may be unavailable."

### 5.9. Navigation

**Package**: `go_router` for declarative, URL-based routing.

**Key Routes**:

| Route | Path | Auth Required | Description |
|-------|------|--------------|-------------|
| Splash | `/` | No | Loading screen, check auth status |
| Onboarding | `/onboarding` | No | First-time user tutorial (3 screens) |
| Login | `/login` | No | Login screen |
| Register | `/register` | No | Registration screen |
| OTP Verify | `/verify-otp` | No | OTP input screen |
| Home | `/home` | Yes | Main feed with bottom nav |
| Search | `/search` | Yes | Search with filters |
| Listing Detail | `/listings/:id` | Yes | Vehicle detail page |
| Create Listing | `/listings/create` | Yes | Listing wizard |
| Edit Listing | `/listings/:id/edit` | Yes | Edit existing listing |
| Chat List | `/chats` | Yes | All conversations |
| Chat Detail | `/chats/:id` | Yes | Individual conversation |
| Profile | `/profile` | Yes | User's own profile |
| User Profile | `/users/:id` | Yes | Another user's public profile |
| Dealer Page | `/dealers/:slug` | No | Public dealer storefront |
| Favorites | `/favorites` | Yes | Saved listings |
| Comparison | `/compare` | Yes | Vehicle comparison |
| Notifications | `/notifications` | Yes | Notification center |
| Settings | `/settings` | Yes | App settings |
| AI Assistant | `/ai-assistant` | Yes | AI chatbot |

**Deep Links**: Every listing and dealer page has a deep link URL (`ethiodrive.com/listings/{id}`, `ethiodrive.com/dealers/{slug}`) that opens the app directly to that content, or falls back to the web version.

---

## 6. Backend Architecture

### 6.1. Technology Stack

| Component | Technology | Rationale |
|-----------|-----------|-----------|
| **Runtime** | Node.js 20 LTS | Non-blocking I/O, excellent for real-time features, large ecosystem |
| **Framework** | NestJS 10 | TypeScript-first, modular architecture, built-in DI, decorators, guards, pipes |
| **HTTP** | Express (underlying NestJS) | Battle-tested, high performance |
| **WebSocket** | Socket.io (via `@nestjs/websockets`) | Real-time chat and notifications, auto-reconnect, room support |
| **Validation** | `class-validator` + `class-transformer` | Decorator-based DTO validation |
| **ORM** | Prisma 5 | Type-safe database access, migrations, studio GUI |
| **Authentication** | Passport.js + JWT | Flexible auth strategies (local, Google, Apple) |
| **API Docs** | Swagger (`@nestjs/swagger`) | Auto-generated OpenAPI documentation |
| **Task Queue** | Bull (Redis-backed) | Background job processing (email, image processing, AI inference) |
| **Cache** | Redis 7 | Session cache, rate limiting, pub/sub for WebSocket scaling |
| **File Upload** | Multer + Supabase Storage SDK | Direct upload to cloud storage |
| **Email** | Nodemailer + SendGrid | Transactional emails (verification, reset, digest) |
| **SMS** | Africa's Talking API or Twilio | OTP delivery to Ethiopian phone numbers |
| **Logging** | Winston + Morgan | Structured logging with JSON format |
| **Testing** | Jest + Supertest | Unit and integration testing |

### 6.2. Backend Folder Structure

```
server/
├── src/
│   ├── main.ts                           # NestJS bootstrap
│   ├── app.module.ts                     # Root module
│   │
│   ├── common/
│   │   ├── decorators/
│   │   │   ├── current-user.decorator.ts  # Extract user from request
│   │   │   ├── roles.decorator.ts         # @Roles('admin', 'dealer')
│   │   │   └── public.decorator.ts        # Mark endpoint as public
│   │   ├── guards/
│   │   │   ├── jwt-auth.guard.ts          # JWT token validation
│   │   │   ├── roles.guard.ts             # Role-based access control
│   │   │   └── throttle.guard.ts          # Rate limiting guard
│   │   ├── interceptors/
│   │   │   ├── transform.interceptor.ts   # Standard response envelope
│   │   │   ├── logging.interceptor.ts     # Request/response logging
│   │   │   └── timeout.interceptor.ts     # Request timeout (30s)
│   │   ├── filters/
│   │   │   └── http-exception.filter.ts   # Global exception handler
│   │   ├── pipes/
│   │   │   └── validation.pipe.ts         # DTO validation pipe
│   │   ├── dto/
│   │   │   ├── pagination.dto.ts          # page, limit, sort
│   │   │   └── api-response.dto.ts        # Standard response wrapper
│   │   └── enums/
│   │       ├── user-role.enum.ts
│   │       ├── listing-status.enum.ts
│   │       ├── offer-status.enum.ts
│   │       └── verification-level.enum.ts
│   │
│   ├── modules/
│   │   ├── auth/
│   │   │   ├── auth.module.ts
│   │   │   ├── auth.controller.ts
│   │   │   ├── auth.service.ts
│   │   │   ├── strategies/
│   │   │   │   ├── jwt.strategy.ts
│   │   │   │   ├── google.strategy.ts
│   │   │   │   └── apple.strategy.ts
│   │   │   └── dto/
│   │   │       ├── register.dto.ts
│   │   │       ├── login.dto.ts
│   │   │       ├── verify-otp.dto.ts
│   │   │       └── refresh-token.dto.ts
│   │   │
│   │   ├── users/
│   │   │   ├── users.module.ts
│   │   │   ├── users.controller.ts
│   │   │   ├── users.service.ts
│   │   │   └── dto/
│   │   │       ├── update-profile.dto.ts
│   │   │       └── user-response.dto.ts
│   │   │
│   │   ├── listings/
│   │   │   ├── listings.module.ts
│   │   │   ├── listings.controller.ts
│   │   │   ├── listings.service.ts
│   │   │   └── dto/
│   │   │       ├── create-listing.dto.ts
│   │   │       ├── update-listing.dto.ts
│   │   │       ├── listing-filter.dto.ts
│   │   │       └── listing-response.dto.ts
│   │   │
│   │   ├── search/
│   │   │   ├── search.module.ts
│   │   │   ├── search.controller.ts
│   │   │   └── search.service.ts
│   │   │
│   │   ├── chat/
│   │   │   ├── chat.module.ts
│   │   │   ├── chat.gateway.ts           # WebSocket gateway
│   │   │   ├── chat.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── offers/
│   │   │   ├── offers.module.ts
│   │   │   ├── offers.controller.ts
│   │   │   ├── offers.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── favorites/
│   │   │   ├── favorites.module.ts
│   │   │   ├── favorites.controller.ts
│   │   │   └── favorites.service.ts
│   │   │
│   │   ├── reviews/
│   │   │   ├── reviews.module.ts
│   │   │   ├── reviews.controller.ts
│   │   │   ├── reviews.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── notifications/
│   │   │   ├── notifications.module.ts
│   │   │   ├── notifications.controller.ts
│   │   │   ├── notifications.service.ts
│   │   │   └── notifications.gateway.ts   # Real-time notification push
│   │   │
│   │   ├── dealers/
│   │   │   ├── dealers.module.ts
│   │   │   ├── dealers.controller.ts
│   │   │   ├── dealers.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── inspections/
│   │   │   ├── inspections.module.ts
│   │   │   ├── inspections.controller.ts
│   │   │   ├── inspections.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── ai/
│   │   │   ├── ai.module.ts
│   │   │   ├── ai.controller.ts
│   │   │   ├── ai.service.ts
│   │   │   ├── price-estimator.service.ts
│   │   │   ├── recommendation.service.ts
│   │   │   └── fraud-detector.service.ts
│   │   │
│   │   ├── admin/
│   │   │   ├── admin.module.ts
│   │   │   ├── admin.controller.ts
│   │   │   ├── admin.service.ts
│   │   │   └── dto/
│   │   │
│   │   ├── payments/
│   │   │   ├── payments.module.ts
│   │   │   ├── payments.controller.ts
│   │   │   ├── payments.service.ts
│   │   │   └── dto/
│   │   │
│   │   └── upload/
│   │       ├── upload.module.ts
│   │       ├── upload.controller.ts
│   │       └── upload.service.ts
│   │
│   └── config/
│       ├── configuration.ts               # Environment config loader
│       ├── database.config.ts             # Prisma connection config
│       ├── redis.config.ts                # Redis connection config
│       ├── jwt.config.ts                  # JWT secret, expiry config
│       └── cors.config.ts                 # CORS whitelist
│
├── prisma/
│   ├── schema.prisma                      # Database schema
│   └── migrations/                        # Migration history
│
├── test/
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
├── docker-compose.yml                     # Local dev environment
├── Dockerfile                             # Production container
├── .env.example                           # Environment variables template
├── nest-cli.json
├── tsconfig.json
└── package.json
```

### 6.3. REST API Design Principles

- **URL Structure**: `/api/v1/{resource}` — pluralized, lowercase, hyphen-separated.
- **HTTP Methods**: `GET` (read), `POST` (create), `PATCH` (partial update), `PUT` (full replace, used rarely), `DELETE` (remove).
- **Response Envelope**: All responses wrapped in a standard envelope:

```json
{
  "status": "success" | "error",
  "data": { ... },
  "meta": {
    "pagination": { "page": 1, "limit": 20, "total": 150, "pages": 8 }
  },
  "message": "Optional human-readable message"
}
```

- **Error Response**:

```json
{
  "status": "error",
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      { "field": "price", "message": "Price must be a positive number" },
      { "field": "year", "message": "Year must be between 1950 and 2026" }
    ]
  }
}
```

### 6.4. WebSocket Architecture

**Connection**: Clients connect to `wss://api.ethiodrive.com/socket` with a JWT token as a query parameter.

**Rooms**:
- `user:{userId}` — personal room for notifications.
- `chat:{conversationId}` — conversation-specific room for messages.
- `listing:{listingId}` — real-time updates for a specific listing (price changes, new offers).

**Events**:

| Event | Direction | Payload | Description |
|-------|-----------|---------|-------------|
| `message:send` | Client → Server | `{ conversationId, content, type }` | Send a chat message |
| `message:new` | Server → Client | `{ message }` | Receive a new message |
| `message:read` | Client → Server | `{ conversationId, messageId }` | Mark message as read |
| `typing:start` | Client → Server | `{ conversationId }` | User started typing |
| `typing:stop` | Client → Server | `{ conversationId }` | User stopped typing |
| `typing:indicator` | Server → Client | `{ conversationId, userId }` | Another user is typing |
| `notification:new` | Server → Client | `{ notification }` | New notification |
| `offer:update` | Server → Client | `{ offer }` | Offer status changed |
| `listing:update` | Server → Client | `{ listing }` | Listing was updated |

### 6.5. Authentication & Authorization Flow

```mermaid
sequenceDiagram
    participant C as Client (Flutter)
    participant S as Server (NestJS)
    participant DB as Database
    participant R as Redis

    C->>S: POST /api/v1/auth/login {phone, otp}
    S->>DB: Verify user, validate OTP
    DB-->>S: User found, OTP valid
    S->>S: Generate access token (15min) + refresh token (30d)
    S->>R: Store refresh token hash
    S-->>C: {accessToken, refreshToken, user}

    Note over C,S: Subsequent authenticated requests

    C->>S: GET /api/v1/listings (Authorization: Bearer {accessToken})
    S->>S: Validate JWT, extract user, check roles
    S->>DB: Fetch listings
    S-->>C: {listings}

    Note over C,S: Token refresh flow

    C->>S: POST /api/v1/auth/refresh {refreshToken}
    S->>R: Validate refresh token hash exists
    R-->>S: Valid
    S->>S: Generate new access token + new refresh token
    S->>R: Replace old refresh token hash with new
    S-->>C: {accessToken, refreshToken}
```

**Role-Based Access Control (RBAC)**:

| Role | Permissions |
|------|------------|
| `buyer` | Browse listings, search, favorite, chat, make offers, write reviews |
| `seller` | All buyer permissions + create/edit/delete own listings, manage offers |
| `dealer` | All seller permissions + bulk upload, staff accounts, CRM, analytics |
| `inspector` | Submit inspection reports for assigned inspections |
| `moderator` | Review flagged content, approve/reject listings and documents |
| `admin` | Full platform access including user management, analytics, CMS |
| `super_admin` | Admin permissions + manage admin/moderator accounts, system configuration |

### 6.6. Validation

All incoming request data is validated using `class-validator` decorators on DTO classes:

```typescript
// Example: CreateListingDto
export class CreateListingDto {
  @IsNotEmpty()
  @IsString()
  @MaxLength(50)
  make: string;

  @IsNotEmpty()
  @IsString()
  @MaxLength(50)
  model: string;

  @IsInt()
  @Min(1950)
  @Max(new Date().getFullYear() + 1)
  year: number;

  @IsNumber()
  @Min(1)
  price: number;

  @IsEnum(FuelType)
  fuelType: FuelType;

  @IsEnum(TransmissionType)
  transmission: TransmissionType;

  @IsEnum(BodyType)
  bodyType: BodyType;

  @IsOptional()
  @IsString()
  @MinLength(50)
  @MaxLength(2000)
  description?: string;

  @IsArray()
  @ArrayMinSize(5)
  @ArrayMaxSize(30)
  @IsUrl({}, { each: true })
  imageUrls: string[];
}
```

### 6.7. Rate Limiting

**Global**: 100 requests per minute per IP address for unauthenticated endpoints.

**Authenticated**: 300 requests per minute per user.

**Endpoint-Specific Limits**:

| Endpoint | Limit | Window | Reason |
|----------|-------|--------|--------|
| `POST /auth/login` | 5 | 15 min | Brute force prevention |
| `POST /auth/register` | 3 | 1 hour | Account creation spam |
| `POST /auth/verify-otp` | 5 | 5 min | OTP guessing prevention |
| `POST /listings` | 10 | 1 hour | Listing spam |
| `POST /messages` | 60 | 1 min | Chat spam |
| `POST /offers` | 10 | 1 hour | Offer spam |

Implemented using `@nestjs/throttler` backed by Redis for distributed rate limiting across multiple server instances.

### 6.8. API Versioning

- URL-based versioning: `/api/v1/`, `/api/v2/`.
- New API versions introduced only for breaking changes.
- Previous versions supported for minimum 6 months after deprecation announcement.
- Deprecation headers included in responses: `Sunset: Sat, 01 Jan 2028 00:00:00 GMT`.
- Version negotiation: if client requests unsupported version, return `400` with message listing available versions.

---

## 7. Database Design

### 7.1. Database System

- **Primary Database**: PostgreSQL 15 (managed via Supabase).
- **Cache**: Redis 7 (managed via Upstash or self-hosted).
- **Local Mobile DB**: Hive / Isar.
- **ORM**: Prisma 5 with TypeScript.

### 7.2. Complete ER Diagram

```mermaid
erDiagram
    USERS ||--o{ LISTINGS : creates
    USERS ||--o{ OFFERS : "makes (as buyer)"
    USERS ||--o{ MESSAGES : sends
    USERS ||--o{ FAVORITES : saves
    USERS ||--o{ REVIEWS : writes
    USERS ||--o{ NOTIFICATIONS : receives
    USERS ||--o{ SAVED_SEARCHES : creates
    USERS ||--o{ REPORTS : submits
    USERS ||--o{ AUDIT_LOGS : generates
    USERS ||--o| DEALERS : "is (if dealer)"
    USERS ||--o{ USER_DEVICES : has

    DEALERS ||--o{ DEALER_STAFF : employs
    DEALERS ||--o{ SUBSCRIPTIONS : has
    DEALERS ||--o{ LISTINGS : owns

    LISTINGS ||--o{ LISTING_IMAGES : contains
    LISTINGS ||--o{ LISTING_FEATURES : has
    LISTINGS ||--o{ OFFERS : receives
    LISTINGS ||--o{ FAVORITES : "favorited by"
    LISTINGS ||--o{ REPORTS : "reported on"
    LISTINGS ||--o| INSPECTIONS : "inspected by"
    LISTINGS ||--o| VEHICLE_HISTORY : "history of"
    LISTINGS ||--o{ LISTING_VIEWS : "viewed by"
    LISTINGS ||--o| PROMOTIONS : "promoted via"

    CONVERSATIONS ||--o{ MESSAGES : contains
    CONVERSATIONS }o--|| LISTINGS : "about"
    USERS }o--o{ CONVERSATIONS : participates

    REVIEWS }o--|| USERS : "about (seller/dealer)"

    INSPECTIONS ||--o{ INSPECTION_ITEMS : contains

    USERS {
        uuid id PK
        varchar email UK
        varchar phone UK
        varchar password_hash
        varchar full_name
        varchar avatar_url
        varchar city
        varchar sub_city
        enum role "buyer | seller | dealer | inspector | moderator | admin | super_admin"
        enum status "active | suspended | banned | deleted"
        varchar language_preference "en | am"
        boolean is_email_verified
        boolean is_phone_verified
        boolean is_profile_complete
        decimal fraud_risk_score "0.00 to 1.00"
        varchar google_id
        varchar apple_id
        varchar fcm_token
        timestamp last_login_at
        timestamp created_at
        timestamp updated_at
    }

    USER_DEVICES {
        uuid id PK
        uuid user_id FK
        varchar device_id "unique device fingerprint"
        varchar platform "android | ios | web | windows | macos | linux"
        varchar fcm_token
        varchar app_version
        timestamp last_active_at
        timestamp created_at
    }

    DEALERS {
        uuid id PK
        uuid user_id FK "one-to-one"
        varchar business_name UK
        varchar slug UK "URL-friendly name"
        text about
        varchar business_license_number
        varchar tin_number
        varchar address
        varchar city
        varchar sub_city
        decimal latitude
        decimal longitude
        varchar phone
        varchar website
        varchar logo_url
        varchar banner_url
        jsonb operating_hours "Mon-Sun open/close times"
        enum verification_status "pending | verified | rejected | suspended"
        varchar rejection_reason
        decimal average_rating "denormalized, 1.0-5.0"
        int total_reviews "denormalized count"
        int total_listings "denormalized count"
        timestamp verified_at
        timestamp created_at
        timestamp updated_at
    }

    DEALER_STAFF {
        uuid id PK
        uuid dealer_id FK
        uuid user_id FK
        enum role "manager | sales_agent | viewer"
        timestamp created_at
    }

    SUBSCRIPTIONS {
        uuid id PK
        uuid dealer_id FK
        enum plan "basic | professional | enterprise"
        enum status "active | past_due | cancelled | expired"
        int listing_limit
        decimal price_etb
        enum billing_cycle "monthly | annual"
        timestamp current_period_start
        timestamp current_period_end
        timestamp created_at
        timestamp updated_at
    }

    LISTINGS {
        uuid id PK
        uuid user_id FK
        uuid dealer_id FK "nullable, set if posted by dealer"
        varchar make
        varchar model
        varchar trim
        int year
        decimal price
        boolean is_negotiable
        boolean accepts_trade_in
        varchar currency "ETB"
        int mileage_km
        enum fuel_type "petrol | diesel | hybrid | electric"
        enum transmission "automatic | manual | cvt"
        enum body_type "sedan | suv | hatchback | pickup | van | bus | truck | coupe | wagon"
        enum drivetrain "fwd | rwd | awd | 4wd"
        int engine_size_cc
        int cylinders
        varchar exterior_color
        varchar interior_color
        int seats
        int doors
        enum condition "new | excellent | good | fair | salvage"
        text description
        varchar city
        varchar sub_city
        decimal latitude
        decimal longitude
        enum status "draft | pending_review | active | paused | sold | expired | rejected"
        varchar rejection_reason
        enum verification_level "none | basic | documents_verified | inspection_verified"
        int view_count "denormalized"
        int favorite_count "denormalized"
        int offer_count "denormalized"
        decimal ai_estimated_price
        varchar video_url
        timestamp published_at
        timestamp expires_at
        timestamp sold_at
        decimal sold_price "recorded when marked as sold"
        timestamp created_at
        timestamp updated_at
    }

    LISTING_IMAGES {
        uuid id PK
        uuid listing_id FK
        varchar url
        varchar thumbnail_url
        varchar medium_url
        int display_order
        boolean is_primary
        varchar alt_text
        timestamp created_at
    }

    LISTING_FEATURES {
        uuid id PK
        uuid listing_id FK
        varchar feature_name "e.g., sunroof, leather_seats, abs, airbags"
    }

    LISTING_VIEWS {
        uuid id PK
        uuid listing_id FK
        uuid user_id FK "nullable for anonymous views"
        varchar ip_address
        varchar user_agent
        timestamp viewed_at
    }

    PROMOTIONS {
        uuid id PK
        uuid listing_id FK
        uuid user_id FK "who paid"
        enum type "featured | highlighted | top_of_search"
        decimal amount_paid
        varchar payment_reference
        timestamp start_date
        timestamp end_date
        enum status "active | expired | cancelled"
        timestamp created_at
    }

    OFFERS {
        uuid id PK
        uuid listing_id FK
        uuid buyer_id FK
        uuid seller_id FK
        decimal offered_amount
        text message
        enum status "pending | accepted | rejected | countered | withdrawn | expired"
        decimal counter_amount "set if status = countered"
        text counter_message
        int validity_hours "24 | 48 | 72"
        timestamp expires_at
        timestamp responded_at
        timestamp created_at
        timestamp updated_at
    }

    CONVERSATIONS {
        uuid id PK
        uuid listing_id FK
        uuid buyer_id FK
        uuid seller_id FK
        timestamp last_message_at
        boolean is_archived
        timestamp created_at
    }

    MESSAGES {
        uuid id PK
        uuid conversation_id FK
        uuid sender_id FK
        enum type "text | image | location | offer | system"
        text content
        varchar image_url
        decimal location_lat
        decimal location_lng
        uuid offer_id FK "if type = offer"
        boolean is_read
        timestamp read_at
        timestamp created_at
    }

    FAVORITES {
        uuid id PK
        uuid user_id FK
        uuid listing_id FK
        varchar collection_name "default: All Favorites"
        timestamp created_at
    }

    SAVED_SEARCHES {
        uuid id PK
        uuid user_id FK
        varchar name
        jsonb filters "serialized filter object"
        boolean notify_on_match
        timestamp created_at
    }

    REVIEWS {
        uuid id PK
        uuid reviewer_id FK "who wrote the review"
        uuid reviewee_id FK "who is being reviewed (seller/dealer user_id)"
        uuid listing_id FK "associated listing"
        int overall_rating "1-5"
        int communication_rating "1-5, for dealers"
        int accuracy_rating "1-5, for dealers"
        int professionalism_rating "1-5, for dealers"
        text content "50-1000 chars"
        text response "dealer/seller response"
        enum status "pending | approved | rejected"
        timestamp created_at
        timestamp updated_at
    }

    REPORTS {
        uuid id PK
        uuid reporter_id FK
        uuid listing_id FK "nullable"
        uuid reported_user_id FK "nullable"
        enum reason "fake_listing | wrong_info | stolen_vehicle | inappropriate | duplicate | scam | other"
        text description
        enum status "pending | reviewing | resolved | dismissed"
        text admin_notes
        uuid resolved_by FK "admin user_id"
        timestamp resolved_at
        timestamp created_at
    }

    INSPECTIONS {
        uuid id PK
        uuid listing_id FK
        uuid inspector_id FK "inspector user_id"
        uuid requested_by FK "user who booked"
        enum status "requested | scheduled | in_progress | completed | cancelled"
        timestamp scheduled_date
        varchar location
        int overall_score "0-100"
        text inspector_notes
        text recommendations
        enum result "pass | conditional_pass | fail"
        timestamp completed_at
        timestamp created_at
        timestamp updated_at
    }

    INSPECTION_ITEMS {
        uuid id PK
        uuid inspection_id FK
        varchar category "exterior | interior | engine | undercarriage | test_drive | documents"
        varchar item_name "e.g., paint_condition, brake_performance"
        enum rating "excellent | good | fair | poor | not_applicable"
        text notes
        varchar photo_url
    }

    VEHICLE_HISTORY {
        uuid id PK
        uuid listing_id FK
        int previous_owners
        boolean has_accident_history
        text accident_details
        jsonb service_records "array of {date, service, provider}"
        varchar import_country
        timestamp import_date
        decimal customs_value
        jsonb odometer_readings "array of {date, km, source}"
        timestamp created_at
        timestamp updated_at
    }

    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        enum type "message | offer | price_drop | saved_search | listing_expiry | moderation | verification | system | review"
        varchar title
        text body
        jsonb data "contextual data: listing_id, conversation_id, etc."
        varchar action_url "deep link path"
        boolean is_read
        timestamp read_at
        timestamp created_at
    }

    AUDIT_LOGS {
        uuid id PK
        uuid user_id FK "who performed the action"
        varchar action "user.ban | listing.approve | listing.reject | dealer.verify | etc."
        varchar entity_type "user | listing | dealer | review | report"
        uuid entity_id
        jsonb old_values
        jsonb new_values
        varchar ip_address
        varchar user_agent
        timestamp created_at
    }
```

### 7.3. Indexes

| Table | Index | Type | Columns | Purpose |
|-------|-------|------|---------|---------|
| `listings` | `idx_listings_search` | B-Tree | `(make, model, year, price)` | Primary search query optimization |
| `listings` | `idx_listings_status` | B-Tree | `(status, published_at DESC)` | Active listings feed |
| `listings` | `idx_listings_location` | B-Tree | `(city, sub_city)` | Location-based search |
| `listings` | `idx_listings_user` | B-Tree | `(user_id, status)` | User's own listings |
| `listings` | `idx_listings_dealer` | B-Tree | `(dealer_id, status)` | Dealer inventory |
| `listings` | `idx_listings_price` | B-Tree | `(price)` | Price range filtering |
| `listings` | `idx_listings_fulltext` | GIN | `to_tsvector(make || ' ' || model || ' ' || description)` | Full-text search |
| `messages` | `idx_messages_conversation` | B-Tree | `(conversation_id, created_at DESC)` | Chat message retrieval |
| `favorites` | `idx_favorites_user_listing` | Unique B-Tree | `(user_id, listing_id)` | Prevent duplicate favorites |
| `offers` | `idx_offers_listing` | B-Tree | `(listing_id, status)` | Offers on a listing |
| `notifications` | `idx_notifications_user` | B-Tree | `(user_id, is_read, created_at DESC)` | User notification feed |
| `listing_views` | `idx_views_listing_date` | B-Tree | `(listing_id, viewed_at)` | View analytics |
| `audit_logs` | `idx_audit_entity` | B-Tree | `(entity_type, entity_id)` | Audit trail lookup |

### 7.4. Row Level Security (RLS)

Supabase RLS policies are enforced at the database level as a defense-in-depth measure, even though the backend also performs authorization checks.

**Key Policies**:

```sql
-- Users can only read their own full profile; others see limited public info
CREATE POLICY "users_read_own" ON users FOR SELECT
  USING (auth.uid() = id OR role IN ('admin', 'moderator'));

-- Users can only update their own profile
CREATE POLICY "users_update_own" ON users FOR UPDATE
  USING (auth.uid() = id);

-- Anyone can read active listings
CREATE POLICY "listings_read_active" ON listings FOR SELECT
  USING (status = 'active' OR user_id = auth.uid());

-- Users can only modify their own listings
CREATE POLICY "listings_modify_own" ON listings FOR UPDATE
  USING (user_id = auth.uid());

CREATE POLICY "listings_delete_own" ON listings FOR DELETE
  USING (user_id = auth.uid());

-- Messages: only participants can read
CREATE POLICY "messages_read_participant" ON messages FOR SELECT
  USING (
    conversation_id IN (
      SELECT id FROM conversations
      WHERE buyer_id = auth.uid() OR seller_id = auth.uid()
    )
  );

-- Favorites: users manage their own
CREATE POLICY "favorites_own" ON favorites FOR ALL
  USING (user_id = auth.uid());

-- Reviews: anyone can read approved, users manage own pending
CREATE POLICY "reviews_read" ON reviews FOR SELECT
  USING (status = 'approved' OR reviewer_id = auth.uid());

-- Admin/Moderator override: full access
CREATE POLICY "admin_full_access" ON ALL TABLES FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM users WHERE id = auth.uid() AND role IN ('admin', 'super_admin')
    )
  );
```

### 7.5. Storage Buckets (Supabase Storage)

| Bucket | Access | Max File Size | Allowed MIME Types | Purpose |
|--------|--------|--------------|-------------------|---------|
| `listing-images` | Public read, authenticated write | 10 MB | `image/jpeg`, `image/png`, `image/webp` | Vehicle listing photos |
| `listing-videos` | Public read, authenticated write | 100 MB | `video/mp4`, `video/quicktime` | Vehicle walkthrough videos |
| `user-avatars` | Public read, authenticated write | 5 MB | `image/jpeg`, `image/png` | Profile pictures |
| `dealer-assets` | Public read, dealer write | 10 MB | `image/jpeg`, `image/png` | Logos, banners |
| `documents` | Private | 20 MB | `image/jpeg`, `image/png`, `application/pdf` | Vehicle registration, business licenses, KYC docs |
| `inspection-photos` | Private (inspector + admin + listing owner) | 10 MB | `image/jpeg`, `image/png` | Inspection evidence photos |

**File Naming Convention**: `{bucket}/{user_id}/{entity_id}/{uuid}.{ext}` — ensures unique, collision-free file paths.

---

## 8. Firebase Integration

### 8.1. Push Notifications (FCM)

**Implementation**:
- The Flutter app initializes Firebase and requests notification permission on first launch.
- The FCM token is sent to the backend and stored in the `user_devices` table.
- The backend sends notifications via the Firebase Admin SDK (`firebase-admin` npm package).
- Notifications include a `data` payload with `type`, `entityId`, and `actionUrl` for deep link navigation.

**Notification Categories (Android Channels)**:

| Channel ID | Name | Importance | Sound | Vibration |
|-----------|------|------------|-------|-----------|
| `messages` | Messages | High | Default | Yes |
| `offers` | Offers | High | Default | Yes |
| `alerts` | Price Alerts | Default | Default | No |
| `system` | System Updates | Low | None | No |

**iOS**: Notification categories with action buttons (e.g., "Reply" on message notifications, "View Offer" on offer notifications).

**Topic-Based Notifications**: Users subscribe to FCM topics for:
- `new_listings_{city}` — new listings in their city.
- `deals` — platform-wide promotional deals.
- `system_updates` — maintenance and feature announcements.

### 8.2. Analytics (Google Analytics for Firebase)

**Tracked Events**:

| Event Name | Parameters | Trigger |
|-----------|-----------|---------|
| `app_open` | `platform`, `version` | App launched |
| `login` | `method` (phone/email/google/apple) | Successful login |
| `sign_up` | `method` | New account created |
| `search` | `query`, `filters_applied`, `results_count` | Search executed |
| `view_listing` | `listing_id`, `make`, `model`, `source` | Listing detail opened |
| `create_listing` | `make`, `model`, `price` | Listing published |
| `add_to_favorites` | `listing_id` | Heart icon tapped |
| `send_message` | `conversation_id` | Chat message sent |
| `submit_offer` | `listing_id`, `amount` | Offer submitted |
| `share_listing` | `listing_id`, `method` (copy/whatsapp/telegram) | Listing shared |
| `click_contact` | `listing_id`, `contact_type` (chat/phone) | Contact button tapped |
| `purchase_promotion` | `listing_id`, `promotion_type`, `amount` | Promotion purchased |
| `apply_filter` | `filter_name`, `filter_value` | Search filter applied |
| `compare_vehicles` | `listing_ids` (array), `count` | Comparison initiated |
| `book_inspection` | `listing_id` | Inspection booked |
| `screen_view` | `screen_name` | Auto-tracked screen views |

**User Properties**: `user_type` (buyer/seller/dealer), `city`, `language`, `account_age_days`, `total_listings`, `is_verified`.

**Conversion Funnels**:
1. App Open → Search → View Listing → Contact Seller (Buyer funnel)
2. App Open → Create Listing → Publish → Receive Inquiry (Seller funnel)
3. View Listing → Favorite → Make Offer → Offer Accepted (Transaction funnel)

### 8.3. Crash Reporting (Firebase Crashlytics)

- **Automatic crash reporting** for unhandled exceptions in both Dart and native (Java/Kotlin/Swift/ObjC) layers.
- **Custom keys** attached to crash reports: `userId`, `userRole`, `screenName`, `lastAction`.
- **Non-fatal error reporting**: API errors, JSON parsing failures, and state machine violations are reported as non-fatal issues.
- **Breadcrumbs**: Key user actions (search, view listing, send message) are logged as breadcrumbs for crash context.
- **Release Health**: Track crash-free user percentage per release. Target: > 99.5% crash-free.

### 8.4. Performance Monitoring (Firebase Performance)

**Automatic Traces**:
- App startup time (cold start, warm start).
- Screen rendering performance (slow/frozen frames).
- HTTP request latency (per endpoint).

**Custom Traces**:

| Trace Name | What It Measures | Target |
|-----------|-----------------|--------|
| `listing_search` | Time from search submit to results rendered | < 1500ms |
| `listing_detail_load` | Time from tap on card to detail page fully rendered | < 800ms |
| `image_upload` | Time to upload a single listing image | < 3000ms |
| `chat_message_send` | Time from send tap to server acknowledgment | < 500ms |
| `ai_price_estimate` | Time to receive AI price estimation | < 2000ms |

---

## 9. Security

### 9.1. JWT Authentication

- **Access Token**: JWT, signed with RS256 (asymmetric keys), 15-minute expiry.
- **Refresh Token**: Opaque token (UUID v4), 30-day expiry, stored hashed in Redis.
- **Token Payload**:

```json
{
  "sub": "user-uuid",
  "role": "buyer",
  "iat": 1690000000,
  "exp": 1690000900,
  "iss": "ethiodrive-api",
  "aud": "ethiodrive-app"
}
```

- **Rotation**: Every refresh generates new access + refresh tokens. Old refresh token is invalidated (one-time use).
- **Revocation**: On logout, refresh token is deleted from Redis. On password change, ALL refresh tokens for that user are purged.
- **Blacklisting**: Compromised access tokens can be blacklisted in Redis (checked on every request).

### 9.2. OAuth 2.0 Integration

**Google OAuth**:
- Implemented via Firebase Auth.
- Scopes: `openid`, `email`, `profile`.
- On success, backend receives the Firebase ID token, verifies it, and either creates a new user or links to an existing account.

**Apple Sign-In**:
- Required for iOS App Store compliance.
- Scopes: `name`, `email`.
- Handles Apple's private relay email addresses.
- Name is only provided on first sign-in; backend must store it immediately.

### 9.3. Secure Storage

| Data | Storage Method | Platform |
|------|---------------|----------|
| Access Token | `flutter_secure_storage` (Keychain/Keystore) | Mobile |
| Refresh Token | `flutter_secure_storage` (Keychain/Keystore) | Mobile |
| Biometric Auth Flag | `flutter_secure_storage` | Mobile |
| Access Token | HttpOnly Secure cookie | Web |
| Refresh Token | HttpOnly Secure SameSite cookie | Web |
| User Preferences | Hive (encrypted box) | All |

### 9.4. Encryption

| Layer | Method | Details |
|-------|--------|---------|
| **In Transit** | TLS 1.3 | All API and WebSocket connections. HSTS header enforced. Certificate pinning on mobile apps. |
| **At Rest (DB)** | AES-256 | Supabase provides transparent disk encryption. Sensitive columns (SSN-equivalent, financial data) are application-level encrypted before storage. |
| **At Rest (Files)** | AES-256 | Supabase Storage encrypts at rest. Private buckets (documents, inspection photos) require signed URLs for access. |
| **At Rest (Device)** | Platform Keychain/Keystore | Tokens and secrets stored in OS-level secure storage. |
| **Chat Messages** | Transport encryption (TLS) | Messages are encrypted in transit. End-to-end encryption is a future roadmap item. |

### 9.5. Anti-Fraud System

See Section 4.16 (Fraud Prevention) for the complete specification of automated and manual fraud detection mechanisms.

**Additional Security Measures**:
- **CAPTCHA**: Invisible reCAPTCHA on registration and login forms (web) to prevent bot attacks.
- **Device Binding**: Suspicious activity (login from new device + immediate listing creation) triggers additional verification.
- **Velocity Checks**: Alerts on unusual activity spikes (e.g., user creates 20 listings in 1 hour).
- **IP Geolocation**: Flag logins from outside Ethiopia (with option for user to whitelist travel locations).
- **Content Scanning**: AI-powered text and image scanning for prohibited content.

### 9.6. Scam Detection

**Known Scam Patterns** (codified as detection rules):

| Pattern | Detection Method | Action |
|---------|-----------------|--------|
| "Send deposit to reserve vehicle" | NLP keyword matching | Auto-flag + warning to buyer |
| Price significantly below market | Statistical outlier detection | Require seller to confirm or adjust |
| Stock photos from internet | Reverse image search hash matching | Auto-flag for moderation |
| Same images on multiple listings by different users | Perceptual hash matching across all listings | Auto-flag + immediate manual review |
| Rapid account creation → immediate high-value listing | Behavioral sequencing rules | Require additional verification |
| Copy-paste descriptions across listings | Text similarity scoring (Jaccard/cosine) | Flag if similarity > 85% across different users |

### 9.7. Audit Logs

Every administrative and sensitive user action is logged in the `audit_logs` table:

- **Logged Actions**: User ban/unban, listing approve/reject, dealer verify/suspend, review remove, role change, subscription change, refund processing, system configuration change.
- **Logged Data**: Actor user ID, action name, target entity (type + ID), old values (JSON), new values (JSON), IP address, user agent, timestamp.
- **Retention**: Audit logs are retained for 7 years and are append-only (no updates or deletes).
- **Access**: Only `super_admin` role can view audit logs. Audit log access is itself logged.

### 9.8. Admin Moderation Tools

- **Content Queue**: Pending listings, reports, dealer applications, and document verifications displayed in a prioritized queue.
- **Quick Actions**: Approve, Reject (with reason template), Request More Info, Ban User, Suspend Dealer — all executable with 1–2 clicks.
- **Bulk Moderation**: Select multiple items and apply the same action.
- **Communication**: Send in-app notifications or email to users regarding moderation decisions.
- **Escalation**: Moderators can escalate complex cases to admin with notes.

---

## 10. AI Features

### 10.1. Vehicle Price Estimation

**Model**: Gradient Boosted Decision Trees (XGBoost) trained on Ethiopian market data.

**Input Features**:
- Make, Model, Year, Trim
- Mileage (km)
- Fuel Type, Transmission, Body Type
- Condition (New/Excellent/Good/Fair/Salvage)
- City/Region
- Current date (to account for seasonal trends and depreciation)
- Import country (Japanese imports vs. European vs. Middle Eastern)

**Output**: Estimated fair market price (ETB) with a confidence interval (e.g., ETB 3,200,000 – ETB 3,800,000, best estimate ETB 3,500,000).

**Training Data Sources**:
- Historical EthioDrive listing data (prices and whether the vehicle sold).
- Publicly available Ethiopian import data and customs valuations.
- Manual market research from major dealer lots in Addis Ababa.

**Model Retraining**: Monthly, using newly accumulated transaction data.

**Integration**: Displayed to sellers during listing creation ("Our AI suggests a price of ETB 3,500,000 for your vehicle"). Displayed to buyers on listing detail page ("AI Estimated Value: ETB 3,500,000 — This listing is priced 5% above market average").

### 10.2. Recommendation Engine

**Algorithm**: Hybrid approach combining:

1. **Collaborative Filtering**: Users who viewed/favorited similar vehicles to you also viewed these vehicles.
2. **Content-Based Filtering**: Vehicles with similar attributes (make, model, price range, body type) to your recently viewed/favorited vehicles.
3. **Popularity-Based**: Trending listings in the user's city (high view velocity).

**Recommendation Surfaces**:
- Home screen: "Recommended for You" carousel (personalized).
- Listing detail page: "Similar Vehicles" section (content-based).
- Search results: Re-ranking based on user preferences.
- Post-sale: "You might also like" after marking a listing as sold.

**Cold Start**: New users with no history see popularity-based recommendations. After 5+ listing views, the system begins personalizing.

### 10.3. Similar Vehicle Suggestions

On every listing detail page, a "Similar Vehicles" section shows 4–8 listings that are similar based on:

1. Same make + model (different year/price)
2. Same body type + similar price range (±20%)
3. Same year + similar mileage range
4. Vehicles from the same dealer (if dealer listing)

Sorted by a relevance score that weights similarity across these dimensions.

### 10.4. AI Search Assistant

Described in Section 4.6 and 4.7. Technical details:

- **LLM Provider**: OpenAI GPT-4 Turbo or Google Gemini Pro API.
- **RAG Pipeline**: User query → embedding via text-embedding-3-small → vector similarity search against listing embeddings stored in pgvector (PostgreSQL extension) → top-N relevant listings retrieved → LLM generates a conversational response summarizing findings and asking clarifying questions.
- **Guardrails**: The AI is restricted to automotive topics. Queries about non-car topics receive a polite redirect. No financial advice, no legal advice.
- **Latency Target**: First token streamed within 1 second. Complete response within 5 seconds.
- **Cost Management**: Token budgets per user (1000 tokens/query, 50 queries/day for free users, unlimited for dealers on Professional+ plans).

### 10.5. Fraud Detection AI

**Model**: Anomaly detection ensemble combining:
1. **Isolation Forest**: Detects pricing outliers.
2. **LSTM Neural Network**: Analyzes sequential user behavior patterns (login → list → edit → list → edit rapidly = suspicious).
3. **Image Classifier**: CNN trained to distinguish real vehicle photos from stock photos/screenshots.
4. **Text Classifier**: NLP model detecting scam language patterns in descriptions.

**Scoring**: Each listing receives a fraud risk score from 0 (legitimate) to 100 (highly suspicious). Listings scoring > 70 are auto-held for manual review. Users with 3+ flagged listings receive an elevated account-level fraud risk score.

---

## 11. Revenue Model

### 11.1. Featured Listings

| Tier | Placement | Duration | Price (ETB) |
|------|-----------|----------|-------------|
| **Highlight** | Colored border in search results | 7 days | 500 |
| **Top of Search** | Pinned to top of relevant search results | 3 days | 1,000 |
| **Featured** | Homepage hero carousel + Top of Search | 7 days | 2,500 |
| **Premium** | Featured + Social media promotion + Newsletter inclusion | 14 days | 5,000 |

### 11.2. Dealer Subscriptions

| Plan | Monthly (ETB) | Annual (ETB) | Listings | Features |
|------|--------------|-------------|----------|----------|
| **Basic** | 2,000 | 20,000 | Up to 25 active listings | Branded dealer page, basic analytics |
| **Professional** | 5,000 | 50,000 | Up to 100 active listings | All Basic + CRM, staff accounts (3), advanced analytics, priority support |
| **Enterprise** | 15,000 | 150,000 | Unlimited listings | All Professional + unlimited staff, API access, dedicated account manager, 10 free Featured promotions/month |

### 11.3. Advertisements

- **Native Ads**: Displayed in search results feed (1 ad per 10 listings), marked as "Sponsored". Advertisers: tire shops, car wash services, insurance companies, auto accessory stores.
- **Banner Ads**: Subtle banner at bottom of listing detail page. Non-intrusive, matches app design language.
- **Pricing**: CPM (cost per 1000 impressions) model. Target CPM: ETB 50–150 depending on placement.

### 11.4. Inspection Partnerships

- EthioDrive partners with certified mechanical workshops.
- Users book inspections through the app.
- Inspection fee paid by the user (e.g., ETB 2,000–5,000 depending on vehicle type).
- EthioDrive takes a 20% commission on each booked inspection.

### 11.5. Financing Partnerships

- Partner with banks (CBE, Dashen, Awash, Abyssinia) and MFIs for car loan referrals.
- Users apply for financing through the app (pre-qualification form).
- Leads are forwarded to partner institutions.
- EthioDrive receives a lead generation fee per qualified application (ETB 500–2,000 per lead).

---

## 12. Admin Dashboard

### 12.1. Dashboard Overview

The admin dashboard is a web application accessible at `admin.ethiodrive.com`. It provides a comprehensive view of platform health, user activity, and business metrics.

**Home Screen Widgets**:

| Widget | Data Shown | Refresh Rate |
|--------|-----------|-------------|
| Total Users | Count + growth % (vs. last month) | Real-time |
| Active Listings | Count + new today | Real-time |
| Messages Today | Total messages sent | Real-time |
| Revenue (MTD) | Sum of all revenue streams | Hourly |
| Moderation Queue | Pending items count | Real-time |
| Fraud Alerts | High-risk items count | Real-time |
| Top Searched Makes | Bar chart | Daily |
| User Growth Chart | Line chart (30-day trend) | Daily |
| Listing Growth Chart | Line chart (30-day trend) | Daily |
| Map View | Heatmap of listings by location | Daily |

### 12.2. User Management

| Action | Description |
|--------|-------------|
| View All Users | Paginated, searchable, filterable table (by role, status, registration date, city) |
| User Detail | Full profile view: personal info, listings, offers, messages (metadata only), reviews, reports filed/received, audit log, fraud risk score |
| Edit User | Change role, update email/phone, reset password |
| Verify User | Manually verify phone/email |
| Suspend User | Temporarily disable account with reason. User sees "Your account has been suspended" message. |
| Ban User | Permanently disable account. All active listings are unpublished. |
| Unban User | Restore previously banned account |
| Delete User | Permanently delete account and all associated data (irreversible, requires super_admin) |
| Impersonate | View the app as this user (read-only, for debugging — super_admin only) |

### 12.3. Dealer Management

| Action | Description |
|--------|-------------|
| Pending Applications | Queue of dealer applications awaiting review |
| Review Application | View all submitted documents, verify business license number against Ethiopian trade registry, approve or reject with reason |
| Active Dealers | List of all verified dealers with subscription status |
| Suspend Dealer | Disable dealer account (listings hidden but preserved) |
| Subscription Management | View/modify dealer subscription, apply credits |

### 12.4. Vehicle Moderation

| Action | Description |
|--------|-------------|
| Pending Review Queue | Listings submitted for review (sorted by submission date, flagged items first) |
| Approve Listing | Listing goes live immediately |
| Reject Listing | Listing returned to seller with rejection reason (template reasons + custom text) |
| Request Changes | Notify seller to update specific fields before re-submission |
| Flag as Suspicious | Mark for fraud team review without rejecting |
| Edit Listing | Admin can directly edit listing content (e.g., fix categorization errors) — logged in audit trail |
| Bulk Moderation | Select multiple listings → Approve All, Reject All |

### 12.5. Reports & Analytics

**Analytics Dashboards**:

| Dashboard | Metrics |
|-----------|---------|
| **User Analytics** | DAU/WAU/MAU, retention cohorts, registration funnel, churn rate, user demographics (city, device) |
| **Listing Analytics** | Total listings, listings by status, average listing lifetime, average time to sale, listings by category (make, body type, price range) |
| **Search Analytics** | Top search queries, zero-result queries, filter usage breakdown, search-to-view conversion |
| **Transaction Analytics** | Offers made/accepted/rejected, average negotiation rounds, average sale price vs. asking price |
| **Revenue Analytics** | MRR/ARR, revenue by stream (subscriptions, promotions, ads, inspections), ARPU, LTV |
| **Platform Health** | API response times, error rates, uptime, concurrent WebSocket connections |

**Export**: All analytics data exportable as CSV or PDF reports.

### 12.6. Revenue Management

- View all transactions (promotions, subscriptions, inspection bookings).
- Revenue breakdown by stream with date range filtering.
- Invoice generation for dealer subscriptions.
- Refund processing with reason and audit trail.

### 12.7. Notification Management

- **Broadcast Notifications**: Send push notifications to all users, specific user segments (by city, role, registration date), or individual users.
- **Scheduled Notifications**: Schedule notifications for future delivery (e.g., "Reminder: Your listing expires tomorrow").
- **Template Management**: Create and manage notification templates for common messages.

### 12.8. CMS (Content Management System)

- **Pages**: Edit Terms of Service, Privacy Policy, About Us, Help Center articles, FAQ.
- **Rich Text Editor**: WYSIWYG editor with formatting, image embedding, and multi-language support (English + Amharic).
- **Banners**: Create promotional banners for the app home screen (image + link + schedule).
- **Make/Model Database**: Manage the master list of vehicle makes, models, and trims used in dropdowns throughout the app.

---

## 13. API Documentation

Full interactive documentation is auto-generated and available at `https://api.ethiodrive.com/api/docs` via Swagger UI.

### 13.1. Authentication Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/v1/auth/register` | Public | Register new user |
| `POST` | `/api/v1/auth/login/phone` | Public | Login with phone + OTP |
| `POST` | `/api/v1/auth/login/email` | Public | Login with email + password |
| `POST` | `/api/v1/auth/login/google` | Public | Login with Google OAuth token |
| `POST` | `/api/v1/auth/login/apple` | Public | Login with Apple Sign-In token |
| `POST` | `/api/v1/auth/send-otp` | Public | Send OTP to phone number |
| `POST` | `/api/v1/auth/verify-otp` | Public | Verify OTP code |
| `POST` | `/api/v1/auth/refresh` | Public | Refresh access token |
| `POST` | `/api/v1/auth/logout` | Bearer | Logout (invalidate refresh token) |
| `POST` | `/api/v1/auth/forgot-password` | Public | Send password reset email |
| `POST` | `/api/v1/auth/reset-password` | Public | Reset password with token |

**Register — Request**:
```json
POST /api/v1/auth/register
{
  "phone": "+251912345678",
  "fullName": "Abebe Kebede",
  "language": "am"
}
```

**Register — Response (201)**:
```json
{
  "status": "success",
  "data": {
    "userId": "550e8400-e29b-41d4-a716-446655440000",
    "message": "OTP sent to +251912345678"
  }
}
```

**Login — Request**:
```json
POST /api/v1/auth/login/phone
{
  "phone": "+251912345678",
  "otp": "123456"
}
```

**Login — Response (200)**:
```json
{
  "status": "success",
  "data": {
    "user": {
      "id": "550e8400-e29b-41d4-a716-446655440000",
      "fullName": "Abebe Kebede",
      "phone": "+251912345678",
      "role": "buyer",
      "isProfileComplete": true,
      "avatarUrl": "https://storage.ethiodrive.com/avatars/550e.jpg"
    },
    "accessToken": "eyJhbGciOiJSUzI1NiIs...",
    "refreshToken": "d290f1ee-6c54-4b01-90e6-d701748f0851",
    "expiresIn": 900
  }
}
```

### 13.2. Listing Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/listings` | Bearer | Get listings (with filters, pagination) |
| `GET` | `/api/v1/listings/:id` | Bearer | Get listing detail |
| `POST` | `/api/v1/listings` | Bearer | Create a new listing |
| `PATCH` | `/api/v1/listings/:id` | Bearer (owner) | Update a listing |
| `DELETE` | `/api/v1/listings/:id` | Bearer (owner) | Delete a listing |
| `PATCH` | `/api/v1/listings/:id/status` | Bearer (owner) | Change listing status (pause, activate, mark sold) |
| `POST` | `/api/v1/listings/:id/promote` | Bearer (owner) | Purchase a promotion |
| `GET` | `/api/v1/listings/:id/similar` | Bearer | Get similar listings |
| `GET` | `/api/v1/listings/:id/analytics` | Bearer (owner) | Get listing performance analytics |
| `POST` | `/api/v1/listings/:id/report` | Bearer | Report a listing |

**Get Listings — Request**:
```http
GET /api/v1/listings?make=Toyota&model=Corolla&yearMin=2018&yearMax=2024&priceMin=2000000&priceMax=5000000&transmission=automatic&fuelType=petrol&condition=excellent,good&city=Addis%20Ababa&sort=price_asc&page=1&limit=20
Authorization: Bearer eyJhbGciOi...
```

**Get Listings — Response (200)**:
```json
{
  "status": "success",
  "data": {
    "items": [
      {
        "id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
        "make": "Toyota",
        "model": "Corolla",
        "trim": "LE",
        "year": 2022,
        "price": 3500000,
        "currency": "ETB",
        "isNegotiable": true,
        "mileageKm": 45000,
        "fuelType": "petrol",
        "transmission": "automatic",
        "bodyType": "sedan",
        "condition": "excellent",
        "exteriorColor": "Silver",
        "city": "Addis Ababa",
        "subCity": "Bole",
        "verificationLevel": "documents_verified",
        "viewCount": 342,
        "favoriteCount": 28,
        "primaryImage": {
          "url": "https://storage.ethiodrive.com/listing-images/a1b2/img1.webp",
          "thumbnailUrl": "https://storage.ethiodrive.com/listing-images/a1b2/img1_thumb.webp"
        },
        "imageCount": 12,
        "hasVideo": true,
        "aiEstimatedPrice": 3400000,
        "seller": {
          "id": "user-uuid",
          "fullName": "Abebe K.",
          "avatarUrl": "...",
          "isDealer": false,
          "rating": 4.5,
          "reviewCount": 12
        },
        "publishedAt": "2026-07-15T10:30:00Z",
        "createdAt": "2026-07-15T10:00:00Z"
      }
    ]
  },
  "meta": {
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 47,
      "pages": 3
    }
  }
}
```

**Create Listing — Request**:
```json
POST /api/v1/listings
Authorization: Bearer eyJhbGciOi...
{
  "make": "Toyota",
  "model": "Corolla",
  "trim": "LE",
  "year": 2022,
  "price": 3500000,
  "isNegotiable": true,
  "acceptsTradeIn": false,
  "mileageKm": 45000,
  "fuelType": "petrol",
  "transmission": "automatic",
  "bodyType": "sedan",
  "drivetrain": "fwd",
  "engineSizeCc": 1800,
  "cylinders": 4,
  "exteriorColor": "Silver",
  "interiorColor": "Black",
  "seats": 5,
  "doors": 4,
  "condition": "excellent",
  "description": "Well-maintained 2022 Toyota Corolla LE. Single owner, full service history at Toyota Ethiopia authorized service center. No accidents. Recently serviced with new brake pads and tires. Non-smoker vehicle.",
  "features": ["abs", "airbags", "ac", "power_windows", "bluetooth", "backup_camera", "cruise_control"],
  "city": "Addis Ababa",
  "subCity": "Bole",
  "latitude": 8.9806,
  "longitude": 38.7578,
  "imageUrls": [
    "https://storage.ethiodrive.com/listing-images/temp/img1.jpg",
    "https://storage.ethiodrive.com/listing-images/temp/img2.jpg",
    "https://storage.ethiodrive.com/listing-images/temp/img3.jpg",
    "https://storage.ethiodrive.com/listing-images/temp/img4.jpg",
    "https://storage.ethiodrive.com/listing-images/temp/img5.jpg"
  ],
  "videoUrl": "https://storage.ethiodrive.com/listing-videos/temp/walkthrough.mp4"
}
```

**Create Listing — Response (201)**:
```json
{
  "status": "success",
  "data": {
    "id": "new-listing-uuid",
    "status": "pending_review",
    "aiEstimatedPrice": 3400000,
    "message": "Your listing has been submitted for review. It will be live within 24 hours."
  }
}
```

### 13.3. Search Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/search` | Bearer | Standard filtered search |
| `POST` | `/api/v1/search/ai` | Bearer | AI natural language search |
| `GET` | `/api/v1/search/suggestions` | Bearer | Auto-complete suggestions |
| `GET` | `/api/v1/search/saved` | Bearer | Get user's saved searches |
| `POST` | `/api/v1/search/saved` | Bearer | Save a search |
| `DELETE` | `/api/v1/search/saved/:id` | Bearer | Delete a saved search |

**AI Search — Request**:
```json
POST /api/v1/search/ai
Authorization: Bearer eyJhbGciOi...
{
  "query": "Family SUV under 4 million birr, automatic, Japanese make, low mileage",
  "page": 1,
  "limit": 20
}
```

**AI Search — Response (200)**:
```json
{
  "status": "success",
  "data": {
    "aiSummary": "I found 23 Japanese SUVs under ETB 4,000,000 with automatic transmission. The best options include Toyota RAV4 and Honda CR-V models from 2019-2023. Here are the top results sorted by relevance:",
    "extractedFilters": {
      "bodyType": "suv",
      "priceMax": 4000000,
      "transmission": "automatic",
      "make": ["Toyota", "Honda", "Nissan", "Mitsubishi", "Suzuki", "Subaru", "Mazda"],
      "mileageMax": 80000
    },
    "items": [ ... ],
    "followUpSuggestions": [
      "Show me only Toyota RAV4 options",
      "Increase budget to 5 million",
      "Include hybrid options"
    ]
  },
  "meta": { "pagination": { ... } }
}
```

### 13.4. Chat Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/conversations` | Bearer | Get all user conversations |
| `GET` | `/api/v1/conversations/:id` | Bearer (participant) | Get conversation detail with messages |
| `POST` | `/api/v1/conversations` | Bearer | Start a new conversation |
| `GET` | `/api/v1/conversations/:id/messages` | Bearer (participant) | Get messages (paginated, newest first) |
| `POST` | `/api/v1/conversations/:id/messages` | Bearer (participant) | Send a message (also via WebSocket) |
| `PATCH` | `/api/v1/conversations/:id/read` | Bearer (participant) | Mark all messages as read |
| `PATCH` | `/api/v1/conversations/:id/archive` | Bearer (participant) | Archive conversation |
| `POST` | `/api/v1/conversations/:id/block` | Bearer (participant) | Block the other user |

### 13.5. Offer Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/offers` | Bearer | Get all user's offers (as buyer and seller) |
| `POST` | `/api/v1/offers` | Bearer | Submit an offer |
| `PATCH` | `/api/v1/offers/:id/accept` | Bearer (seller) | Accept an offer |
| `PATCH` | `/api/v1/offers/:id/reject` | Bearer (seller) | Reject an offer |
| `PATCH` | `/api/v1/offers/:id/counter` | Bearer (seller) | Counter an offer |
| `PATCH` | `/api/v1/offers/:id/withdraw` | Bearer (buyer) | Withdraw an offer |

### 13.6. User & Profile Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/users/me` | Bearer | Get current user profile |
| `PATCH` | `/api/v1/users/me` | Bearer | Update profile |
| `POST` | `/api/v1/users/me/avatar` | Bearer | Upload avatar |
| `GET` | `/api/v1/users/:id/public` | Bearer | Get another user's public profile |
| `GET` | `/api/v1/users/me/favorites` | Bearer | Get favorites list |
| `POST` | `/api/v1/users/me/favorites` | Bearer | Add to favorites |
| `DELETE` | `/api/v1/users/me/favorites/:listingId` | Bearer | Remove from favorites |
| `GET` | `/api/v1/users/me/notifications` | Bearer | Get notifications |
| `PATCH` | `/api/v1/users/me/notifications/read-all` | Bearer | Mark all notifications read |

### 13.7. Dealer Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/v1/dealers/apply` | Bearer | Submit dealer application |
| `GET` | `/api/v1/dealers/:slug` | Public | Get dealer public page |
| `GET` | `/api/v1/dealers/:slug/listings` | Public | Get dealer's listings |
| `GET` | `/api/v1/dealers/:slug/reviews` | Public | Get dealer's reviews |
| `PATCH` | `/api/v1/dealers/me` | Bearer (dealer) | Update dealer profile |
| `GET` | `/api/v1/dealers/me/leads` | Bearer (dealer) | Get CRM leads |
| `GET` | `/api/v1/dealers/me/analytics` | Bearer (dealer) | Get dealer analytics |
| `POST` | `/api/v1/dealers/me/staff` | Bearer (dealer owner) | Invite staff member |
| `DELETE` | `/api/v1/dealers/me/staff/:userId` | Bearer (dealer owner) | Remove staff member |
| `POST` | `/api/v1/dealers/me/bulk-upload` | Bearer (dealer) | Bulk import listings |

### 13.8. Review Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/reviews/user/:userId` | Public | Get reviews for a user |
| `POST` | `/api/v1/reviews` | Bearer | Submit a review |
| `POST` | `/api/v1/reviews/:id/respond` | Bearer (reviewee) | Respond to a review |

### 13.9. Inspection Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/v1/inspections` | Bearer | Book an inspection |
| `GET` | `/api/v1/inspections/:id` | Bearer | Get inspection details and report |
| `PATCH` | `/api/v1/inspections/:id` | Bearer (inspector) | Update inspection (submit report) |

### 13.10. AI Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/v1/ai/price-estimate` | Bearer | Get AI price estimation |
| `GET` | `/api/v1/ai/recommendations` | Bearer | Get personalized recommendations |
| `POST` | `/api/v1/ai/chat` | Bearer | Send message to AI assistant |

### 13.11. Admin Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `GET` | `/api/v1/admin/dashboard` | Bearer (admin) | Dashboard metrics |
| `GET` | `/api/v1/admin/users` | Bearer (admin) | List all users |
| `PATCH` | `/api/v1/admin/users/:id/status` | Bearer (admin) | Change user status |
| `PATCH` | `/api/v1/admin/users/:id/role` | Bearer (super_admin) | Change user role |
| `GET` | `/api/v1/admin/listings/pending` | Bearer (moderator) | Get moderation queue |
| `PATCH` | `/api/v1/admin/listings/:id/moderate` | Bearer (moderator) | Approve/reject listing |
| `GET` | `/api/v1/admin/dealers/pending` | Bearer (admin) | Get pending dealer applications |
| `PATCH` | `/api/v1/admin/dealers/:id/verify` | Bearer (admin) | Approve/reject dealer |
| `GET` | `/api/v1/admin/reports` | Bearer (moderator) | Get reports queue |
| `PATCH` | `/api/v1/admin/reports/:id/resolve` | Bearer (moderator) | Resolve a report |
| `GET` | `/api/v1/admin/analytics/:type` | Bearer (admin) | Get analytics data |
| `GET` | `/api/v1/admin/audit-logs` | Bearer (super_admin) | Get audit logs |
| `POST` | `/api/v1/admin/notifications/broadcast` | Bearer (admin) | Send broadcast notification |

### 13.12. Upload Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| `POST` | `/api/v1/upload/image` | Bearer | Upload a single image |
| `POST` | `/api/v1/upload/images` | Bearer | Upload multiple images (batch) |
| `POST` | `/api/v1/upload/video` | Bearer | Upload a video |
| `POST` | `/api/v1/upload/document` | Bearer | Upload a private document |
| `DELETE` | `/api/v1/upload/:fileId` | Bearer (owner) | Delete an uploaded file |

### 13.13. Error Codes Reference

| HTTP Code | Error Code | Description |
|-----------|-----------|-------------|
| 400 | `VALIDATION_ERROR` | Request body/params validation failed |
| 400 | `BAD_REQUEST` | General bad request |
| 401 | `UNAUTHORIZED` | Missing or invalid authentication |
| 401 | `TOKEN_EXPIRED` | Access token has expired |
| 401 | `INVALID_OTP` | OTP code is incorrect or expired |
| 403 | `FORBIDDEN` | Authenticated but insufficient permissions |
| 403 | `ACCOUNT_SUSPENDED` | User account is suspended |
| 403 | `ACCOUNT_BANNED` | User account is banned |
| 404 | `NOT_FOUND` | Requested resource not found |
| 409 | `CONFLICT` | Duplicate resource (e.g., email already registered) |
| 413 | `FILE_TOO_LARGE` | Uploaded file exceeds size limit |
| 415 | `UNSUPPORTED_MEDIA` | Uploaded file type not allowed |
| 422 | `UNPROCESSABLE` | Request understood but cannot be processed |
| 429 | `RATE_LIMITED` | Too many requests |
| 500 | `INTERNAL_ERROR` | Unexpected server error |
| 503 | `SERVICE_UNAVAILABLE` | Server temporarily unavailable (maintenance) |

---

## 14. Scalability

### 14.1. Architecture for Millions of Users

```mermaid
graph TB
    subgraph "Client Layer"
        A[Flutter Mobile Apps]
        B[Flutter Web / PWA]
        C[Admin Dashboard]
    end

    subgraph "CDN / Edge"
        D[Cloudflare CDN]
    end

    subgraph "Load Balancer"
        E[AWS ALB / Nginx]
    end

    subgraph "Application Layer (Auto-Scaling)"
        F1[API Server 1]
        F2[API Server 2]
        F3[API Server N]
    end

    subgraph "WebSocket Layer"
        G1[Socket Server 1]
        G2[Socket Server N]
    end

    subgraph "Background Workers"
        H1[Image Processing Worker]
        H2[Notification Worker]
        H3[AI Inference Worker]
        H4[Analytics Worker]
    end

    subgraph "Data Layer"
        I[PostgreSQL Primary]
        J[PostgreSQL Read Replica]
        K[Redis Cluster]
        L[Supabase Storage / S3]
    end

    subgraph "External Services"
        M[Firebase]
        N[OpenAI / Gemini API]
        O[Google Maps API]
        P[SMS Gateway]
    end

    A --> D
    B --> D
    C --> D
    D --> E
    E --> F1
    E --> F2
    E --> F3
    E --> G1
    E --> G2
    F1 --> I
    F1 --> J
    F1 --> K
    F2 --> I
    F2 --> J
    F2 --> K
    G1 --> K
    G2 --> K
    H1 --> L
    H2 --> M
    H3 --> N
```

### 14.2. Load Balancing

- **AWS Application Load Balancer** distributes HTTP/HTTPS traffic across API server instances.
- **Sticky Sessions**: Disabled for REST API (stateless). Enabled for WebSocket connections (using Redis adapter for Socket.io allows any server to handle any user's messages).
- **Health Checks**: ALB pings `/api/v1/health` every 30 seconds. Unhealthy instances (2 consecutive failures) are removed from rotation.

### 14.3. Caching Strategy

| Cache Layer | Technology | Cached Data | TTL |
|------------|-----------|-------------|-----|
| **CDN Cache** | Cloudflare | Static assets (JS, CSS, images), public listing images | 24 hours |
| **API Response Cache** | Redis | Popular search results, listing detail, public dealer pages | 5–60 min |
| **Session Cache** | Redis | JWT blacklist, refresh token hashes, rate limit counters | Varies |
| **Database Query Cache** | Redis | Frequently accessed aggregations (make counts, city counts) | 15 min |
| **Client Cache** | Hive/Isar | Viewed listings, user profile, favorites, chat messages | Until change |

**Cache Invalidation**: Write-through strategy — when data is modified, the corresponding cache key is invalidated immediately. Pub/Sub (Redis) propagates invalidation across all API server instances.

### 14.4. Horizontal Scaling

- **API Servers**: Stateless NestJS instances in Docker containers, managed by AWS ECS with auto-scaling rules:
  - Scale out: CPU > 70% for 5 minutes → add instance.
  - Scale in: CPU < 30% for 15 minutes → remove instance.
  - Min instances: 2 (production), Max instances: 20.
- **WebSocket Servers**: Socket.io with Redis adapter enables horizontal scaling. Each server subscribes to Redis pub/sub for cross-instance message delivery.
- **Background Workers**: Bull queue workers scale independently based on queue depth.
- **Database**: Read replicas for read-heavy queries (search, listings feed). Connection pooling via PgBouncer.

### 14.5. Disaster Recovery

| Component | Strategy | RPO | RTO |
|-----------|----------|-----|-----|
| **Database** | Multi-AZ PostgreSQL with automated failover. Daily snapshots. Point-in-time recovery (PITR). | 0 (synchronous replication) | < 5 minutes |
| **File Storage** | S3 cross-region replication (or Supabase redundancy) | < 1 hour | < 1 hour |
| **Redis** | Redis Cluster with automatic failover | ~ 1 second | < 30 seconds |
| **Application** | Multi-AZ deployment. Auto-scaling replaces failed instances. | N/A | < 2 minutes |
| **DNS** | Cloudflare with automatic failover | N/A | < 1 minute |

**Backup Schedule**:
- Database: Continuous WAL archiving + daily full snapshots. Retained for 30 days.
- File Storage: Cross-region replication (real-time) + daily inventory report.
- Configuration: Infrastructure-as-Code (Terraform) stored in Git. Full environment reproducible from code.

---

## 15. Deployment & Infrastructure

### 15.1. CI/CD Pipeline

```mermaid
graph LR
    A[Developer Push] --> B[GitHub Actions Triggered]
    B --> C{Branch?}
    C -->|feature/*| D[Lint + Unit Tests]
    C -->|develop| E[Lint + Unit + Integration Tests]
    C -->|main| F[Full Test Suite + Build + Deploy]
    D --> G[PR Status Check]
    E --> H[Build Docker Image]
    H --> I[Deploy to Staging]
    I --> J[Smoke Tests on Staging]
    F --> K[Build All Platforms]
    K --> L[Deploy Backend to Production]
    K --> M[Deploy Web to Production]
    K --> N[Upload Android to Play Console]
    K --> O[Upload iOS to App Store Connect]
```

**GitHub Actions Workflows**:

1. **`ci.yml`** (runs on every PR):
   - Lint Dart code (`dart analyze`)
   - Lint TypeScript code (`eslint`)
   - Run Flutter unit tests
   - Run NestJS unit tests
   - Check code formatting (`dart format`, `prettier`)
   - Check for security vulnerabilities (`npm audit`, `flutter pub outdated`)

2. **`deploy-staging.yml`** (runs on push to `develop`):
   - All CI checks
   - Build Docker images for backend
   - Push to container registry (ECR)
   - Deploy to staging environment (ECS)
   - Run integration tests against staging
   - Build Flutter web and deploy to staging URL
   - Notify team on Slack

3. **`deploy-production.yml`** (runs on push to `main`, requires manual approval):
   - All CI checks
   - Build production Docker images
   - Deploy backend to production (Blue/Green)
   - Deploy web to production
   - Build Flutter Android APK + App Bundle
   - Build Flutter iOS IPA
   - Upload to Google Play Console (internal testing track)
   - Upload to App Store Connect (TestFlight)
   - Run smoke tests against production
   - Tag release in Git
   - Generate changelog
   - Notify team on Slack

### 15.2. Docker Configuration

**Backend Dockerfile**:
```dockerfile
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM node:20-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
EXPOSE 3000
CMD ["node", "dist/main.js"]
```

**docker-compose.yml** (local development):
```yaml
version: '3.8'
services:
  api:
    build: ./server
    ports:
      - "3000:3000"
    env_file: ./server/.env
    depends_on:
      - postgres
      - redis
    volumes:
      - ./server/src:/app/src

  postgres:
    image: postgres:15-alpine
    ports:
      - "5432:5432"
    environment:
      POSTGRES_DB: ethiodrive
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - pgdata:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  pgdata:
```

### 15.3. Environment Configuration

| Environment | Backend URL | Web URL | Database | Purpose |
|------------|------------|---------|----------|---------|
| **Development** | `http://localhost:3000` | `http://localhost:8080` | Local PostgreSQL | Individual developer machines |
| **Staging** | `https://api.staging.ethiodrive.com` | `https://staging.ethiodrive.com` | Supabase Staging Project | Integration testing, QA, client demos |
| **Production** | `https://api.ethiodrive.com` | `https://ethiodrive.com` | Supabase Production Project | Live users |

**Environment Variables** (`.env` template):

```env
# Server
NODE_ENV=production
PORT=3000
API_VERSION=v1

# Database
DATABASE_URL=postgresql://user:pass@host:5432/ethiodrive

# Redis
REDIS_URL=redis://host:6379

# JWT
JWT_ACCESS_SECRET=<RSA_PRIVATE_KEY>
JWT_ACCESS_EXPIRY=15m
JWT_REFRESH_EXPIRY=30d

# Firebase
FIREBASE_PROJECT_ID=ethiodrive-prod
FIREBASE_SERVICE_ACCOUNT_KEY=<base64_encoded_key>

# Supabase
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_ROLE_KEY=<key>

# Google
GOOGLE_MAPS_API_KEY=<key>
GOOGLE_OAUTH_CLIENT_ID=<id>
GOOGLE_OAUTH_CLIENT_SECRET=<secret>

# AI
OPENAI_API_KEY=<key>

# SMS
SMS_PROVIDER=africastalking
SMS_API_KEY=<key>
SMS_SENDER_ID=EthioDrive

# Email
SENDGRID_API_KEY=<key>
EMAIL_FROM=noreply@ethiodrive.com

# Storage
STORAGE_BUCKET_URL=https://xxx.supabase.co/storage/v1

# App
APP_URL=https://ethiodrive.com
ADMIN_URL=https://admin.ethiodrive.com
```

### 15.4. Platform Build & Distribution

#### Android
- **Build**: `flutter build appbundle --release` for Google Play, `flutter build apk --release --split-per-abi` for direct APK.
- **Signing**: Release signing keystore stored securely in CI secrets. Never committed to Git.
- **Distribution**: Google Play Console — Internal Testing → Closed Testing → Open Testing → Production.
- **Update Strategy**: In-app update check via Play Core library. Force update for breaking API changes.

#### iOS
- **Build**: `flutter build ipa --release` via Xcode archive.
- **Signing**: Apple Distribution certificates and provisioning profiles managed via Fastlane Match (stored in private Git repo).
- **Distribution**: App Store Connect — TestFlight (internal) → TestFlight (external) → App Store Review → Production.
- **Update Strategy**: Check latest version via App Store lookup API. Prompt update dialog.

#### Web
- **Build**: `flutter build web --release --web-renderer canvaskit` for best quality.
- **PWA**: `manifest.json` configured for installability. Service Worker caches static assets.
- **Hosting**: Firebase Hosting or Vercel with custom domain `ethiodrive.com`.
- **SSL**: Auto-managed SSL certificates via hosting provider.

#### Desktop (Windows, macOS, Linux)
- **Build**: `flutter build windows --release`, `flutter build macos --release`, `flutter build linux --release`.
- **Packaging**: MSIX (Windows), DMG (macOS), AppImage/Snap (Linux).
- **Distribution**: Initially via direct download from `ethiodrive.com/download`. Later, Microsoft Store and Mac App Store.
- **Auto-Update**: Custom update checker that queries the backend for latest version and download URL.

### 15.5. Domain & SSL Configuration

| Domain | Purpose | SSL Provider |
|--------|---------|-------------|
| `ethiodrive.com` | Main web app + PWA | Cloudflare (auto-renewed) |
| `api.ethiodrive.com` | Backend API | Cloudflare (auto-renewed) |
| `admin.ethiodrive.com` | Admin dashboard | Cloudflare (auto-renewed) |
| `storage.ethiodrive.com` | CNAME to Supabase Storage | Cloudflare |
| `staging.ethiodrive.com` | Staging web | Cloudflare |
| `api.staging.ethiodrive.com` | Staging API | Cloudflare |

**DNS Configuration**: Managed via Cloudflare. A/AAAA records for root domain, CNAME records for subdomains. CAA records restricting certificate issuance.

### 15.6. CDN for Images

- **Provider**: Cloudflare CDN (or AWS CloudFront).
- **Caching Rules**: Listing images cached at edge for 7 days. Cache-Control: `public, max-age=604800, immutable`. Images are served with content-based ETags.
- **Image Optimization**: On-the-fly WebP conversion and resizing via Cloudflare Polish or a Cloudflare Worker.
- **Global Distribution**: Edge servers in Nairobi (closest to Ethiopia), plus global PoPs for international access.

### 15.7. Monitoring, Logging & Alerting

| Tool | Purpose | Setup |
|------|---------|-------|
| **Prometheus** | Infrastructure metrics (CPU, memory, disk, network) | Sidecar containers in ECS tasks |
| **Grafana** | Dashboards and visualization | Self-hosted or Grafana Cloud |
| **Winston + Logtail** | Application logs (structured JSON) | Log drain from ECS to Logtail/Datadog |
| **Firebase Crashlytics** | Mobile app crash reporting | Firebase SDK in Flutter app |
| **Firebase Performance** | Mobile app performance traces | Firebase SDK in Flutter app |
| **UptimeRobot / Pingdom** | Uptime monitoring | HTTP checks every 1 minute |
| **PagerDuty / OpsGenie** | Alert routing and on-call management | Integrated with Prometheus alerts |

**Alert Rules**:

| Alert | Condition | Severity | Action |
|-------|-----------|----------|--------|
| API Down | Health check fails for > 2 min | Critical | PagerDuty + SMS to on-call |
| High Error Rate | 5xx rate > 5% for 5 min | Critical | PagerDuty |
| High Latency | p95 latency > 3s for 10 min | Warning | Slack notification |
| High CPU | CPU > 85% for 10 min | Warning | Slack + auto-scale |
| Database Connection Pool Exhaustion | Active connections > 80% of pool | Warning | Slack |
| Disk Space Low | < 20% free | Warning | Slack |
| Certificate Expiry | SSL cert expires in < 14 days | Warning | Email to engineering |

---

## 16. Release Management

### 16.1. Versioning Strategy

**Semantic Versioning (SemVer)**: `MAJOR.MINOR.PATCH`

- **MAJOR** (e.g., 1.0.0 → 2.0.0): Breaking changes — incompatible API changes, major UI redesign, database schema changes requiring migration.
- **MINOR** (e.g., 1.0.0 → 1.1.0): New features — backward-compatible feature additions.
- **PATCH** (e.g., 1.0.0 → 1.0.1): Bug fixes — backward-compatible bug fixes and minor improvements.

**Build Number**: Auto-incremented integer for each platform build (e.g., `1.2.3+45`). Used for store version codes.

**Version Sync**: Backend API, Flutter app, and Admin Dashboard each have independent version numbers, but the Flutter app includes a `minApiVersion` check to ensure compatibility.

### 16.2. App Update Process

| Scenario | Update Type | User Experience |
|----------|------------|-----------------|
| Critical security fix | **Force Update** | Full-screen blocking dialog: "A critical update is required. Please update to continue." Only option: "Update Now" (opens store). |
| Breaking API change | **Force Update** | Same as above. App cannot function without update. |
| New features | **Flexible Update** | Non-blocking bottom sheet: "A new version is available with exciting features!" Options: "Update Now" or "Later". Shown once per session. |
| Bug fixes | **Flexible Update** | Subtle banner at top of home screen: "Update available." Dismissible. |
| No update needed | **Silent** | Nothing shown. |

**Implementation**: Backend `/api/v1/config/app-version` endpoint returns `{ latestVersion, minRequiredVersion, updateUrl, releaseNotes }`. Flutter app checks on launch and periodically.

### 16.3. Database Migrations

- **Tool**: Prisma Migrate (`prisma migrate deploy`).
- **Process**: Migrations are auto-generated from schema changes, reviewed in PR, and run as part of the CI/CD deploy pipeline (before new app code is deployed).
- **Rollback**: Each migration has a corresponding rollback script. For critical failures, `prisma migrate resolve` can mark a migration as rolled back.
- **Zero-Downtime Migrations**: All schema changes must be backward-compatible (additive). Column drops and renames are performed in 3 phases:
  1. Add new column, deploy code that writes to both.
  2. Migrate data from old to new column.
  3. Drop old column after all clients have updated.

### 16.4. Rollback Strategy

- **Blue/Green Deployment**: Two identical production environments (Blue and Green). New version deploys to the inactive environment. Traffic is switched via load balancer. If issues are detected, traffic is switched back to the previous environment instantly.
- **Canary Releases**: For high-risk changes, route 5% of traffic to the new version. Monitor error rates and latency. If healthy after 30 minutes, gradually increase to 100%. If unhealthy, route all traffic back to the old version.
- **Feature Flags**: LaunchDarkly or custom feature flag service to enable/disable features without redeployment. New features are wrapped in feature flags and enabled gradually.
- **Database Rollback**: Prisma rollback scripts for recent migrations. For catastrophic failures, restore from point-in-time backup.

---

## 17. Development Roadmap

### Phase 1: MVP (Months 1–3)

**Goal**: Launch a functional marketplace with core buyer/seller features on Android and iOS.

| Sprint | Deliverables |
|--------|-------------|
| 1–2 | Project setup: Flutter project, NestJS project, database schema, CI/CD, design system implementation |
| 3–4 | Auth: Phone OTP registration/login, Google OAuth, profile creation |
| 5–6 | Listings: Create listing wizard, listing detail page, image upload |
| 7–8 | Search: Text search, filters, sort, pagination |
| 9–10 | Chat: 1:1 messaging, WebSocket real-time delivery |
| 11–12 | Favorites, Notifications (push + in-app), basic seller analytics |
| 13–14 | Admin: Basic moderation dashboard (approve/reject listings) |
| 15–16 | QA, bug fixes, App Store / Play Store submission, soft launch |

**MVP Feature Scope**: Auth (phone + Google), listing CRUD, search with filters, 1:1 chat, favorites, push notifications, basic admin moderation.

### Phase 2: Premium Features (Months 4–6)

| Sprint | Deliverables |
|--------|-------------|
| 17–18 | Offer system (submit, accept, reject, counter) |
| 19–20 | Dealer accounts (application, branded pages, bulk upload) |
| 21–22 | Reviews & ratings system |
| 23–24 | AI price estimation (v1 model trained and deployed) |
| 25–26 | Web version (Flutter Web + PWA) |
| 27–28 | Desktop apps (Windows + macOS) |
| 29–30 | Payment integration for featured listings |
| 31–32 | Enhanced admin dashboard (analytics, user management) |

### Phase 3: Scale & Trust (Months 7–9)

| Sprint | Deliverables |
|--------|-------------|
| 33–34 | Vehicle verification system (document upload + admin review) |
| 35–36 | Inspection workflow (booking, digital checklist, mechanic app) |
| 37–38 | Fraud detection AI (automated flagging, scam pattern detection) |
| 39–40 | AI search assistant (natural language search, chatbot) |
| 41–42 | Vehicle comparison tool |
| 43–44 | Recommendation engine (personalized home feed) |
| 45–46 | Dealer CRM (leads, staff accounts, advanced analytics) |
| 47–48 | Linux desktop app, tablet-optimized layouts, Amharic localization |

### Phase 4: Future Expansion (Months 10+)

| Feature | Timeline | Description |
|---------|----------|-------------|
| Financing integration | Month 10–11 | Partner with banks for in-app loan pre-qualification |
| Vehicle history reports | Month 11–12 | Integration with service center databases |
| Spare parts marketplace | Month 12–14 | Separate marketplace vertical for auto parts |
| Insurance comparison | Month 14–15 | Compare and purchase vehicle insurance in-app |
| 360° vehicle tours | Month 15–16 | AR-enhanced vehicle walkthroughs |
| Regional expansion | Month 16–18 | Expand to Kenya, Tanzania, Uganda with localized versions |
| End-to-end encryption | Month 18–20 | E2E encrypted chat messages |
| Blockchain vehicle records | Month 20+ | Immutable vehicle history on blockchain |

---

## 18. Coding Standards

### 18.1. Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| **Dart files** | `snake_case` | `listing_detail_page.dart`, `auth_repository.dart` |
| **Dart classes** | `PascalCase` | `VehicleListing`, `AuthBloc`, `CreateListingUseCase` |
| **Dart variables/functions** | `camelCase` | `getUserProfile()`, `isVerified`, `priceInEtb` |
| **Dart constants** | `camelCase` (prefixed with `k` for global) | `kDefaultPageSize`, `kMaxImageUpload` |
| **Dart enums** | `PascalCase` (type), `camelCase` (values) | `FuelType.petrol`, `ListingStatus.active` |
| **Dart private members** | `_camelCase` | `_isLoading`, `_handleSubmit()` |
| **TypeScript files** | `kebab-case` | `listing.controller.ts`, `create-listing.dto.ts` |
| **TypeScript classes** | `PascalCase` | `ListingsController`, `AuthService` |
| **TypeScript variables/functions** | `camelCase` | `getUserById()`, `isAuthenticated` |
| **TypeScript interfaces** | `PascalCase` (no `I` prefix) | `UserProfile`, `ListingFilter` |
| **TypeScript enums** | `PascalCase` (type), `UPPER_SNAKE_CASE` (values) | `UserRole.ADMIN`, `ListingStatus.ACTIVE` |
| **Database tables** | `snake_case` (plural) | `users`, `listings`, `listing_images` |
| **Database columns** | `snake_case` | `user_id`, `created_at`, `is_verified` |
| **API endpoints** | `kebab-case` | `/api/v1/saved-searches`, `/api/v1/listing-images` |
| **Environment variables** | `UPPER_SNAKE_CASE` | `DATABASE_URL`, `JWT_ACCESS_SECRET` |
| **CSS/Design tokens** | `--kebab-case` | `--color-gold-primary`, `--space-4` |
| **Git branches** | `type/description` | `feature/listing-search`, `bugfix/chat-scroll` |

### 18.2. Folder Conventions

- **Feature-first**: Every feature has its own directory under `lib/features/` (Flutter) and `src/modules/` (NestJS).
- **No cross-feature imports**: Features must not import directly from other features. Shared code lives in `core/`.
- **Barrel files**: Each feature directory exports its public API through a barrel file (`index.ts` in NestJS, not used in Flutter due to convention).
- **Colocation**: Tests live next to the code they test (`*.spec.ts` for NestJS, `*_test.dart` for Flutter in a mirrored `test/` directory).

### 18.3. Git Workflow

**Branching Model**: GitFlow

```mermaid
gitgraph
    commit id: "Initial"
    branch develop
    checkout develop
    commit id: "Setup"
    branch feature/auth
    checkout feature/auth
    commit id: "Auth UI"
    commit id: "Auth Logic"
    checkout develop
    merge feature/auth id: "Merge Auth"
    branch feature/listings
    checkout feature/listings
    commit id: "Listings"
    checkout develop
    merge feature/listings id: "Merge Listings"
    checkout main
    merge develop id: "Release 1.0.0" tag: "v1.0.0"
    branch hotfix/crash-fix
    checkout hotfix/crash-fix
    commit id: "Fix crash"
    checkout main
    merge hotfix/crash-fix id: "v1.0.1" tag: "v1.0.1"
    checkout develop
    merge hotfix/crash-fix id: "Sync hotfix"
```

**Branch Types**:

| Branch | Source | Target | Purpose |
|--------|--------|--------|---------|
| `main` | — | — | Production-ready code. Every commit is a release. |
| `develop` | `main` | `main` | Integration branch. All features merge here first. |
| `feature/*` | `develop` | `develop` | New features. One branch per feature. |
| `bugfix/*` | `develop` | `develop` | Bug fixes for upcoming release. |
| `hotfix/*` | `main` | `main` + `develop` | Critical production fixes. |
| `release/*` | `develop` | `main` + `develop` | Release preparation (version bump, changelog). |

**Pull Request Rules**:
- Every PR requires at least 1 code review approval.
- All CI checks must pass (lint, test, build).
- PR title must follow Conventional Commits format.
- PR description must include: What changed, Why it changed, How to test.
- Squash merge to `develop`. Merge commit to `main`.

### 18.4. Commit Message Standards

**Format**: [Conventional Commits](https://www.conventionalcommits.org/)

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Code style (formatting, semicolons) — no logic change |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `build` | Build system or dependency changes |
| `ci` | CI/CD configuration changes |
| `chore` | Maintenance tasks (deps update, tooling) |

**Scope**: Feature module name (`auth`, `listings`, `chat`, `search`, `admin`, `infra`).

**Examples**:
```
feat(listings): add 360-degree image viewer to listing detail

Implemented an interactive 360-degree spin viewer for listings that
include a full set of 36 rotational images. Falls back to standard
gallery when insufficient images are available.

Closes #234
```

```
fix(chat): prevent duplicate message delivery on reconnect

WebSocket reconnection was replaying the last 5 messages due to
missing deduplication. Added message ID tracking in the local
database to filter already-received messages.

Fixes #189
```

### 18.5. Documentation Standards

**Code Comments**:
- **DO** comment complex business logic, non-obvious algorithms, and workarounds.
- **DO NOT** comment self-explanatory code (e.g., `// increment counter` above `counter++`).
- **TODO comments** must include the author's name and a linked issue: `// TODO(abebe): Implement retry logic — #345`.

**DartDoc** (Flutter):
```dart
/// Fetches a paginated list of vehicle listings matching the given [filter].
///
/// Returns [Right] with the list of [VehicleListing] on success,
/// or [Left] with a [Failure] on error.
///
/// The results are sorted according to [filter.sortBy] and paginated
/// with [filter.page] and [filter.limit].
///
/// Throws no exceptions — all errors are captured in the [Either] return.
Future<Either<Failure, List<VehicleListing>>> getListings(ListingFilter filter);
```

**JSDoc** (NestJS):
```typescript
/**
 * Creates a new vehicle listing.
 *
 * @param userId - The authenticated user's ID
 * @param dto - The listing creation data
 * @returns The created listing with generated ID and AI price estimate
 * @throws ConflictException if a duplicate listing is detected
 * @throws ForbiddenException if user has exceeded their listing limit
 */
async createListing(userId: string, dto: CreateListingDto): Promise<Listing> { ... }
```

**API Documentation**: All endpoints are documented via Swagger decorators in NestJS controllers. Swagger UI is the single source of truth for API consumers.

**Architecture Decision Records (ADRs)**: Significant technical decisions are recorded in `/docs/adr/` using the format:
```
# ADR-001: Use BLoC for State Management

## Status: Accepted

## Context
We need a state management solution for the Flutter app that supports...

## Decision
We will use the `flutter_bloc` package because...

## Consequences
- Positive: ...
- Negative: ...
```

---

<div align="center">

**Built with ❤️ for the Ethiopian automotive community.**

*© 2026 EthioDrive. All rights reserved.*

</div>
