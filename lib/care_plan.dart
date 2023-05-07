import 'package:flutter/material.dart';

import 'user_data.dart';

class CarePlan extends StatelessWidget {
  CarePlan({super.key});

  final Map<String, List<String>> _carePlan = {
    "Age>50": [
      "Increase prenatal monitoring",
      "Getting proper nutrients",
      "Screening for fetal chromosmal abnormalities"
    ],
    "Age>25": [
      "Personalized weight gain plan",
      "Healthy eating",
      "Regular physical activity",
      "Monitoring of your weight gain"
    ],
    "Age<18": [
      "Eating a well-balanced diet that includes a variety of nutrient-rich foods",
      "Engaging in regular physical activity",
      "Increase your calorie and nutrient intake",
      "Regular monitoring of your weight gain"
    ],
    "BP>140/90": [
      "Lifestyle changes, such as dietary modifications",
      "Increase physical activity",
      "Medications"
    ],
    "BP<90/60": [
      "Stay hydrated and consume enough fluids to help raise your blood pressure",
      "Stand up slowly from a sitting or lying position to prevent dizziness and falls",
      "Eat small, frequent meals"
    ],
    "Sugar>95": [
      "Eating a healthy, well-balanced diet with a focus on whole grains, lean proteins, fruits, and vegetables",
      "Exercise",
      "Medications"
    ],
    "Low Stress": [
      "Try relaxation techniques",
      "Light exercise",
      "Spending time outdoors",
      "Pursuing a hobby"
    ],
    "Medium Stress": [
      "Seek support from a friend or family member",
      "Join a support group",
      "Work with a prenatal mental health professional"
    ],
    "High Stress": [
      "Prioritize self-care",
      "Seek professional support",
      "Taking time off work",
      "Speaking with a healthcare provider about medication options"
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Care Plan'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          if (UserData.risk != '')
            Card(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: UserData.risk == 'high risk'
                    ? Colors.redAccent[100]
                    : UserData.risk == 'mid risk'
                        ? Colors.amberAccent[100]
                        : Colors.greenAccent[100],
                child: Text(
                  UserData.risk.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (UserData.dia_gdm != '')
            Card(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: UserData.dia_gdm == 'GDM'
                    ? Colors.redAccent[100]
                    : Colors.greenAccent[100],
                child: Text(
                  UserData.dia_gdm,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (UserData.mode_delivery != '')
            Card(
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                padding: const EdgeInsets.all(10),
                color: Colors.greenAccent[100],
                child: Text(
                  UserData.mode_delivery,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          if (UserData.age > 50)
            CarePlanCard(
              title: "Age",
              solution: _carePlan["Age>50"]!,
            )
          else if (UserData.age > 25)
            CarePlanCard(
              title: "Age",
              solution: _carePlan["Age>25"]!,
            )
          else if (UserData.age < 18)
            CarePlanCard(
              title: "Age",
              solution: _carePlan["Age<18"]!,
            ),
          if (UserData.systolic_blood_pressure > 140 ||
              UserData.diastolic_blood_pressure > 90)
            CarePlanCard(
              title: "Blood Pressure",
              solution: _carePlan["BP>140/90"]!,
            )
          else if (UserData.systolic_blood_pressure < 90 ||
              UserData.diastolic_blood_pressure < 60)
            CarePlanCard(
              title: "Blood Pressure",
              solution: _carePlan["BP<90/60"]!,
            ),
          if (UserData.sugar_level > 95)
            CarePlanCard(
              title: "Sugar",
              solution: _carePlan["Sugar>95"]!,
            ),
          if (UserData.stress_level == 1)
            CarePlanCard(
              title: "Stress",
              solution: _carePlan["Low Stress"]!,
            )
          else if (UserData.stress_level == 2)
            CarePlanCard(
              title: "Stress",
              solution: _carePlan["Medium Stress"]!,
            )
          else if (UserData.stress_level == 3)
            CarePlanCard(
              title: "Stress",
              solution: _carePlan["High Stress"]!,
            )
        ],
      ),
    );
  }
}

class CarePlanCard extends StatefulWidget {
  final String title;
  final List<String> solution;

  const CarePlanCard({required this.title, required this.solution, super.key});

  @override
  State<CarePlanCard> createState() => _CarePlanCardState();
}

class _CarePlanCardState extends State<CarePlanCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      color: Colors.amber[50],
      child: Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < widget.solution.length; i++)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      widget.solution[i],
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
