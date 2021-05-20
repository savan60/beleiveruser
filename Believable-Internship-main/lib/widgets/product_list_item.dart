import 'package:believableuser/screens/product_detail_page.dart';
import 'package:believableuser/screens/productdetailscreen.dart';
import 'package:flutter/material.dart';

class ProductsListItem extends StatelessWidget {
  final String name;
  final int originalPrice;
  final String description;
  final int discount;
  final String url2;
  final String url1;
  final String url3;

   ProductsListItem(
      {Key key,
      this.name,
      this.description,
      this.originalPrice,
      this.discount,
      this.url1,
      this.url2,
      this.url3})
      : super(key: key);
int c;
  @override
  Widget build(BuildContext context) {
     c= (originalPrice - (originalPrice * discount / 100)).toInt();

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildProductItemCard(context),
      ],
    );
  }

  _buildProductItemCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailScreen.routename, arguments: {
          'name': name,
          'description': description,
          'amount': originalPrice,
          'discount':discount,
          'c':c,
          'url1': url1,
          'url2': url2,
          'url3': url3,
        });
      },
      child: Card(
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.network(
                url1,
              ),
              height: 250.0,
              width: MediaQuery.of(context).size.width * 0.94,
            ),
            SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "\$$c",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "\$$originalPrice",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "$discount\% off",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
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
