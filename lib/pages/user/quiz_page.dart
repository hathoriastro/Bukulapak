import 'dart:async';
import 'package:bukulapak/services/quiz_services.dart';
import 'package:bukulapak/services/voucher_services.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../components/user/question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int index = 0;
  int correct = 0;
  int selected = -1;
  bool answered = false;

  late Timer timer;
  int timeLeft = 20;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        setState(() => timeLeft--);
      } else {
        next();
      }
    });
  }

  void choose(int i) {
    if (answered) return;
    setState(() {
      selected = i;
      answered = true;
      if (i == questions[index].correct) correct++;
    });
    Future.delayed(const Duration(seconds: 1), next);
  }

  Future<void> next() async {
    if (index < questions.length - 1) {
      setState(() {
        index++;
        selected = -1;
        answered = false;
        timeLeft = 20;
      });
    } else {
      String? voucherCode;
      if (correct == questions.length) {
        QuizServices quizServices = QuizServices();
        VoucherServices voucherServices = VoucherServices();
        await quizServices.saveQuiz(true);
        voucherCode = await voucherServices.generateVoucher();
        await voucherServices.saveVoucher(voucherCode);
      }
      timer.cancel();



      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 280,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/voucher1.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Yeey kamu dapet voucher',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  if (voucherCode != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Kode: $voucherCode',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A4D8C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:
                      GestureDetector(
                        onTap : () => Navigator.pushNamed(context, '/homepage'),
                      child: Text(
                        'Lanjut',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      )

                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Color optionColor(int i) {
    if (!answered) return Colors.white;
    if (i == questions[index].correct) return Colors.green.shade100;
    if (i == selected) return Colors.red.shade100;
    return Colors.white;
  }

  Icon? optionIcon(int i) {
    if (!answered) return null;
    if (i == questions[index].correct) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    if (i == selected) {
      return const Icon(Icons.cancel, color: Colors.red);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[index];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 16),
            decoration: const BoxDecoration(
              color: Color(0xFF0A4D8C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      correct.toString().padLeft(2, '0'),
                      style: const TextStyle(color: Colors.green, fontSize: 18),
                    ),
                    CircularPercentIndicator(
                      radius: 32,
                      percent: timeLeft / 20,
                      progressColor: Colors.orange,
                      backgroundColor: Colors.white24,
                      center: Text(
                        "$timeLeft",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      (index + 1).toString().padLeft(2, '0'),
                      style: const TextStyle(color: Colors.orange, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),


          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  // Card pertanyaan
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Question ${index + 1}/${questions.length}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          q.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),


                  ...List.generate(q.options.length, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: optionColor(i),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                        ),
                        onPressed: () => choose(i),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(q.options[i]),
                            if (optionIcon(i) != null) optionIcon(i)!,
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
