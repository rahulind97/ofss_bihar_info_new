import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ofss_bihar_info/constants/constants.dart';
import 'package:ofss_bihar_info/services/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
class CafPrintScreen extends StatefulWidget {
  final String token;

  const CafPrintScreen({
    super.key,
    required this.token,
  });

  @override
  State<CafPrintScreen> createState() => _CafPrintScreenState();
}

class _CafPrintScreenState extends State<CafPrintScreen> {
  WebViewController? _controller;

  bool isLoading = true;
  String? errorMessage;

  double zoomLevel = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _getCafHtml();
  }

  Future<void> _getCafHtml() async {
    debugPrint('========== CAF API START ==========');

    try {
      final apiUrl = '${URL}print/caf';

      debugPrint('1. API URL: $apiUrl');
      debugPrint('2. Token exists: ${widget.token.isNotEmpty}');
      debugPrint(
        '3. Token preview: ${widget.token.length > 20
            ? '${widget.token.substring(0, 20)}...'
            : widget.token}',
      );

      // Make sure Authorization contains Bearer only once
      String token = widget.token.trim();

      if (!token.toLowerCase().startsWith('bearer ')) {
        token = 'Bearer $token';
      }

      debugPrint(
        '4. Authorization preview: '
            '${token.length > 27 ? '${token.substring(0, 27)}...' : token}',
      );

      debugPrint('5. Sending HTTP GET request...');

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': token,
          'Accept': 'text/html',
        },
      );

      debugPrint('6. API request completed');
      debugPrint('7. Status Code: ${response.statusCode}');
      debugPrint('8. Response Headers: ${response.headers}');
      debugPrint('9. Response Bytes: ${response.bodyBytes.length}');

      // Decode response as UTF-8.
      // Important for Hindi/Unicode characters.
      final html = utf8.decode(
        response.bodyBytes,
        allowMalformed: true,
      );

      debugPrint('10. HTML Length: ${html.length}');

      // Don't print complete HTML if it is large
      debugPrint(
        '11. Response Preview: '
            '${html.length > 500
            ? html.substring(0, 500)
            : html}',
      );

      if (response.statusCode == 200) {
        debugPrint('12. Status is 200 - HTML received');

        // Check if Hindi/Unicode exists in response
        debugPrint(
          '13. Contains Hindi characters: '
              '${RegExp(r'[\u0900-\u097F]').hasMatch(html)}',
        );

        debugPrint('14. Loading HTML into WebView...');

        await _controller!.loadHtmlString(
          html,
          baseUrl: 'https://testofss2027.ofssbihar.net/',
        );

        debugPrint('15. HTML successfully loaded into WebView');

        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }

        debugPrint('16. Loading completed successfully');
      } else {
        debugPrint(
          'ERROR: API returned status code ${response.statusCode}',
        );

        debugPrint('ERROR Response Body: $html');

        if (mounted) {
          setState(() {
            isLoading = false;
            errorMessage =
            'Failed to load CAF.\n'
                'Status Code: ${response.statusCode}\n'
                'Response: $html';
          });
        }
      }
    } catch (e, stackTrace) {
      debugPrint('========== CAF API ERROR ==========');
      debugPrint('ERROR TYPE: ${e.runtimeType}');
      debugPrint('ERROR MESSAGE: $e');
      debugPrint('STACK TRACE:');
      debugPrint('$stackTrace');
      debugPrint('===================================');

      if (mounted) {
        setState(() {
          isLoading = false;
          errorMessage = e.toString();
        });
      }
    }

    debugPrint('========== CAF API END ==========');
  }


  Future<void> _zoomIn() async {
    zoomLevel += 0.1;

    await _controller!.runJavaScript(
      '''
      document.body.style.zoom = "$zoomLevel";
      ''',
    );

    setState(() {});
  }

  Future<void> _zoomOut() async {
    if (zoomLevel <= 0.5) return;

    zoomLevel -= 0.1;

    await _controller!.runJavaScript(
      '''
      document.body.style.zoom = "$zoomLevel";
      ''',
    );

    setState(() {});
  }

  Future<void> _resetZoom() async {
    zoomLevel = 1.0;

    await _controller!.runJavaScript(
      '''
      document.body.style.zoom = "1.0";
      ''',
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8B0000),

        title: const Text('CAF',style: TextStyle(color:  Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Zoom Out',
            onPressed: isLoading ? null : _zoomOut,
            icon: const Icon(Icons.zoom_out,color: Colors.white,),
          ),

          IconButton(
            tooltip: 'Reset Zoom',
            onPressed: isLoading ? null : _resetZoom,
            icon: const Icon(Icons.zoom_in_map,color:  Colors.white,),
          ),

          IconButton(
            tooltip: 'Zoom In',
            onPressed: isLoading ? null : _zoomIn,
            icon: const Icon(Icons.zoom_in,color:  Colors.white),
          ),
        ],
      ),

      body: Stack(
        children: [
          if (_controller != null && errorMessage == null)
            WebViewWidget(
              controller: _controller!,
            ),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          if (errorMessage != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 50,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                          errorMessage = null;
                        });

                        _getCafHtml();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}