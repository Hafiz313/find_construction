import 'package:carousel_slider/carousel_slider.dart';
import 'package:find_construction/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailScreen extends StatefulWidget {
  static const id = "detail_screen";

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  TabController _tabController;
  List<int> list = [1, 2, 3, 4, 5];


  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 300,
                  child:

                  CarouselSlider(
                    options: CarouselOptions(height: 300.0),
                    items: [1, 2, 3, 4, 5].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                         //         width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 2.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/home_bg.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child:Container(
                              margin: EdgeInsets.all(30),
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: CircleButton(
                                        onTap: () => Navigator.pop(context),
                                        iconData: FontAwesomeIcons.arrowLeft),
                                  ),
                                  Container(
                                    child: CircleButton(
                                        onTap: () => print("Cool"),
                                        iconData: FontAwesomeIcons.solidHeart),
                                  ),

                                ],

                              ),
                            ) ,
                          );
                        },
                      );
                    }).toList(),
                  )
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("Modern day house",
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
                            'Montacute TA15 6XP, United Kingdom',
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
                                  '2100 sqft',
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
                                  '3 bedrooms',
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
                                  '2 bath',
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
                height: 600,
                child: TabBarView(
                  children: [
                    Container(
                      child: Column(
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
                              text,
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
                                  '75 Belford Road, Edinburgh',
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
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(31.512736, 74.342480),
                                      zoom: 17),
                                ),
                              ),
                            )),
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(15),
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(10, (index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 5,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(15.0),
                                      topRight: const Radius.circular(15.0),
                                      bottomLeft: const Radius.circular(15.0),
                                      bottomRight: const Radius.circular(15.0),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage("images/bg.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 170,
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          itemCount: 10,
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
                                      topLeft: const Radius.circular(10.0),
                                      bottomLeft: const Radius.circular(10.0),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage("images/video_bg.png"),
                                      fit: BoxFit.cover,
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
        child: new Icon(
          iconData,
          color: kBlueText,
        ),
      ),
    );
  }
}
