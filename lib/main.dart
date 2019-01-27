import 'package:flutter/material.dart';
import 'package:foodpanda_ui_clone/cuisineHelper.dart';
import 'package:foodpanda_ui_clone/restauHelper.dart';
import 'package:foodpanda_ui_clone/restauTemplate.dart';
import 'package:foodpanda_ui_clone/dishTemplate.dart';
import 'package:foodpanda_ui_clone/dishHelper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Foodpanda UI Clone',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
      showSemanticsDebugger: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


Widget _buildCarousel(BuildContext context, int carouselIndex) {
  String cuisine = CuisineHelper.getCuisine();
  int discount = CuisineHelper.getDiscount();
  String header = cuisine + " @ " + discount.toString() + "% Off";
  return Column(
    //mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(header, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
      ),
      SizedBox(
        height: 220.0,
        width: 550.0,
        child: PageView.builder(
          // store this controller in a State to save the carousel scroll position
          controller: PageController(viewportFraction: 0.55),
          itemBuilder: (BuildContext context, int itemIndex) {
            return _buildCarouselItem(context, carouselIndex, itemIndex);
          },
        ),
      )
    ],
  );
}

Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
  DishModel item = DishHelper.getItem();

  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Container(
      width: 80.0,
      height: 80.0,
      child: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.only(
              topLeft: new Radius.circular(16.0), 
              topRight: new Radius.circular(16.0)
            ),
            child: Image.network(item.dishPic, width: 300.0, height: 144.0,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
            child: Text(item.name),
          ),
          Text(item.hotel, 
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 8.0),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("\$" + item.price.toString(), style: TextStyle(fontWeight: FontWeight.w700),),
                Icon(Icons.adjust, color: item.type ? Colors.red : Colors.green),
              ]
            )
          )
        ],
      ),
    
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 165, 0, 0.1),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> 
  with SingleTickerProviderStateMixin {
    TabController tabController;
    var fabIcon;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              fabIcon = null;
              break;
            case 1:
              fabIcon = Icons.filter_list;
              break;
            default:
              break;
          }
        });
      });
    }

    getRow(type, Text text) {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 24.0),
              child: Icon(type, color: Colors.orangeAccent,)
            ),
            text,
          ],
        )
      );
    }

    @override
    Widget build(BuildContext context) {
      // This method is rerun every time setState is called, for instance as done
      // by the _incrementCounter method above.
      //
      // The Flutter framework has been optimized to make rerunning build methods
      // fast, so that you can just rebuild anything that needs updating rather
      // than having to individually change instances of widgets.
      return new Scaffold(
        appBar: new AppBar(
          iconTheme: new IconThemeData(color: Colors.black87),
          backgroundColor: Colors.white70,
          title: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('Mountain View, CA', style: TextStyle(color: Colors.black87, fontSize: 14.0),),
                    Icon(Icons.expand_more, color: Colors.black54)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.shopping_basket, color: Colors.black87,size: 20.0,)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.search, color: Colors.black87, size: 20.0,)
                    )
                  ],
                )
              ],
            ),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("RECOMMENDED", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),),),
              Tab(child: Text("ALL RESTAURANTS", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),)),
            ],
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.black87,
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (BuildContext context, int index) {
                if(index % 2 == 0) {
                  return _buildCarousel(context, index ~/ 2);
                }
                else {
                  return Divider();
                }
              },
              itemCount: DishHelper.itemCount,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
                  child: Text(RestauHelper.itemCount.toString() + " delivery options"),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, position) {
                  RestauModel item = RestauHelper.getItem(position);

                  return Column (
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: new BorderRadius.circular(8.0),
                              child: Image.network(item.displayImg, width: 60.0, height: 60.0,)
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(item.name, style: new TextStyle(fontWeight: FontWeight.w600),),
                                          Text(item.dishes)
                                        ],
                                      )
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Icon(Icons.star, size: 12.0, color: Colors.green),
                                            Text(item.rating, style: new TextStyle(color: Colors.green),),
                                          ],
                                        ),
                                        Text(item.numReviews, style: new TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300,
                                        ),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
                itemCount: RestauHelper.itemCount,
              )),]
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0,64.0,32.0,32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("John Doe", 
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ),
                      ),
                      Text("john@email.com", style: TextStyle(fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    getRow(Icons.home, Text("Restaurants")),
                    Divider(),
                    getRow(Icons.history, Text("My Orders")),
                    Divider(),
                    getRow(Icons.account_balance_wallet, Text("Wallet")),
                    Divider(),
                    getRow(Icons.build, Text("Settings")),
                    Divider(),
                    getRow(Icons.forum, Text("Support")),
                    Divider(),
                    getRow(Icons.note, Text("About")),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: new Opacity(
          opacity: fabIcon == null ? 0.0 : 1.0,
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(fabIcon),
            backgroundColor: Colors.black54,
          ),
        ),
      );
    }
}
