class ListingModel {
  final String id;
  final String make;
  final String model;
  final int year;
  final double price;
  final int mileage;
  final String transmission;
  final String fuelType;
  final String bodyType;
  final String condition;
  final String location;
  final List<String> images;
  final bool isVerified;
  final bool isFeatured;
  final String sellerName;
  final String sellerId;
  final String description;
  final DateTime createdAt;

  const ListingModel({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    required this.mileage,
    required this.transmission,
    required this.fuelType,
    required this.bodyType,
    required this.condition,
    required this.location,
    required this.images,
    required this.isVerified,
    required this.isFeatured,
    required this.sellerName,
    required this.sellerId,
    required this.description,
    required this.createdAt,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    return ListingModel(
      id: json['id'] ?? '',
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      year: json['year'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      mileage: json['mileage'] ?? 0,
      transmission: json['transmission'] ?? '',
      fuelType: json['fuelType'] ?? '',
      bodyType: json['bodyType'] ?? '',
      condition: json['condition'] ?? '',
      location: json['location'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      isVerified: json['isVerified'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      sellerName: json['sellerName'] ?? '',
      sellerId: json['sellerId'] ?? '',
      description: json['description'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

// Mock data for development
final mockListings = [
  ListingModel(
    id: '1', make: 'Toyota', model: 'Corolla', year: 2022,
    price: 3500000, mileage: 45000, transmission: 'Automatic',
    fuelType: 'Petrol', bodyType: 'Sedan', condition: 'Excellent',
    location: 'Addis Ababa, Bole', images: [],
    isVerified: true, isFeatured: true,
    sellerName: 'Abebe Kebede', sellerId: 'u1',
    description: 'Well-maintained Toyota Corolla in excellent condition.',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ListingModel(
    id: '2', make: 'Hyundai', model: 'Tucson', year: 2021,
    price: 4800000, mileage: 32000, transmission: 'Automatic',
    fuelType: 'Diesel', bodyType: 'SUV', condition: 'Excellent',
    location: 'Addis Ababa, Kazanchis', images: [],
    isVerified: true, isFeatured: false,
    sellerName: 'Tigist Alemu', sellerId: 'u2',
    description: 'Hyundai Tucson, single owner, full service history.',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  ListingModel(
    id: '3', make: 'Toyota', model: 'Land Cruiser', year: 2019,
    price: 9200000, mileage: 78000, transmission: 'Automatic',
    fuelType: 'Diesel', bodyType: 'SUV', condition: 'Good',
    location: 'Addis Ababa, CMC', images: [],
    isVerified: false, isFeatured: false,
    sellerName: 'Yonas Haile', sellerId: 'u3',
    description: 'Toyota Land Cruiser V8, powerful and reliable.',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
  ),
  ListingModel(
    id: '4', make: 'Honda', model: 'Civic', year: 2020,
    price: 2900000, mileage: 55000, transmission: 'Manual',
    fuelType: 'Petrol', bodyType: 'Sedan', condition: 'Good',
    location: 'Addis Ababa, Piassa', images: [],
    isVerified: true, isFeatured: false,
    sellerName: 'Sara Bekele', sellerId: 'u4',
    description: 'Honda Civic, fuel efficient and sporty.',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
  ),
];
