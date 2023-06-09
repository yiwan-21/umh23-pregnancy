import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vmath;

import 'package:flutter/material.dart';
import 'user_data.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String getImage(int weeks) {
    if (weeks <= 4) return "assets/images/fetus/W1.jpg";
    if (weeks <= 7) return "assets/images/fetus/W4.jpg";
    if (weeks <= 10) return "assets/images/fetus/W7.jpg";
    if (weeks <= 14) return "assets/images/fetus/W10.jpg";
    if (weeks <= 17) return "assets/images/fetus/W14.jpg";
    if (weeks <= 20) return "assets/images/fetus/W17.jpg";
    if (weeks <= 23) return "assets/images/fetus/W20.jpg";
    if (weeks <= 26) return "assets/images/fetus/W23.jpg";
    if (weeks <= 29) return "assets/images/fetus/W26.jpg";
    if (weeks <= 33) return "assets/images/fetus/W29.jpg";
    if (weeks <= 37) return "assets/images/fetus/W33.jpg";
    if (weeks <= 40) return "assets/images/fetus/W37.jpg";
    return "assets/images/fetus/W40.jpg";
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
                      value: UserData.last_filled == null
                          ? 0
                          : UserData.weeks / 40,
                    ),
                    child: UserData.last_filled == null
                        ? Container()
                        : Center(
                            child: CircleAvatar(
                              radius: 65,
                              // use the function getImage()
                              backgroundImage:
                                  AssetImage(getImage(UserData.weeks)),
                            ),
                          ),
                  ),
                ),
                UserData.last_filled == null
                    ? const Text(
                        "Please fill in complete your Personal Questionnaire to get started")
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
                      image: AssetImage(
                          'assets/images/hand-drawn-fetus-illustration.png'),
                      fit: BoxFit.cover,
                    ),
                    const Divider(height: 0, thickness: 1, color: Colors.black26),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "View Pregnancy Timeline",
                            style: TextStyle(
                              fontSize: 18,
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
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                if (UserData.risk != '') {
                  Navigator.pushNamed(context, '/careplan');
                }
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
                      image: AssetImage('assets/images/careplan.jpg'),
                      alignment: Alignment(0, -0.2),
                      fit: BoxFit.cover,
                    ),
                    const Divider(height: 0, thickness: 1, color: Colors.black26),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  color: UserData.risk == '' ? Colors.black12 : Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Personalized Care Plan",
                            style: TextStyle(
                              color: UserData.risk == ''
                                  ? Colors.black54
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                    const Divider(height: 0, thickness: 1, color: Colors.black26),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "You can view your personalized care plan after completing the Health Risk questionnaire in the 'Other' tab",
                        style: TextStyle(
                          fontSize: 15,
                        ),
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

  CustomCircularProgress({required this.value});

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
