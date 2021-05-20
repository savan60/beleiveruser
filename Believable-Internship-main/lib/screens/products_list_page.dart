import 'package:believableuser/screens/email_auth.dart';
import 'package:believableuser/size_config.dart';
import 'package:believableuser/widgets/login_screen.dart';
import 'package:believableuser/widgets/product_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class ProductsListPage extends StatelessWidget {
      static final String routename = "/products-list-page";

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var maxH = SizeConfig.heightMultiplier;
    var maxW = SizeConfig.widthMultiplier;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "PRODUCT LIST",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder(
                stream: Firestore.instance
                    .collection('products')
                  
                    // .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (ctx, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final chatDocs = chatSnapshot.data.documents;
                  final user = FirebaseAuth.instance.currentUser;
                  print("chatdocs is $chatDocs");
                  return Container(
                          color: Colors.grey[100],

                    padding: EdgeInsets.only(top: 10),
                    child: chatDocs.length == 0
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Add Product to your Inventory!",
                                  style: TextStyle(fontSize: 16 * maxH / 647)),
                            ],
                          )
                        : ListView.builder(
                            // reverse: true,
                            itemCount: chatDocs.length,
                            itemBuilder: (ctx, index) {
                              return ProductsListItem(
                                url1: chatDocs[index]['image1'],
                                url2: chatDocs[index]['image2'],
                                url3: chatDocs[index]['image3'],
                                name: chatDocs[index]['name'],
                                description:  chatDocs[index]['category'],
                                // discount: 2,
                                // originalPrice: 2,
                                discount: int.parse(chatDocs[index]['offer']),
                                originalPrice: int.parse((chatDocs[index]['amount'])),
                              );
                              // (chatDocs[index]['productName']);
                            }

                            // MessageBubble(
                            //   chatDocs[index]['text'],
                            //   chatDocs[index]['userId'] == futureSnapshot.data.uid,
                            //   chatDocs[index]['username'],
                            //   chatDocs[index]['userImage'],
                            //   key: ValueKey(chatDocs[index]
                            //       .documentID), // key just for efficently updating the list of messages
                            // ),
                            ),
                  );
                });
          },
        ));
  }

  

  
}
