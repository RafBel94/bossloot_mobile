// lib/screens/paypal_payment_screen.dart
// ignore_for_file: use_build_context_synchronously

import 'package:bossloot_mobile/providers/paypal/paypal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayPalPaymentScreen extends StatefulWidget {
  final int orderId;

  const PayPalPaymentScreen({required this.orderId});

  @override
  _PayPalPaymentScreenState createState() => _PayPalPaymentScreenState();
}

class _PayPalPaymentScreenState extends State<PayPalPaymentScreen> {
  bool _isLoading = true;
  bool _isCreatingOrder = true;
  bool _isProcessingPayment = false;
  String? _error;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _initPayPalOrder();
  }

  Future<void> _initPayPalOrder() async {
    try {
      final paypalProvider = Provider.of<PayPalProvider>(context, listen: false);
      
      setState(() {
        _isCreatingOrder = true;
        _error = null;
      });
      
      final success = await paypalProvider.createPayPalOrder(widget.orderId);
      
      if (!success) {
        setState(() {
          _error = paypalProvider.error ?? 'Failed to create PayPal order';
          _isCreatingOrder = false;
        });
      } else {
        if (paypalProvider.approvalUrl != null) {
          _initWebView(paypalProvider.approvalUrl!);
        } else {
          setState(() {
            _error = 'No approval URL available';
          });
        }
        setState(() {
          _isCreatingOrder = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isCreatingOrder = false;
      });
    }
  }

  void _initWebView(String url) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            _handlePayPalRedirect(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            _handlePayPalRedirect(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    final paypalProvider = Provider.of<PayPalProvider>(context);
    
    return WillPopScope(
      onWillPop: () async {
        if (_isProcessingPayment) return false;
        
        final shouldExit = await _showExitConfirmDialog();
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('PayPal Payment'),
          leading: _isProcessingPayment 
              ? Container() 
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    final shouldExit = await _showExitConfirmDialog();
                    if (shouldExit == true) {
                      Navigator.pop(context, false);
                    }
                  },
                ),
        ),
        body: _buildBody(paypalProvider),
      ),
    );
  }

  Widget _buildBody(PayPalProvider paypalProvider) {
    if (_isCreatingOrder) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Preparing your payment...'),
          ],
        ),
      );
    }
    
    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              SizedBox(height: 16),
              Text(
                'Payment Error',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Go Back'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          ),
        ),
      );
    }
    
    if (paypalProvider.approvalUrl == null || _controller == null) {
      return Center(
        child: Text('No payment URL available'),
      );
    }
    
    return Stack(
      children: [
        WebViewWidget(controller: _controller!),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        if (_isProcessingPayment)
          Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'Processing your payment...',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Please do not close this screen',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _handlePayPalRedirect(String url) async {
    // Success URL (the one you configured in the backend)
    if (url.contains('/paypal/success') && !_isProcessingPayment) {
      setState(() {
        _isProcessingPayment = true;
      });
      
      try {
        // Extract the token from the URL
        Uri uri = Uri.parse(url);
        String? token = uri.queryParameters['token'];
        
        if (token != null) {
          // Capture the payment
          final paypalProvider = Provider.of<PayPalProvider>(context, listen: false);
          bool success = await paypalProvider.capturePayment(token);
          
          if (success) {
            Navigator.pop(context, true);
          } else {
            setState(() {
              _isProcessingPayment = false;
              _error = paypalProvider.error ?? 'Payment capture failed';
            });
          }
        } else {
          setState(() {
            _isProcessingPayment = false;
            _error = 'Invalid payment response from PayPal';
          });
        }
      } catch (e) {
        setState(() {
          _isProcessingPayment = false;
          _error = e.toString();
        });
      }
    }
    
    // Cancel URL
    else if (url.contains('/paypal/cancel') && !_isProcessingPayment) {
      Navigator.pop(context, false);
    }
  }

  Future<bool?> _showExitConfirmDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Cancel Payment?'),
        content: Text('If you leave this screen, your payment will be cancelled. Are you sure?'),
        actions: [
          TextButton(
            child: Text('No, Stay'),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          TextButton(
            child: Text(
              'Yes, Cancel',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );
  }
}