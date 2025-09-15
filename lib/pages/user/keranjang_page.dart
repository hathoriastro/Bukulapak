import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/keranjang_card.dart';

import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/pages/user/checkout_page.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool applyClicked = false;
  String? selectedId;
  int selectedPrice = 0;
  KeranjangModel? _selectedKeranjang;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    TambahprodukService _tambah = TambahprodukService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            'Keranjang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<KeranjangModel>>(
              stream: _tambah.getKeranjang(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Keranjang masih kosong"));
                }

                final keranjangItems = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: keranjangItems.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = keranjangItems[index];
                    return KeranjangCard(
                      keranjangItem: item,
                      isSelected: selectedId == item.id,
                      onTap: () {
                        setState(() {
                          if (selectedId == item.id) {
                            //kalau diklik lagi, unselect
                            selectedId = null;
                            selectedPrice = 0;
                          } else {
                            selectedId = item.id;

                            //handle harga GRATIS
                            if (item.harga.toLowerCase() == "gratis") {
                              selectedPrice = 0;
                            } else {
                              selectedPrice =
                                  int.tryParse(
                                    item.harga.replaceAll(
                                      RegExp(r'[^0-9]'),
                                      '',
                                    ),
                                  ) ??
                                  0;
                            }
                          }
                        });
                      },

                      onRemove: () async {
                        await _tambah.removeKeranjang(item.id);
                        if (selectedId == item.id) {
                          setState(() {
                            selectedId = null;
                            selectedPrice = 0;
                          });
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //KUPON
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: sizeheight * 81 / fullheight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.25),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/price-tag.png'),
                    const SizedBox(width: 10),
                    Text('Put Your Coupon', style: TextStyle(color: softgray)),
                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          applyClicked = !applyClicked;
                        });
                      },
                      child: Container(
                        width: sizewidth * 88 / fullwidth,
                        height: sizeheight * 46 / fullheight,
                        decoration: BoxDecoration(
                          color: applyClicked ? lightBlue : customorange,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: lightGray.withOpacity(0.5),
                              spreadRadius: 1.5,
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            applyClicked ? 'Applied' : 'Apply',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            //CHECKOUT
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: sizeheight * 81 / fullheight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.25),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      selectedId == null
                          ? 'Total: Rp0'
                          : (selectedPrice == 0
                                ? 'Total: GRATIS'
                                : 'Total: Rp$selectedPrice'),
                      style: TextStyle(
                        color: lightGray,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),

                    const Spacer(),
                   GestureDetector(
  onTap: () {
    if (_selectedKeranjang != null) {
      // Ada item yang dipilih → navigasi ke CheckoutPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutPage(coverbook: coverbook, text1: text1, text2: text2, price: price)
        ),
      );
    } else {
      // Tidak ada yang dipilih → tampilkan notif
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Pilih produk dulu sebelum checkout"),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  child: Container(
    width: sizewidth * 120 / fullwidth,
    height: sizeheight * 46 / fullheight,
    decoration: BoxDecoration(
      color: customorange,
      borderRadius: BorderRadius.circular(28),
      boxShadow: [
        BoxShadow(
          color: lightGray.withOpacity(0.5),
          spreadRadius: 1.5,
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        'Checkout',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  ),
)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
