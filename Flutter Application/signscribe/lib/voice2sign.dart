import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:signscribe/utils/colors.dart';
class VoiceToSign extends StatefulWidget {
  const VoiceToSign({super.key});

  @override
  State<VoiceToSign> createState() => _VoiceToSignState();
}

class _VoiceToSignState extends State<VoiceToSign> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
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
          tag: 'back4',
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
          "Realtime Voice to Sign",
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.w600,
            color: mainColor,
          ),
        ),
      ),
      backgroundColor: secondaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse('https://vtos.netlify.app/')),
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
                      isLoading = false;
                    });
                  },
                ),
                if (isLoading)
                  Container(
                    color: secondaryColor,
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
