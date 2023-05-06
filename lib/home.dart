import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;

import 'package:flutter/material.dart';
import 'user_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String getImage(int weeks) {
    if (weeks <= 4) return "assets/images/W1.jpg";
    if (weeks <= 7) return "assets/images/W4.jpg";
    if (weeks <= 10) return "assets/images/W7.jpg";
    if (weeks <= 14) return "assets/images/W10.jpg";
    if (weeks <= 17) return "assets/images/W14.jpg";
    if (weeks <= 20) return "assets/images/W17.jpg";
    if (weeks <= 23) return "assets/images/W20.jpg";
    if (weeks <= 26) return "assets/images/W23.jpg";
    if (weeks <= 29) return "assets/images/W26.jpg";
    if (weeks <= 33) return "assets/images/W29.jpg";
    if (weeks <= 37) return "assets/images/W33.jpg";
    if (weeks <= 40) return "assets/images/W37.jpg";
    return "assets/images/W40.jpg";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Home'),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 180,
                  margin: const EdgeInsets.only(top: 20),
                  child: CustomPaint(
                    painter: CustomCircularProgress(
                      value: UserData.last_filled == null ? 0 : UserData.weeks / 40,
                    ),
                    child: UserData.last_filled == null
                    ? Container()
                    : Center(
                      child: CircleAvatar(
                        radius: 65,
                        // use the function getImage()
                        backgroundImage: AssetImage(getImage(UserData.weeks)),
                      ),
                    ),
                  ),
                ),
                UserData.last_filled == null
                ? const Text("Please fill in complete your Personal Questionnaire to get started")
                : Text(
                    "Week ${UserData.weeks} / Days ${UserData.days}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/timeline');
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Image(
                      height: 100,
                      width: 400,
                      image: NetworkImage(
                        "https://img.freepik.com/free-vector/hand-drawn-fetus-illustration_23-2149205952.jpg?w=740&t=st=1683280539~exp=1683281139~hmac=5ab7d4dc7c8df9743624594421cfe81957330152991e379e3145dbbb3fb682a1",
                      ),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Timeline",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCircularProgress extends CustomPainter {
  final double value;

  CustomCircularProgress(
      {required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCenter(center: center, width: 170, height: 170),
      vmath.radians(140),
      vmath.radians(260),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black12
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 5,
    );
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: 200, height: 200),
      Paint(),
    );

    const Gradient gradient = SweepGradient(
      startAngle: 1.25 * math.pi / 2,
      endAngle: 5.5 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: <Color>[
        Colors.pink,
        Colors.pinkAccent,
      ],
    );
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 170, height: 170),
      vmath.radians(140),
      vmath.radians(260 * value),
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..shader = gradient
            .createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
        ..strokeWidth = 5,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
