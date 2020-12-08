import 'package:flutter/material.dart';
// import 'package:music_mobile/store/login_info.dart';
// import 'package:provider/provider.dart';

class NewPage extends StatefulWidget {
  final Map arguments;
  NewPage({Key key, this.arguments}) : super(key: key);
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  void initState() {
    super.initState();
    // var info = Provider.of<LoginInfo>(context, listen: false).loginGet;
    // print(info);
  }

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("新的界面"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("我是传过来的参数 ${widget.arguments}  , 我也是$name"),
          ),
          RaisedButton(
            child: Text("跳转"),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return NewPage();
              // }));
              Navigator.of(context).pushNamed("/home_page");
            },
          ),
        ],
      ),
    );
  }
}
