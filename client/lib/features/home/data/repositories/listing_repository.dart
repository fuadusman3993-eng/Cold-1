import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../listing/domain/models/listing_model.dart';

class ListingRepository {
  final ApiClient apiClient;

  ListingRepository(this.apiClient);

  Future<List<ListingModel>> getListings({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await apiClient.dio.get('/listings', queryParameters: queryParams);
      if (response.data['status'] == 'success') {
        final List data = response.data['data'];
        return data.map((e) => ListingModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch listings: $e');
    }
  }

  Future<List<ListingModel>> getFeaturedListings() async {
    try {
      final response = await apiClient.dio.get('/listings/featured');
      if (response.data['status'] == 'success') {
        final List data = response.data['data'];
        return data.map((e) => ListingModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch featured listings: $e');
    }
  }
}
