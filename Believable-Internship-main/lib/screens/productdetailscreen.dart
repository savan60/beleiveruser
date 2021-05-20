import 'package:believableuser/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
class ProductDetailScreen extends StatelessWidget {
    static final String routename = "/products-details-screen";

  @override
  Widget build(BuildContext context) {
    var details =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    int amount=details['amount'];
    String descp=details['description'];
    int discount=details['discount'];
    int finalamount=details['c'];
    String url1=details['url1'];
    String url2=details['url2'];
    String url3=details['url3'];
    String name=details['name'];
    return ProductDetailPage(amount: amount,descp: descp,discount: discount,finalamount: finalamount,name: name,url1: url1,url2: url2,url3: url3,);
  }
}