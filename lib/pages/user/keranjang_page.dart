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

  List<KeranjangModel> _keranjangItems = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    final TambahprodukService _tambah = TambahprodukService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
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

                _keranjangItems = snapshot.data!;

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: _keranjangItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = _keranjangItems[index];
                    return KeranjangCard(
                      keranjangItem: item,
                      isSelected: selectedId == item.id,
                      onTap: () {
                        if (item.isCheckout) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Produk sudah habis')),
                          );
                          return;
                        }
                        setState(() {
                          if (selectedId == item.id) {
                            selectedId = null;
                            selectedPrice = 0;
                          } else {
                            selectedId = item.id;
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
            // kupon
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
                            style: const TextStyle(
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
            const SizedBox(height: 10),
            // checkout
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
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: sizewidth * 120 / fullwidth,
                        height: sizeheight * 46 / fullheight,
                        child: GestureDetector(
                          onTap: () async {
                            if (selectedId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: orange,
                                  content: Text(
                                    'Pilih item dulu sebelum checkout',
                                  ),
                                ),
                              );
                              return;
                            }

                            // cari item yang dipilih
                            KeranjangModel? activeItem;
                            try {
                              activeItem = _keranjangItems.firstWhere(
                                (item) =>
                                    item.id == selectedId && !item.isCheckout,
                              );
                            } catch (e) {
                              activeItem = null;
                            }

                            if (activeItem == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Produk sudah habis atau tidak bisa di-checkout',
                                  ),
                                ),
                              );
                              return;
                            }

                            //Update Firestore dulu biar hilang dari keranjang
                            await _tambah.updateCheckoutInKeranjangById(
                              activeItem.id,
                              true,
                            );

                            // baru lanjut ke halaman Checkout
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckoutPage(
                                  coverbook: activeItem!.gambar,
                                  text1: activeItem.judul,
                                  text2: activeItem.kategori,
                                  price: activeItem.harga,
                                ),
                              ),
                            );
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color: customorange,
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
                        ),
                      ),
                    ),
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
