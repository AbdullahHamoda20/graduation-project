class ClinicalDataModel {

  // ================= Demographic =================
  int? age;
  double? weight;
  double? height;
  double? bmi;

  // ================= Lifestyle =================
  int? fastFoodFrequency; // 0-3 (Rarely → Every day)
  bool? regularPhysicalActivity;

  // ================= Menstrual =================
  bool? menstrualCycleRegular;
  int? averageCycleLength;

  // ================= Symptoms =================
  bool? hairGrowth;
  bool? skinDarkening;
  bool? weightGain;
  bool? difficultyLosingWeight;
  bool? pimples;
  bool? hairLoss;

  // ================= Body Measurements =================
  double? waistInch;
  double? hipInch;

  // ================= Vitals =================
  int? pulseRate;
  int? respiratoryRate;

  // ================= Blood =================
  int? bloodGroup;
  int? systolicBP;
  int? diastolicBP;

  // ================= Reproductive =================
  int? maritalStatusYears;
  bool? isPregnant;
  int? noOfAbortions;

  ClinicalDataModel({
    this.age,
    this.weight,
    this.height,
    this.bmi,
    this.fastFoodFrequency,
    this.regularPhysicalActivity,
    this.menstrualCycleRegular,
    this.averageCycleLength,
    this.hairGrowth,
    this.skinDarkening,
    this.weightGain,
    this.difficultyLosingWeight,
    this.pimples,
    this.hairLoss,
    this.waistInch,
    this.hipInch,
    this.pulseRate,
    this.respiratoryRate,
    this.bloodGroup,
    this.systolicBP,
    this.diastolicBP,
    this.maritalStatusYears,
    this.isPregnant,
    this.noOfAbortions,
  });

  // ================= Convert for Flutter usage =================
  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "weight": weight,
      "height": height,
      "bmi": bmi,
      "fastFoodFrequency": fastFoodFrequency,
      "regularPhysicalActivity": regularPhysicalActivity,
      "menstrualCycleRegular": menstrualCycleRegular,
      "averageCycleLength": averageCycleLength,
      "hairGrowth": hairGrowth,
      "skinDarkening": skinDarkening,
      "weightGain": weightGain,
      "difficultyLosingWeight": difficultyLosingWeight,
      "pimples": pimples,
      "hairLoss": hairLoss,
      "waistInch": waistInch,
      "hipInch": hipInch,
      "pulseRate": pulseRate,
      "respiratoryRate": respiratoryRate,
      "bloodGroup": bloodGroup,
      "systolicBP": systolicBP,
      "diastolicBP": diastolicBP,
      "maritalStatusYears": maritalStatusYears,
      "isPregnant": isPregnant,
      "noOfAbortions": noOfAbortions,
    };
  }

  // ================= Convert for Backend / ML API =================
  Map<String, dynamic> toApiJson() {
    return {
      "Age (yrs)": age,
      "Weight (Kg)": weight,
      "Height(cm)": height,
      "BMI": bmi,

      "Fast food (Y/N)": fastFoodFrequency,

      "Reg.Exercise(Y/N)": regularPhysicalActivity == true ? 1 : 0,

      "hair growth(Y/N)": hairGrowth == true ? 1 : 0,
      "Skin darkening (Y/N)": skinDarkening == true ? 1 : 0,
      "Hair loss(Y/N)": hairLoss == true ? 1 : 0,
      "Pimples(Y/N)": pimples == true ? 1 : 0,
      "Weight gain(Y/N)": weightGain == true ? 1 : 0,
      "Difficulty Losing Weight(Y/N)": difficultyLosingWeight == true ? 1 : 0,

      "Pregnant(Y/N)": isPregnant == true ? 1 : 0,

      "No. of aborptions": noOfAbortions,

      "Pulse rate(bpm)": pulseRate,
      "RR (breaths/min)": respiratoryRate,

      "Blood Group": bloodGroup,

      "BP_Systolic": systolicBP,
      "BP_Diastolic": diastolicBP,

      "Marraige Status (Yrs)": maritalStatusYears,

      "Waist(cm)": waistInch,
      "Hip(cm)": hipInch,
    };
  }

  @override
  String toString() {
    return '''
ClinicalDataModel {
  age: $age,
  weight: $weight,
  height: $height,
  bmi: $bmi,
  fastFoodFrequency: $fastFoodFrequency,
  regularPhysicalActivity: $regularPhysicalActivity,
  menstrualCycleRegular: $menstrualCycleRegular,
  averageCycleLength: $averageCycleLength,
  hairGrowth: $hairGrowth,
  skinDarkening: $skinDarkening,
  weightGain: $weightGain,
  difficultyLosingWeight: $difficultyLosingWeight,
  pimples: $pimples,
  hairLoss: $hairLoss,
  waistInch: $waistInch,
  hipInch: $hipInch,
  pulseRate: $pulseRate,
  respiratoryRate: $respiratoryRate,
  bloodGroup: $bloodGroup,
  systolicBP: $systolicBP,
  diastolicBP: $diastolicBP,
  maritalStatusYears: $maritalStatusYears,
  isPregnant: $isPregnant,
  noOfAbortions: $noOfAbortions
}
''';
  }
}