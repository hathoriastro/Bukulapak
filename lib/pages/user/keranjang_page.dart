import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/keranjang_card.dart';
import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/pages/user/checkout_page.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

import '../../services/voucher_services.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  bool applyClicked = false;
  String? selectedId;
  int selectedPrice = 0;

  double? discountedPrice;
  final TextEditingController _couponController = TextEditingController();
  final VoucherServices voucherServices = VoucherServices();
  final TambahprodukService _tambah = TambahprodukService();
  List<KeranjangModel> _keranjangItems = [];

  String getDisplayPrice() {
    if (selectedId == null) {
      return 'Total: Rp0';
    }

    // Jika ada discount yang diterapkan
    if (discountedPrice != null) {
      if (discountedPrice == 0) {
        return 'Total: GRATIS';
      }
      return 'Total: Rp${discountedPrice!.toStringAsFixed(0)}';
    }

    // Jika tidak ada discount, gunakan harga asli
    if (selectedPrice == 0) {
      return 'Total: GRATIS';
    }

    return 'Total: Rp$selectedPrice';
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    final TambahprodukService _tambah = TambahprodukService();

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                            discountedPrice = null; // Reset discount
                            applyClicked = false; // Reset voucher state
                            _couponController.clear();
                          } else {
                            selectedId = item.id;
                            discountedPrice = null; // Reset discount saat pilih item baru
                            applyClicked = false; // Reset voucher state
                            _couponController.clear();

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
                        await _tambah.removeKeranjang(item.id!);
                        if (selectedId == item.id) {
                          setState(() {
                            selectedId = null;
                            selectedPrice = 0;
                            discountedPrice = null;
                            applyClicked = false;
                            _couponController.clear();
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
                    Expanded(
                      child: TextField(
                        controller: _couponController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your coupon',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        if (_couponController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Masukkan kode kupon dulu')),
                          );
                          return;
                        }

                        if (selectedId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Pilih produk dulu sebelum apply voucher')),
                          );
                          return;
                        }

                        try {
                          // Cari item yang dipilih
                          final selectedItem = _keranjangItems.firstWhere(
                                  (item) => item.id == selectedId,
                              orElse: () => throw Exception('Item tidak ditemukan')
                          );

                          // Log detail produk
                          print('=== PRODUK DIPILIH ===');
                          print('Document ID : ${selectedItem.id}');
                          print('Judul       : ${selectedItem.judul}');
                          print('Harga       : ${selectedItem.harga}');
                          print('Kategori    : ${selectedItem.kategori}');
                          print('======================');

                          // Apply voucher
                          final newPrice = await voucherServices.applyVoucher(
                            code: _couponController.text.trim(),
                            productID: selectedItem.judul,
                          );

                          print("Harga baru setelah diskon: $newPrice");

                          // Update UI dengan harga baru
                          setState(() {
                            discountedPrice = newPrice.toDouble();
                            applyClicked = true;
                          });

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                'Voucher berhasil diterapkan! Harga baru: ${newPrice == 0 ? "GRATIS" : "Rp${newPrice.toString()}"}',
                              ),
                            ),
                          );

                        } catch (e) {
                          print("Error saat apply voucher: $e");

                          // Reset state jika error
                          setState(() {
                            applyClicked = false;
                            discountedPrice = null;
                          });

                          // Show error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Error: ${e.toString()}'),
                            ),
                          );
                        }
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
