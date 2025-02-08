import '../../core/models/api_response.dart';
import '../../core/network/dio_client.dart';
import '../../domain/entities/stock.dart';
import '../../domain/repositories/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final DioClient dioClient;

  StockRepositoryImpl({required this.dioClient});

  @override
  Future<ApiResponse<List<Stock>>> getStocks() async {
    try {
      final response = await dioClient.dio.get('/stocks');
      final List<dynamic> data = response.data['data'];
      final stocks = data.map((json) => Stock.fromJson(json)).toList();
      return ApiResponse.success(stocks);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<Stock>> getStockBySymbol(String symbol) async {
    try {
      final response = await dioClient.dio.get('/stocks/$symbol');
      final stock = Stock.fromJson(response.data['data']);
      return ApiResponse.success(stock);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
} 