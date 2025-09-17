import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/pesanan_card.dart';
import 'package:bukulapak/pages/user/home.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    final TextEditingController _detailController = TextEditingController();
    final TextEditingController _alamatController = TextEditingController();

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
            customInputField(
              context: context,
              labelText: 'Jl. Bandung No 3, Malang',
              controller: _alamatController,
            ),
            
            customInputField(
              context: context,
              labelText: 'Detail (Cth : Pagar Hitam)',
              controller: _detailController,
            ),

            const SizedBox(height: 10),
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

                          // Update field isCheckout di database
                          await _service.updateCheckoutByJudul(
                            widget.text1,
                            true,
                          );

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

Widget customInputField({
  required BuildContext context,
  required String labelText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.01,
          vertical: screenHeight * 0.008,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'poppins',
              color: Colors.black54,
              fontSize: screenWidth * 0.03,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: darkWhite,
            filled: true,
          ),
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    ],
  );
}