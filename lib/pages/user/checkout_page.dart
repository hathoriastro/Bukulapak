import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/pesanan_card.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

enum OpsiPengiriman { JNE, LionParcel, SiCepat}

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
  bool isFavorite = false;
  OpsiPengiriman? _pengiriman = OpsiPengiriman.JNE;
  MetodeBayar? _bayar = MetodeBayar.qris;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: sizeheight * 112 / fullheight,
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
                    child: Icon(Icons.arrow_back),
                  ),
                  Text(
                    'Checkout',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(color: Colors.transparent, width: sizewidth * 0.1),
                ],
              ),
            ),
            SizedBox(height: sizeheight * 0.006),
            Divider(),
          ],
        ),
      ),
     body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PesananCard(
        coverbook: widget.coverbook,
        text1: widget.text1,
        text2: widget.text2,
        price: widget.price,
      ),

      const SizedBox(height: 25),

      // Address
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
                  Text("Nama || No Telp",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Lorem Ipsum Dolor", style: TextStyle(color: Colors.grey)),
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
        title: const Text('COD (Bayar ditempat)', style: TextStyle(fontSize: 12)),
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

      const SizedBox(height: 100), // biar ada spasi sebelum bottom bar
    ],
  ),
),


      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          height: sizeheight * 0.07,
          decoration: BoxDecoration(
            color: Color(0xFFD6D6E8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('TOTAL : ${widget.price}'),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(backgroundColor: orange),
                child: Text(
                  'Buat Pesanan',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
