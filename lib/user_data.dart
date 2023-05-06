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
  static int gestation_in_previous = 0; // boolean
  static int HDL = 0;
  // history of family members with diabetes
  static int family_history = 0; // boolean
  static int unexplained_prenetal_loss = 0; // boolean
  static int large_child_or_birth_default = 0; // boolean
  // polycystic ovarian syndrome
  static int PCOS = 0; // boolean
  static double hemoglobin = 0;
  static int sedentary_lifestyle = 0; // boolean
  static int prediabetes = 0; // boolean
  static String dia_gdm = ''; // boolean

  static int presentation_breech = 0; // boolean
  static int presentation_cephalic = 0; // boolean
  static int presentation_other = 0; // boolean
  static int placenta_previa = 0; // boolean
  static int amniotic_anhydramnios = 0; // boolean
  static int amniotic_normal = 0; // boolean
  static int hypertension_pih = 0; // boolean
  static int hypertension_nil = 0; // boolean
  static int diabetes_gdm = 0; // boolean
  static int diabetes_nil = 0; // boolean

  static DateTime? last_filled;
}