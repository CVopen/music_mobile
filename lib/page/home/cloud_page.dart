// import 'package:flutter/material.dart';

// class CloudPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.pink,
//       child: Center(
//         child: Text('云村'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CloudPage extends StatefulWidget {
  @override
  _CloudPageState createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage>
    with AutomaticKeepAliveClientMixin {
  int a = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新的界面"),
      ),
      body: Center(
        child: Text("我是一个新的界面"),
      ),
    );
  }
}
