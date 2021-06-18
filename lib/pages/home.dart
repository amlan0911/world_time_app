import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  /* void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context)!.settings.arguments as Map;
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;

    // set background image
    String bgImage = " ";
    if (data['isDaytime'] == 0)
      bgImage = 'day.jpg';
    else if (data['isDaytime'] == 1)
      bgImage = 'evening.jpg';
    else
      bgImage = 'night.jpg';
    ;

    //   Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      // backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/$bgImage'),
          // fit: BoxFit.fill,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 150.0, 0, 0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  if (result != null) {
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  }
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.blue[600],
                ),
                label: Text(
                  'Change Location',
                  style: TextStyle(
                    color: Colors.blue[600],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 35.0,
                      letterSpacing: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              Text(data['time'],
                  style: TextStyle(fontSize: 66.0, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
