import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/modul_card.dart';
import 'package:bukulapak/pages/user/pdfmodul_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

class ModulTabPage extends StatefulWidget {
  const ModulTabPage({super.key});

  @override
  State<ModulTabPage> createState() => _ModulTabPageState();
}

class _ModulTabPageState extends State<ModulTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> text = ["SD", "SMP", "SMA"];
  final List<Color> activeColors = [sd, smp, sma];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: text.length, vsync: this);
    _tabController.addListener(() {
      setState(() {}); //update warna aktif ketika tab berubah
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //ambil data modul berdasar jenjang nya
  // Stream<List<Map<String, dynamic>>> getModulStream(String jenjang) async* {
  //   final firestore = FirebaseFirestore.instance;
  //   final modulSnapshot = await firestore.collection('modul').get();

  //   List<Map<String, dynamic>> modulList = [];
  //   for (var modulDoc in modulSnapshot.docs) {
  //     if (modulDoc['jenjang'] == jenjang) {
  //       final pdfSnapshot = await firestore
  //           .collection('modul')
  //           .doc(modulDoc.id)
  //           .collection('modul_pdf')
  //           .get();

  //       for (var pdf in pdfSnapshot.docs) {
  //         modulList.add(pdf.data());
  //       }
  //     }
  //   }
  //   yield modulList;
  // }

  Stream<List<Map<String, dynamic>>> getModulStream(String jenjang) {
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection('modul')
      .where('jenjang', isEqualTo: jenjang)
      .snapshots()
      .asyncMap((modulSnapshot) async {
        List<Map<String, dynamic>> modulList = [];

        for (var modulDoc in modulSnapshot.docs) {
          final pdfSnapshot = await firestore
              .collection('modul')
              .doc(modulDoc.id)
              .collection('modul_pdf')
              .get();

          for (var pdf in pdfSnapshot.docs) {
            modulList.add(pdf.data());
          }
        }

        return modulList;
      });
}


  @override
  Widget build(BuildContext context) {
    final double sizeWidth = MediaQuery.of(context).size.width;
    const double fullWidth = 430;

    return DefaultTabController(
      length: text.length,
      child: Column(
        children: [
          ButtonsTabBar(
            controller: _tabController,
            backgroundColor: activeColors[_tabController.index],
            contentCenter: true,
            width: sizeWidth * 125 / fullWidth,
            height: 40,
            unselectedBackgroundColor: Colors.transparent,
            unselectedLabelStyle: const TextStyle(
              color: lightGray,
              fontWeight: FontWeight.w700,
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            borderWidth: 2,
            borderColor: activeColors[_tabController.index],
            unselectedBorderColor: lightGray,
            radius: 30,
            tabs: List.generate(
              text.length,
              (index) => Tab(
                child: Text(
                  text[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _tabController.index == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: text.map((jenjang) {
                return StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getModulStream(jenjang),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Modul Masih Diproses"));
                    }

                    final data = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 12,
                      children: data.map((modul) {
                        return ModulCard(
                          title: modul['judul'],
                          image: modul['coverUrl'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfViewerPage(
                                  title: modul['judul'],
                                  pdfUrl: modul['pdfUrl'],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}


