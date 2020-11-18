import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HelpCenterScreen extends StatefulWidget {
  static const id = "help_center_screen";
  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help center"),),
      body: Center(
        child:
        Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WebView(

                      key:  _key,
                      initialUrl: 'https://construction.bazaaaar.com/help_center.php',
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
      ),
    );
  }
}
