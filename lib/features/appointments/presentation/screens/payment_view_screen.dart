import 'package:flutter/material.dart';
import 'package:lavender/core/routing/router.dart';
import 'package:lavender/core/themes/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewScreen extends StatefulWidget {
  final String paymentUrl;

  const PaymentViewScreen({super.key, required this.paymentUrl});

  @override
  State<PaymentViewScreen> createState() => _PaymentViewScreenState();
}

class _PaymentViewScreenState extends State<PaymentViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    final params = const PlatformWebViewControllerCreationParams();
    final controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("فشل تحميل صفحة الدفع")),
            );
          },
          onUrlChange: (UrlChange change) {
            final url = change.url ?? '';
            if (url.contains('success')) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.paymentSuccess,
                    (route) => false,
              );
            } else if (url.contains('cancel')) {
              Navigator.of(context).pop();
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("إتمام الدفع")),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: AppColors.primaryColorLavenderLangAndText,)),
        ],
      ),
    );
  }
}