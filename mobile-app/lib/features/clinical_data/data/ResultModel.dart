class ResultModel {
  final String diagnosis;
  final double riskScore;
  final String diagnosticMethod;
   var clinicalRisk;
   var ultrasoundRisk;
  final String? heatmapBase64;

  ResultModel({
    required this.diagnosis,
    required this.riskScore,
    required this.diagnosticMethod,
    required this.clinicalRisk,
    required this.ultrasoundRisk,
    this.heatmapBase64 ,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    final breakdown = json["breakdown"] ?? {};

    return ResultModel(
      diagnosis: json["diagnosis"] ?? "Unknown",
      riskScore: (json["overall_risk_score"] ?? 0).toDouble(),
      diagnosticMethod: json["diagnostic_method"] ?? "",


      clinicalRisk: (breakdown["clinical_risk"] ),
      ultrasoundRisk: (breakdown["ultrasound_risk"] ),

      heatmapBase64:
      json["explainability"]?["ultrasound_heatmap_base64"],
    );
  }
}