import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:signscribe/utils/colors.dart';
import 'package:signscribe/settings.dart';
import 'package:provider/provider.dart';

class SignToVoice extends StatefulWidget {
  const SignToVoice({super.key});

  @override
  State<SignToVoice> createState() => _SignToVoiceState();
}

class _SignToVoiceState extends State<SignToVoice> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    TextModel textModel = Provider.of<TextProvider>(context).textModel;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: whiteColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: secondaryColor,
          automaticallyImplyLeading: true,
          leading: Hero(
            tag: 'back2',
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: mainColor,
              ),
            ),
          ),
          title: const Text(
            "Realtime Sign To Voice",
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.w600,
              color: mainColor,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  // InAppWebView for the content
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(textModel.text)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        mediaPlaybackRequiresUserGesture: false,
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {},
                    androidOnPermissionRequest: (InAppWebViewController controller, String origin, List<String> resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    onLoadStart: (InAppWebViewController controller, Uri? uri) {
                      setState(() {
                        isLoading = true;
                      });
                    },
                    onLoadStop: (InAppWebViewController controller, Uri? uri) {
                      setState(() {
                        isLoading = false; // Hide loading screen
                      });
                    },
                  ),
                  // Splash screen or any other widget as a loading indicator
                  if (isLoading)
                    Container(
                      color: secondaryColor, // Background color for the splash screen
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loading...",
                              style: TextStyle(
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: mainColor,
                              ),
                            ),
                            SizedBox(height: 10,),
                            CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
