import 'package:find_construction/screens/videos_show.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  static const id = "about_us_screen";

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: Center(
        child:
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebView(

                  key:  _key,
                  initialUrl: 'https://construction.bazaaaar.com/about_us.php',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (finish){
                    setState(() {
                      isLoading= false;
                    });
                  }
              ),
            ) ,isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        )
      ),
    );
  }
}
