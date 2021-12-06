import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shreya_demo/filters/product.dart';

class FilterDemo extends StatefulWidget {
  const FilterDemo({Key? key}) : super(key: key);

  @override
  _FilterDemoState createState() => _FilterDemoState();
}

class _FilterDemoState extends State<FilterDemo> {
  //
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  List<String> productList = [];

  //
  bool redmiValue = false;
  bool vivoValue = false;
  bool appleValue = false;
  bool samsungValue = false;
  bool oppoValue = false;

  //
  String redmi = '';
  String vivo = '';
  String apple = '';
  String samsung = '';
  String oppo = '';
  @override
  void initState() {
    super.initState();
    manageProduct();
  }

  //
  @override
  void dispose() {
    super.dispose();
  }

  void manageProduct() {
    productList.clear();
    productList.add(redmi);
    productList.add(vivo);
    productList.add(apple);
    productList.add(samsung);
    productList.add(oppo);
  }

  @override
  Widget build(BuildContext context) {
    Query query = products.where('company', whereIn: productList);

    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Fiter Demo'),
      ),

      //
      body: StreamBuilder(
        stream: query.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              //
              Container(
                height: 100,
                child: Column(
                  children: [
                    Row(
                      children: [
                        //Redmi
                        Row(
                          children: [
                            Checkbox(
                              value: redmiValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  redmiValue = newValue!;
                                  if (redmiValue) {
                                    redmi = 'Redmi';
                                  } else {
                                    redmi = '';
                                  }
                                  manageProduct();
                                });
                              },
                            ),
                            Text('Redmi'),
                          ],
                        ),
                        //Vivo
                        Row(
                          children: [
                            Checkbox(
                              value: vivoValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  vivoValue = newValue!;
                                  if (vivoValue) {
                                    vivo = 'Vivo';
                                  } else {
                                    vivo = '';
                                  }
                                  manageProduct();
                                });
                              },
                            ),
                            Text('Vivo'),
                          ],
                        ),
                        //Apple
                        Row(
                          children: [
                            Checkbox(
                              value: appleValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  appleValue = newValue!;
                                  if (appleValue) {
                                    apple = 'Apple';
                                  } else {
                                    apple = '';
                                  }
                                  manageProduct();
                                });
                              },
                            ),
                            Text('Apple'),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        //Samsung
                        Row(
                          children: [
                            Checkbox(
                              value: samsungValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  samsungValue = newValue!;
                                  if (samsungValue) {
                                    samsung = 'Samsung';
                                  } else {
                                    samsung = '';
                                  }
                                  manageProduct();
                                });
                              },
                            ),
                            Text('Samsung'),
                          ],
                        ),
                        //Oppo
                        Row(
                          children: [
                            Checkbox(
                              value: oppoValue,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  oppoValue = newValue!;
                                  if (oppoValue) {
                                    oppo = 'Oppo';
                                  } else {
                                    oppo = '';
                                  }
                                  manageProduct();
                                });
                              },
                            ),
                            Text('Oppo'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,

                  //
                  itemBuilder: (BuildContext context, int index) {
                    Product product =
                        Product.fromSnapshot(snapshot.data.docs[index]);

                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //
                            Text('${product.name}'),
                            Text('from ${product.company}'),
                            Text('\u20b9 ${product.price}'),
                            Text('${product.ram}GB RAM'),
                            Text('${product.storage}GB Storage'),
                            Text('${product.discount}% discount'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
