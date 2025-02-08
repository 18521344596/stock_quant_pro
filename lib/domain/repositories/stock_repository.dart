import '../../core/models/api_response.dart';
import '../entities/stock.dart';

abstract class StockRepository {
  Future<ApiResponse<List<Stock>>> getStocks();
  Future<ApiResponse<Stock>> getStockBySymbol(String symbol);
} 