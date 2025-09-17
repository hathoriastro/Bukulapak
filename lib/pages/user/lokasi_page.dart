import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class LokasiPage extends StatelessWidget {
  const LokasiPage({super.key});

  final Map<String, List<String>> provinsiByPulau = const {
    "Sumatera": [
      "Aceh",
      "Sumatera Utara",
      "Sumatera Barat",
      "Riau",
      "Kepulauan Riau",
      "Jambi",
      "Sumatera Selatan",
      "Bangka Belitung",
      "Bengkulu",
      "Lampung",
    ],
    "Jawa": [
      "DKI Jakarta",
      "Banten",
      "Jawa Barat",
      "Jawa Tengah",
      "DI Yogyakarta",
      "Jawa Timur",
    ],
    "Kalimantan": [
      "Kalimantan Barat",
      "Kalimantan Tengah",
      "Kalimantan Selatan",
      "Kalimantan Timur",
      "Kalimantan Utara",
    ],
    "Sulawesi": [
      "Sulawesi Utara",
      "Gorontalo",
      "Sulawesi Tengah",
      "Sulawesi Barat",
      "Sulawesi Selatan",
      "Sulawesi Tenggara",
    ],
    "Bali & Nusa Tenggara": [
      "Bali",
      "Nusa Tenggara Barat",
      "Nusa Tenggara Timur",
    ],
    "Maluku & Papua": [
      "Maluku",
      "Maluku Utara",
      "Papua",
      "Papua Barat",
      "Papua Barat Daya",
      "Papua Tengah",
      "Papua Pegunungan",
      "Papua Selatan",
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Pilih Lokasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: provinsiByPulau.entries.map((entry) {
          final pulau = entry.key;
          final provinsiList = entry.value;

          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Pulau
                Text(
                  pulau,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),

                // Scrollable list provinsi per pulau
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(provinsiList.length, (index) {
                      final provinsi = provinsiList[index];
                      final isEven = index % 2 == 0;
                      final color = isEven ? darkBlue : darkBlue;

                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          provinsi,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
