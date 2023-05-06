class UserData {
  static DateTime? due_date;
  static DateTime? last_period;
  static int weeks = 0;
  static int days = 0;
  static int age = 0;
  static double weight = 0;
  static double height = 0;
  static double bmi = 0;
  // blood pressure = systolic/diastolic
  static int systolic_blood_pressure = 0;
  static int diastolic_blood_pressure = 0; 
  static int sugar_level = 0; // mg/DL
  static int stress_level = 0;

  static double temperature = 0;
  static int heart_rate = 0;
  // high risk, medium risk, low risk
  static String risk = '';

  static int no_of_pregnancy = 0;
  static bool gestation_in_previous = false;
  static int HDL = 0;
  // history of family members with diabetes
  static bool family_history = false;
  static bool unexplained_prenetal_loss = false;
  static bool large_child_or_birth_default = false;
  // polycystic ovarian syndrome
  static bool PCOS = false;
  static double hemoglobin = 0;
  static bool sedentary_lifestyle = false;
  static bool prediabetes = false;

  static DateTime? last_filled;
}