import 'dart:io';

class ClinicalDataModel {

  // ================= Demographic =================
  int? age;
  double? weight;
  double? height;
  double? bmi;

  // ================= Lifestyle =================
  int? fastFoodFrequency;
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

  // ================= Ultrasound =================
  int? follicleNoL;
  int? follicleNoR;

  // ================= Reproductive =================
  int? marriageStatus;

  // ================= Hormones =================
  double? amh;
  double? lh;
  double? fsh;
  double? tsh;

  // ================= Image =================
  File? ultrasoundImage;

  ClinicalDataModel();

  Map<String, dynamic> toApiJson() {
    final data = {
      "Age (yrs)": age,
      "Weight (Kg)": weight,
      "Height(Cm)": height,
      "BMI": bmi,

      "Fast food (Y/N)": fastFoodFrequency,

      "Reg.Exercise(Y/N)": regularPhysicalActivity == true ? 1 : 0,

      "Cycle(R/I)": menstrualCycleRegular == true ? 1:0,

      "Cycle length(days)": averageCycleLength,

      "hair growth(Y/N)": hairGrowth == true ? 1 : 0,
      "Skin darkening (Y/N)": skinDarkening == true ? 1 : 0,
      "Weight gain(Y/N)": weightGain == true ? 1 : 0,
      "Difficulty Losing Weight(Y/N)": difficultyLosingWeight == true ? 1 : 0,
      "Pimples(Y/N)": pimples == true ? 1 : 0,
      "Hair loss(Y/N)": hairLoss == true ? 1 : 0,

      "Follicle No. (L)": follicleNoL,
      "Follicle No. (R)": follicleNoR,

      "Marriage Status (Yrs)": marriageStatus,

      "AMH(ng/mL)": amh,
      "LH(mIU/mL)": lh,
      "FSH(mIU/mL)": fsh,
      "TSH (mIU/L)": tsh,
    };

    data.removeWhere((k, v) => v == null);
    return data;
  }
}