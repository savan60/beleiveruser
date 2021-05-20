import 'package:believableuser/screens/email_auth.dart';
import 'package:believableuser/widgets/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class ProductDetailPage extends StatefulWidget {
  static final String routename = "/products-screen";
  int amount;
  int finalamount;
  int discount;
  String name;
  String url1;
  String url2;
  String url3;
  String descp;

  ProductDetailPage({
    this.amount,
    this.descp,
    this.discount,
    this.finalamount,
    this.name,
    this.url1,
    this.url2,
    this.url3
  });
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // actions: [
        //   DropdownButton(
        //     icon: Icon(
        //       Icons.more_vert,
        //       color: Colors.black,
        //     ),
        //     items: [
        //       DropdownMenuItem(
        //         child: Container(
        //           child: Row(
        //             children: [
        //               Icon(Icons.exit_to_app, color: Colors.black),
        //               Text('Logout'),
        //             ],
        //           ),
        //         ),
        //         value: 'logout',
        //       ),
        //     ],
        //     onChanged: (itemIdentifier) {
        //       if (itemIdentifier == 'logout') {
        //         SweetAlert.show(
        //           context,
        //           title: "Confirmation",
        //           subtitle: "   Are you sure you want to logout?",
        //           style: SweetAlertStyle.confirm,
        //           showCancelButton: true,
        //           onPress: (bool isConfirm) {
        //             if (isConfirm) {
        //               FirebaseAuth.instance.signOut();
        //               Navigator.of(context).pop();
        //             }
        //           },
        //         );
        //       }
        //     },
        //   )
        // ],
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 40.0,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          "PRODUCT DETAIL",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: _buildProductDetailsPage(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  _buildProductDetailsPage(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProductImagesWidgets(),
              _buildProductTitleWidget(),
              SizedBox(height: 12.0),
              _buildMoreInfoData(),
              SizedBox(height: 24.0),
              _buildPriceWidgets(),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ],
    );
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildProductImagesWidgets() {
    TabController imagesController = TabController(length: 3, vsync: this);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 380.0,
        child: Center(
          child: DefaultTabController(
            length: 3,
            child: Stack(
              children: <Widget>[
                TabBarView(
                  controller: imagesController,
                  children: <Widget>[
                    Image.network(
                      widget.url1
                      // "https://assets.myntassets.com/h_240,q_90,w_180/v1/assets/images/1304671/2016/4/14/11460624898615-Hancock-Men-Shirts-8481460624898035-1_mini.jpg",
                    ),
                    Image.network(
                      widget.url2
                      // "https://n1.sdlcdn.com/imgs/c/9/8/Lambency-Brown-Solid-Casual-Blazers-SDL781227769-1-1b660.jpg",
                    ),
                    Image.network(
                      widget.url3,
                      // "https://images-na.ssl-images-amazon.com/images/I/71O0zS0DT0L._UX342_.jpg",
                    ),
                  ],
                ),
                Container(
                  alignment: FractionalOffset(0.5, 0.95),
                  child: TabPageSelector(
                    controller: imagesController,
                    selectedColor: Colors.grey,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        //name,
        // "Nakkana",
        widget.name,
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }

  _buildPriceWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "\$${widget.finalamount}",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "\$${widget.amount}",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black87,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "${widget.discount}% off",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  _buildMoreInfoData() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        widget.descp,
        // "This is the description of the product which is displayed currently",
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.white,
              child: Center(
                child: Text(
                  "ADD TO CART",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.orange,
              child: Center(
                child: Text(
                  "BUY NOW",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
