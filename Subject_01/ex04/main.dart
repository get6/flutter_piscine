import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyHomePage(title: "ex04"),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const PizzaBody(),
      ),
    );
  }
}

class PizzaBody extends StatefulWidget {
  const PizzaBody({Key? key}) : super(key: key);

  @override
  State<PizzaBody> createState() => _PizzaBodyState();
}

class _PizzaBodyState extends State<PizzaBody> {
  final List<String> _dough = <String>["오리지널 도우", "씬 도우"];
  final List<Widget> _doughImage = <Widget>[
    Image.asset("assets/images/dough1.jpg"),
    Image.asset("assets/images/dough2.jpg"),
  ];

  final List<String> _sauce = <String>["토마토 소스", "특제 소스"];
  final List<Widget> _sauceImage = <Widget>[
    Image.asset("assets/images/sauce1.jpg"),
    Image.asset("assets/images/sauce2.jpg"),
  ];

  final List<String> _cheese = <String>["모짜렐라 치즈", "고르곤졸라 치즈"];
  final List<Widget> _cheeseImage = <Widget>[
    Image.asset("assets/images/cheese1.jpg"),
    Image.asset("assets/images/cheese2.jpg"),
  ];

  final List<String> _mainItem = <String>["페퍼로니", "null", "감자", "베이컨"];
  final List<Widget> _mainImage = <Widget>[
    Image.asset("assets/images/mainItem1.jpg"),
    Image.asset("assets/images/mainItem2.png"),
    Image.asset("assets/images/mainItem3.jpg"),
    Image.asset("assets/images/mainItem4.jpg"),
  ];

  final List<String> _pizzaStack = <String>[];
  final List<String> _orderMenu = <String>[
    "페퍼로니 피자",
    "치즈 피자",
    "포테이토 피자",
    "베이컨 피자",
  ];
  late List<List<String>> _menuItems;
  late int _orderedPizzaIndex;
  late String _orderedPizza;

  @override
  void initState() {
    super.initState();
    _menuItems = <List<String>>[
      [_dough[0], _sauce[0], _cheese[0], _mainItem[0]],
      [_dough[1], _sauce[0], _cheese[0], _mainItem[1]],
      [_dough[0], _sauce[1], _cheese[1], _mainItem[2]],
      [_dough[1], _sauce[1], _cheese[0], _mainItem[3]],
    ];
    _getNewPizzaOrder();
  }

  void _getNewPizzaOrder() {
    _orderedPizzaIndex = Random().nextInt(4);
    _orderedPizza = _orderMenu[_orderedPizzaIndex];
  }

  Widget _myDraggable(Widget child, String data) => Draggable(
        childWhenDragging: Container(),
        feedback: child,
        data: data,
        child: child,
      );

  Widget _pizzaItemWidget(String left, String right, Widget src1, Widget src2) {
    Widget menu1 = getImgWidget(src1);
    Widget menu2 = getImgWidget(src2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _myDraggable(menu1, left),
        const SizedBox(width: 20),
        _myDraggable(menu2, right),
      ],
    );
  }

  Widget _pizzaMainItemWidget(
      String menu1, String menu2, String menu3, String menu4) {
    Widget menu1Img = getImgWidget(_mainImage[0]);
    Widget menu2Img = getImgWidget(_mainImage[1]);
    Widget menu3Img = getImgWidget(_mainImage[2]);
    Widget menu4Img = getImgWidget(_mainImage[3]);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _myDraggable(menu1Img, _mainItem[0]),
            const SizedBox(width: 15),
            _myDraggable(menu2Img, _mainItem[1]),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _myDraggable(menu3Img, _mainItem[2]),
            const SizedBox(width: 15),
            _myDraggable(menu4Img, _mainItem[3]),
          ],
        ),
      ],
    );
  }

  Container getImgWidget(Widget image) {
    return Container(
      width: 150,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(5, 5),
        )
      ]),
      alignment: Alignment.center,
      child: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "주문 피자 : $_orderedPizza",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: Opacity(
                    opacity: 0.5,
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Image.network(
                              "https://bit.ly/2ZG7CjM",
                            ),
                            const Text(
                              "Drop Here",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                      onAccept: (data) {
                        if (_pizzaStack.length < 3) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(data)));
                        }
                        if (_pizzaStack.length < 4) _pizzaStack.add(data);
                        setState(() {
                          String title = '피자가 잘 만들어졌습니다!';
                          if (_pizzaStack.length >= 4) {
                            for (int i = 0; i < 4; i++) {
                              if (_menuItems[_orderedPizzaIndex][i] !=
                                  _pizzaStack[i]) {
                                title = '피자가 잘 만들어지지 않았습니다!';
                                break;
                              }
                            }
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                title: const Text('result'),
                                content: Text(title),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      '확인',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                            _pizzaStack.clear();
                            _getNewPizzaOrder();
                          }
                        });
                      },
                    )),
              ),
              const SizedBox(height: 100),
            ],
          ),
          const Divider(thickness: 4, color: Colors.black54),
          Column(
            children: [
              const SizedBox(height: 50),
              Builder(
                builder: (BuildContext context) {
                  switch (_pizzaStack.length) {
                    case 0:
                      return _pizzaItemWidget(
                          _dough[0], _dough[1], _doughImage[0], _doughImage[1]);
                    case 1:
                      return _pizzaItemWidget(
                          _sauce[0], _sauce[1], _sauceImage[0], _sauceImage[1]);
                    case 2:
                      return _pizzaItemWidget(_cheese[0], _cheese[1],
                          _cheeseImage[0], _cheeseImage[1]);
                    default:
                      return _pizzaMainItemWidget(_mainItem[0], _mainItem[1],
                          _mainItem[2], _mainItem[3]);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
