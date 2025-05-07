// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bossloot_mobile/services/coin_exchange_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoinExchangeProvider extends ChangeNotifier {
  final CoinExchangeService _coinExchangeService;
  
  Map<String, double> _exchangeRates = {};
  String _selectedCurrency = 'EUR';
  
  String? _error;
  
  CoinExchangeProvider(this._coinExchangeService);

  // Getters
  Map<String, double> get exchangeRates => _exchangeRates;
  String get selectedCurrency => _selectedCurrency;
  String? get error => _error;
  
  // Initialize the provider by loading saved currency and exchange rates
  // It will be called at LoadingScreen
  Future<void> initialize() async {
    await _loadSelectedCurrency();
    await _loadSavedRates();
    await fetchExchangeRates();
  }
  
  // Load the selected currency from SharedPreferences
  // It will be called through the initialize method
  Future<void> _loadSelectedCurrency() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      if (prefs.containsKey('selectedCurrency')) {
        _selectedCurrency = prefs.getString('selectedCurrency')!;
        notifyListeners();
      } else {
        await prefs.setString('selectedCurrency', _selectedCurrency);
      }
    } catch (e) {
      _error = 'Error loading currency settings: $e';
      notifyListeners();
    }
  }

  // Load saved exchange rates from SharedPreferences
  // It will be called through the initialize method
  Future<void> _loadSavedRates() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedRates = prefs.getString('exchangeRates');
      
      if (savedRates != null) {
        final Map<String, dynamic> ratesMap = jsonDecode(savedRates);
        _exchangeRates = ratesMap.map((key, value) => MapEntry(key, value.toDouble()));
        notifyListeners();
      }
    } catch (e) {
      _error = 'Error loading saved exchange rates: $e';
      notifyListeners();
    }
  }
  
  // Obtain the exchange rates from the API only if they haven't been fetched today
  // It will be called through the initialize method
  Future<void> fetchExchangeRates() async {
    final prefs = await SharedPreferences.getInstance();
    final lastFetchDate = prefs.getString('lastFetchDate');
    final today = DateTime.now();

    if (lastFetchDate != null) {
      final lastFetch = DateTime.parse(lastFetchDate);
      if (lastFetch.year == today.year &&
        lastFetch.month == today.month &&
        lastFetch.day == today.day) {
        print('Rates already fetched today, no need to fetch again.');
        return;
      }
    }

    print('Rates not feched today, fetching new rates...');
    await prefs.setString('lastFetchDate', today.toIso8601String());

    try {
      // Get exchange rates from the service
      _exchangeRates = await _coinExchangeService.fetchExchangeRates('EUR');
      
      // Save rates to SharedPreferences
      final ratesJson = jsonEncode(_exchangeRates);
      await prefs.setString('exchangeRates', ratesJson);
      
      notifyListeners();
    } catch (e) {
      _error = 'Error fetching exchange rates: $e';
      notifyListeners();
    }
  }
  
  // Change the selected currency and fetch new exchange rates if necessary
  // It will be called at LoadingScreen and SettingsScreen
  Future<void> setSelectedCurrency(String currency) async {
    if (_selectedCurrency == currency) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selectedCurrency', currency);
      _selectedCurrency = currency;
      
      notifyListeners();
    } catch (e) {
      _error = 'Error swapping coin: $e';
      notifyListeners();
    }
  }
  
  // Convert the price from EUR to the selected currency
  // It will be called at CatalogProductCard, SpotlightProductCard, FavoriteScreen product tiles, OrdersScreen product tiles and CartScreen product tiles
  double convertPrice(double priceInEUR) {
    if (_selectedCurrency == 'EUR' || _exchangeRates.isEmpty) {
      return priceInEUR;
    }
    
    final rate = _exchangeRates[_selectedCurrency] ?? 1.0;
    return priceInEUR * rate;
  }
  
  // Format the price according to the selected currency
  String formatPrice(double price) {
    final formatter = NumberFormat.currency(
      symbol: _getCurrencySymbol(_selectedCurrency),
      decimalDigits: 2,
    );
    return formatter.format(price);
  }
  
  // Obtain the currency symbol based on the currency code
  String _getCurrencySymbol(String currencyCode) {
    switch (currencyCode) {
      case 'EUR': return '€';
      case 'USD': return '\$';
      case 'GBP': return '£';
      case 'JPY': return '¥';
      default: return currencyCode;
    }
  }
}