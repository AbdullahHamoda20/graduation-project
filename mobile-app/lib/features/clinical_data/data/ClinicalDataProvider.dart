import 'dart:io';
import 'package:flutter/material.dart';
import '../data/pcos_data_models.dart';
import 'ClinicalRepository.dart';
import 'ResultModel.dart';

class ClinicalDataProvider extends ChangeNotifier {

  ClinicalDataModel _data = ClinicalDataModel();

  ClinicalDataModel get data => _data;

  File? get image => _data.ultrasoundImage;

  // ================= UPDATE IMAGE =================
  void setImage(File file) {
    _data.ultrasoundImage = file;
    notifyListeners();
  }

  // ================= GENERIC UPDATE (BEST PRACTICE) =================
  void update(ClinicalDataModel Function(ClinicalDataModel d) fn) {
    _data = fn(_data);
    notifyListeners();
  }

  // ================= DEMOGRAPHIC =================
  void setAge(int value) {
    _data.age = value;
    notifyListeners();
  }

  void setWeight(double value) {
    _data.weight = value;
    notifyListeners();
  }

  void setHeight(double value) {
    _data.height = value;
    notifyListeners();
  }

  void setBMI(double value) {
    _data.bmi = value;
    notifyListeners();
  }

  // ================= SYMPTOMS =================
  void setHairGrowth(bool v) {
    _data.hairGrowth = v;
    notifyListeners();
  }

  void setSkinDarkening(bool v) {
    _data.skinDarkening = v;
    notifyListeners();
  }

  void setWeightGain(bool v) {
    _data.weightGain = v;
    notifyListeners();
  }

  void setDifficultyLosingWeight(bool v) {
    _data.difficultyLosingWeight = v;
    notifyListeners();
  }

  void setPimples(bool v) {
    _data.pimples = v;
    notifyListeners();
  }

  void setHairLoss(bool v) {
    _data.hairLoss = v;
    notifyListeners();
  }

  void setMarriageStatus(int v) {
    _data.marriageStatus = v;
    notifyListeners();
  }
  // ================= MENSTRUAL =================
  void setCycle(bool v) {
    _data.menstrualCycleRegular = v;
    notifyListeners();
  }

  void setCycleLength(int v) {
    _data.averageCycleLength = v;
    notifyListeners();
  }



  // ================= LIFESTYLE =================
  void setFastFood(int v) {
    _data.fastFoodFrequency = v;
    notifyListeners();
  }

  void setExercise(bool v) {
    _data.regularPhysicalActivity = v;
    notifyListeners();
  }

  // ================= ULTRASOUND =================
  void setFollicles({int? l, int? r}) {
    if (l != null) _data.follicleNoL = l;
    if (r != null) _data.follicleNoR = r;
    notifyListeners();
  }

  // ================= HORMONES =================
  void setHormones({
    double? amh,
    double? lh,
    double? fsh,
    double? tsh,
  }) {
    if (amh != null) _data.amh = amh;
    if (lh != null) _data.lh = lh;
    if (fsh != null) _data.fsh = fsh;
    if (tsh != null) _data.tsh = tsh;
    notifyListeners();
  }

  // ================= VALIDATION =================
  bool canSubmit() {
    final json = _data.toApiJson();
    return json.isNotEmpty || image != null;
  }

  // ================= RESET =================
  void reset() {
    _data = ClinicalDataModel();
    // result = null;
    error = null;
    isLoading = false;
    notifyListeners();
  }

  // ================= API DATA =================

  ResultModel? result;
  bool isLoading = false;
  String? error;

  Future<void> submitData(ClinicalRepository repo) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      result = await repo.submit(_data); //  model
      if (_data.toApiJson().isEmpty && _data.ultrasoundImage == null) {
        throw Exception("Please fill at least one field or upload image");
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }



}