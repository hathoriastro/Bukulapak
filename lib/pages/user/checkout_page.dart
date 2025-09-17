import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/pesanan_card.dart';
import 'package:bukulapak/pages/user/home.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum OpsiPengiriman { JNE, LionParcel, SiCepat }

enum MetodeBayar { cod, qris }

class CheckoutPage extends StatefulWidget {
  final String coverbook;
  final String text1;
  final String text2;
  final String price;

  const CheckoutPage({
    super.key,
    required this.coverbook,
    required this.text1,
    required this.text2,
    required this.price,
  });

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  OpsiPengiriman? _pengiriman = OpsiPengiriman.JNE;
  MetodeBayar? _bayar = MetodeBayar.qris;
  final TambahprodukService _service = TambahprodukService();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    String angkaBersih = widget.price.replaceAll(RegExp(r'[^0-9]'), '');
    int harga = angkaBersih.isEmpty ? 0 : int.parse(angkaBersih);
    int ongkir = 7000;
    int totalPrice = harga + ongkir;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: sizeheight * 0.12,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.001),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(color: Colors.transparent, width: size.width * 0.1),
                ],
              ),
            ),
            SizedBox(height: sizeheight * 0.006),
            const Divider(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Pesanan
            PesananCard(
              coverbook: widget.coverbook,
              text1: widget.text1,
              text2: widget.text2,
              price: widget.price,
            ),

            const SizedBox(height: 25),

            // Alamat
            Row(
              children: const [
                Icon(Icons.location_on, color: darkBlue),
                SizedBox(width: 8),
                Text(
                  'Alamat Tujuan',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: sizeheight * 0.2,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, color: Colors.grey),
                        SizedBox(width: 8),
                        Text(
                          "Nama || No Telp",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Lorem Ipsum Dolor",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Opsi Pengiriman
            Row(
              children: const [
                Icon(Icons.delivery_dining_rounded, color: darkBlue),
                SizedBox(width: 8),
                Text(
                  'Opsi Pengiriman',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            RadioListTile<OpsiPengiriman>(
              title: const Text('JNE', style: TextStyle(fontSize: 12)),
              value: OpsiPengiriman.JNE,
              groupValue: _pengiriman,
              onChanged: (val) => setState(() => _pengiriman = val),
            ),
            RadioListTile<OpsiPengiriman>(
              title: const Text('LionParcel', style: TextStyle(fontSize: 12)),
              value: OpsiPengiriman.LionParcel,
              groupValue: _pengiriman,
              onChanged: (val) => setState(() => _pengiriman = val),
            ),
            RadioListTile<OpsiPengiriman>(
              title: const Text('SiCepat', style: TextStyle(fontSize: 12)),
              value: OpsiPengiriman.SiCepat,
              groupValue: _pengiriman,
              onChanged: (val) => setState(() => _pengiriman = val),
            ),

            const Divider(),

            // Metode Pembayaran
            Row(
              children: const [
                Icon(Icons.account_balance_wallet, color: darkBlue),
                SizedBox(width: 8),
                Text(
                  'Metode Pembayaran',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            RadioListTile<MetodeBayar>(
              title: const Text(
                'COD (Bayar ditempat)',
                style: TextStyle(fontSize: 12),
              ),
              value: MetodeBayar.cod,
              groupValue: _bayar,
              onChanged: (val) => setState(() => _bayar = val),
            ),
            RadioListTile<MetodeBayar>(
              title: const Text('QRIS', style: TextStyle(fontSize: 12)),
              value: MetodeBayar.qris,
              groupValue: _bayar,
              onChanged: (val) => setState(() => _bayar = val),
            ),
            const Divider(),

            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Harga Buku',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rp$harga',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Ongkos Pengiriman',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Rp$ongkir',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Point Anda',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Text(
                  '-',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Pembayaran',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Rp$totalPrice',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30), // spasi sebelum bottom bar
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            height: sizeheight * 0.07,
            decoration: BoxDecoration(
              color: const Color(0xFFD6D6E8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('TOTAL : Rp$totalPrice'),
                FilledButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          setState(() {
                            _loading = true;
                          });

                          // Update keranjang berdasarkan productId
        // await _service.checkoutByProductId(widget.productId);
      
        // cari dokumen keranjang
        final keranjangRef = await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('tambah_keranjang')
            .where('judul', isEqualTo: widget.text1) // filter pakai judul / unik field lain
            .get();

            if (keranjangRef.docs.isNotEmpty) {
  final docId = keranjangRef.docs.first.id;

  // update status di keranjang
  await _service.updateCheckoutInKeranjangById(docId, true);

  // cari produk dengan judul yang sama lalu update juga
  final produkRef = await FirebaseFirestore.instance
      .collection('produk')
      .where('judul', isEqualTo: widget.text1)
      .get();

  for (var doc in produkRef.docs) {
    await doc.reference.update({'isCheckout': true});
  }
}


//         if (keranjangRef.docs.isNotEmpty) {
//           // ambil id dokumen keranjang
//           final docId = keranjangRef.docs.first.id;

//           // update status checkout pakai service
//           await _service.checkoutByProductId(docId);
//         }

// if (keranjangRef.docs.isNotEmpty) {
//   final docId = keranjangRef.docs.first.id;
//   await _service.updateCheckoutInKeranjangById(docId, true);
// }



                          if (!mounted) return;
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SizedBox(
                                width: sizewidth * 330 / fullwidth,
                                height: sizeheight * 330 / fullheight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, 
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // horizontal tengah
                                  children: [
                                    // Gambar
                                    Image.asset(
                                      'assets/images/paket_pesan.png',
                                      height: sizeheight * 170 / fullheight,
                                      fit: BoxFit.contain,
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ), 
                                    
                                    Text(
                                      "Pesananmu Berhasil Dibuat!",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: orange,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ), 
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 130,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: lightBlue,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'OKE',
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
                          );

                          // Future.delayed(const Duration(seconds: 1), () {
                          //   Navigator.pushAndRemoveUntil(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const HomePage(),
                          //     ),
                          //     (route) => false,
                          //   );
                          // });
                        },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(120, 45),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Buat Pesanan',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
