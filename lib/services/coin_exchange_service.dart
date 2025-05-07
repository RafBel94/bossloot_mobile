import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CoinExchangeService {

  String apiKey = dotenv.get('COIN_EXCHANGE_API_KEY');

  // Get exchange rates from a base currency to all available currencies
  Future<Map<String, double>> fetchExchangeRates(String baseCurrency) async {
    final String apiURL = 'https://v6.exchangerate-api.com/v6/$apiKey/latest/$baseCurrency';

    try {
      final response = await http.get(Uri.parse(apiURL));
      
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        
        // Convert the conversion_rates to the correct type
        Map<String, double> exchangeRates = {};
        data['conversion_rates'].forEach((key, value) {
          exchangeRates[key] = value.toDouble();
        });
        
        return exchangeRates;
      } else {
        throw Exception('Error al cargar tasas de cambio: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}