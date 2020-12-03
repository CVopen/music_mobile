import 'package:flutter/material.dart';

// import '../../api/home_page.dart';

class MvPage extends StatefulWidget {
  @override
  _MvPageState createState() => _MvPageState();
}

class _MvPageState extends State<MvPage> with AutomaticKeepAliveClientMixin {
  int a = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // var swiper = ApiHome().getBanner();
    // print(swiper);
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: <Widget>[
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          Text("a$a"),
          RaisedButton(
            child: Text("点击"),
            onPressed: () {
              a++;
              setState(() {});
            },
          ),
          SizedBox(
            height: 40,
          ),
          RaisedButton(
            child: Text("跳转"),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return NewPage();
              // }));
              Navigator.of(context)
                  .pushNamed("/new_page", arguments: {'name': "hi"});
            },
          ),
        ],
      ),
    );
  }
}
