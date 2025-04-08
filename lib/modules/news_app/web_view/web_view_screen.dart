import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;

  const WebViewScreen(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller =
        WebViewController()..loadRequest(Uri.parse(url));
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setNavigationDelegate(
    //   // NavigationDelegate(
    //   //   onProgress: (int progress) {},
    //   //   onPageStarted: (String url) {},
    //   //   onPageFinished: (String url) {},
    //   //   onHttpError: (HttpResponseError error) {},
    //   //   onWebResourceError: (WebResourceError error) {},
    //   // ),
    // )
    return Scaffold(
      appBar: AppBar(title: const Text('News Details')),
      body: WebViewWidget(controller: controller),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class WebViewScreen extends StatelessWidget {
//   const WebViewScreen({super.key});

//   final String url;
//   WebViewScreen(this.url)
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(), 
//       body: WebView(initialUrl: url),
//       );
//   }
// }
