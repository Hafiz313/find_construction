import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:find_construction/models/detail_house_models.dart'
    as houseDetail;
import 'package:find_construction/screens/home_Screen.dart';
import 'package:find_construction/screens/videos_show.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class DetailScreen extends StatefulWidget {
  static const id = "detail_screen";
  final String cID;

  const DetailScreen({Key key, this.cID}) : super(key: key);

  /*final Response response;
  const DetailScreen({Key key, this.response}) : super(key: key);*/

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  TabController _tabController;
  bool isLoading = true;
  houseDetail.DetailHouseModel _detailHouseModel;
  List<Marker> _markers = <Marker>[];
  List<int> list = [1, 2, 3, 4, 5];
  ChewieController _chewieController;

  _textMe() async {
    // Android
    const uri = 'sms:?body=here%20link:www.google.com';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      const uri = 'sms:?body=here%20link:www.google.com';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  Future<houseDetail.DetailHouseModel> getDetailHouse(String cID) async {
    final String apiUrl = "https://construction.bazaaaar.com/singleRecord.php";
    final response = await http.post(apiUrl, body: {"id": cID});
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(
          "-----------favorite response : ${response.body}--------------------");
      setState(() {
        _detailHouseModel =
            houseDetail.detailHouseModelFromJson(responseString);
        isLoading = false;
      });
      _markers.add(
        Marker(
            // ignore: deprecated_member_use
            icon: BitmapDescriptor.fromAsset("images/home_marker.png"),
            markerId: MarkerId('SomeId'),
            position: LatLng(
                double.parse(_detailHouseModel.response.latitude),
                double.parse(_detailHouseModel.response.longtitude)),
            infoWindow: InfoWindow(title: 'The title of the marker')),
      );
      return houseDetail.detailHouseModelFromJson(responseString);
    } else {
      setState(() {
        isLoading = false;
      });
      return null;
    }
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);


    super.initState();
    getDetailHouse(widget.cID);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            child: Center(
              child: SpinKitDualRing(
                color: kBlueText,
                size: 50.0,
              ),
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Email',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          color: kButtonBG,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            _launchURL('${_detailHouseModel.response.email}',
                                ' Email Test', 'Hello ');
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.phoneAlt,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Call',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          color: kButtonBG,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            launch(
                                ('tel://${_detailHouseModel.response.phone}'));
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FlatButton(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.shareAlt,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          color: kButtonBG,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            _textMe();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: 300,
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                          CarouselSlider.builder(
                            itemCount:
                                _detailHouseModel.response.icon.length,
                            options: CarouselOptions(
                              height: 300.0,
                              viewportFraction: 1.0,
                              aspectRatio: 2.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Center(
                                    child: Image.network(
                                        _detailHouseModel
                                            .response.icon[index],
                                        fit: BoxFit.cover,
                                        width: 1000)),
                              );
                            },
                          ),
                              Align(alignment: Alignment.topLeft, child:Container(
                                margin: EdgeInsets.all(25),
                                child: CircleButton(
                                    onTap: (){
                                      Navigator.pushReplacementNamed(context,HomeScreen.id);} ,
                                    iconData: FontAwesomeIcons.arrowLeft),
                              ),),
                              Align(alignment: Alignment.topRight, child:Container(
                                margin: EdgeInsets.all(25),
                                child: CircleButton(
                                    onTap: (){
                                      //Navigator.pushReplacementNamed(context,HomeScreen.id);
                                      } ,
                                    iconData: FontAwesomeIcons.solidHeart),
                              ),),



                            ])),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text("${_detailHouseModel.response.name}",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: kGry,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  size: 1,
                                  color: kLightGry,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${_detailHouseModel.response.location}',
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kGryBG,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.borderAll,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${_detailHouseModel.response.area}",
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kGryBG,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.bed,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${_detailHouseModel.response.bedroom} bedrooms',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: kGryBG,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.shower,
                                        size: 12,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${_detailHouseModel.response.washroom} bath',
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Scaffold(
                        backgroundColor: kGry,
                        appBar: TabBar(
                          indicatorWeight: 3.0,
                          labelPadding: EdgeInsets.only(bottom: 8),
                          labelStyle: TextStyle(fontSize: 16),
                          indicatorColor: Colors.white,
                          controller: _tabController,
                          tabs: [
                            Container(
                              child: Tab(
                                text: "Info / Details",
                              ),
                            ),
                            Tab(
                              text: "Photo",
                            ),
                            Tab(
                              text: "Video",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      child: TabBarView(
                        children: [
                          Container(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    child: Text(
                                      "Property detalis",
                                      style: TextStyle(
                                          color: kGry,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                  Container(
                                    child: Text(
                                      "${_detailHouseModel.response.shortDetail}",
                                      style: TextStyle(color: kGry),
                                    ),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    child: Text(
                                      "Location",
                                      style: TextStyle(
                                          color: kGry,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(
                                      top: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          size: 15,
                                          color: kLightGry,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${_detailHouseModel.response.location}',
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 300,
                                    child: Center(
                                        child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: GoogleMap(
                                          zoomControlsEnabled: false,
                                          mapType: MapType.normal,
                                          markers: Set<Marker>.of(_markers),
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  double.parse(_detailHouseModel
                                                      .response.latitude),
                                                  double.parse(_detailHouseModel
                                                      .response.longtitude)),
                                              zoom: 13),
                                        ),
                                      ),
                                    )),
                                    margin: EdgeInsets.only(top: 10),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 20, bottom: 20),
                                    child: FlatButton(
                                      color: kBlueText,
                                      textColor: Colors.white,
                                      disabledColor: Colors.grey,
                                      disabledTextColor: Colors.black,
                                      splashColor: kButtonBG,
                                      onPressed: () {
                                        openMap(
                                            double.parse(_detailHouseModel
                                                .response.latitude),
                                            double.parse(_detailHouseModel
                                                .response.longtitude));
                                      },
                                      child: Text(
                                        "View Direction",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(15),
                            color: Colors.white,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(
                                  _detailHouseModel.response.icon.length,
                                  (index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(15.0),
                                        topRight: const Radius.circular(15.0),
                                        bottomLeft: const Radius.circular(15.0),
                                        bottomRight:
                                            const Radius.circular(15.0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "${_detailHouseModel.response.icon[index]}"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                                itemCount:
                                    _detailHouseModel.response.video.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 5,
                                    child: Container(
                                      height: 200,
                                      width: double.infinity,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(10.0),
                                            bottomLeft:
                                                const Radius.circular(10.0),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChewieListItem(
                                                  videoPlayerController: VideoPlayerController.network(_detailHouseModel.response.video[index]),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Image(
                                            image: NetworkImage(
                                                "${_detailHouseModel.response.icon[index]}"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                        controller: _tabController,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 40.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: Colors.white54,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: kBlueText,
        ),
      ),
    );
  }
}
