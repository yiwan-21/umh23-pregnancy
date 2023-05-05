import 'package:flutter/material.dart';
import 'custom_color.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  final int _totalWeeks = 42;
  final double _tabWidth = 80;
  final Map<String, List> _events = {
    // event: [starting, duration, layer]
    'First Ultrasound Scan': [6, 4, 1],
    'Gender Reveal': [18, 4, 2],
    'Second Ultrasound Scan': [20, 4, 1],
    'Third Ultrasound Scan': [30, 4, 1],
    'First Trimester': [1, 13, 4],
    'Second Trimester': [14, 13, 5],
    'Third Trimester': [27, 16, 4],
  };
  final List<Color> _colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
  ];

  Color _generateColor(int starting) {
    return _colors[starting ~/ _colors.length];
  }

  List<Widget> _generateWeekTab() {
    return List<Widget>.generate(
      _totalWeeks,
      (index) => Container(
        alignment: Alignment.center,
        width: _tabWidth,
        height: 50.0,
        decoration: BoxDecoration(
            border: const Border.symmetric(
              vertical: BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
            color: Colors.pink[50]),
        child: Text(
          'Week\n${index + 1}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<Widget> _generateWeekGrid() {
    return List<Widget>.generate(
      _totalWeeks,
      (index) => Container(
        alignment: Alignment.center,
        width: _tabWidth,
        height: MediaQuery.of(context).size.height,
        // child: const VerticalDivider(
        //   color: Colors.grey,
        //   thickness: 1,
        //   width: 1,
        // ),
      ),
    );
  }

  List<Widget> _generateEvents() {
    return List<Widget>.generate(
      _events.length,
      (index) => Positioned(
        top: (_events.values.elementAt(index)[2] * _tabWidth),
        left: ((_events.values.elementAt(index)[0] - 1) * _tabWidth),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _events.keys.elementAt(index),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: lightPink,
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  _events.keys.elementAt(index),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: _generateColor(_events.values.elementAt(index)[0]),
                    height: 30,
                    width: _events.values.elementAt(index)[1] * _tabWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Timeline'),
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: (_tabWidth * _totalWeeks.toDouble()),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                children: [
                  Row(
                    children: _generateWeekTab(),
                  ),
                  Flexible(
                    child: Stack(
                      children: [
                        ..._generateEvents(),
                        Row(
                          children: _generateWeekGrid(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
