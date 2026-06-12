import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../clinical_data/data/ClinicalDataProvider.dart';

class HeatmapResultScreen extends StatelessWidget {
  const HeatmapResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClinicalDataProvider>();

    final result = provider.result;

    final image = result?.heatmapBase64;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },

          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),

        title: const Text(
          "Heat Map Image",

          style: TextStyle(
            color: Color(0xffDA5F71),
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),

        centerTitle: true,
      ),

      body: image == null
          ? const Center(child: Text("No Heatmap Available"))
          : InteractiveViewer(
              minScale: 0.5,
              maxScale: 5,

              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Image.memory(
                    base64Decode(image.split(',').last),

                    fit: BoxFit.contain,

                    errorBuilder: (context, error, stackTrace) {
                      debugPrint(error.toString());

                      return const Text("Failed To Load Image");
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
