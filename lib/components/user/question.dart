class Question {
  final String text;
  final List<String> options;
  final int correct;
  Question(this.text, this.options, this.correct);
}

final questions = [
  Question("Gimana cara agar efektif ketika belajar lewat internet?",
      ["Nonton sambil scrolling medsos lain", "Percaya semua info tiktok apa adanya", "Skip materi susah", "Belajar dari sumber kredibel", 'Ga belajar'], 3),
  Question('Di dunia kerja sekarang, apa yang paling diliat perusahaan?',
      ['Skill nyata dan pengalaman', 'Ijazah doang', 'Nama sekolah/universitas hits', 'Banyak followers IG', 'Outfit waktu interview'],
      0),
  Question('Mana cara belajar yang paling efektif?',
      ['Baca buku semalam sebelum ujian', 'Latihan soal rutin & review catatan', 'Hafalin semua kata demi kata', 'Belajar sambil marathon drama', 'Mengandalkan contekan'],
      1),
  Question('Kapan waktu istirahan paling ideal biar otak ga meledak',
      ['Tiap 25-30 menit, pakai teknik podomoro', 'ga perlu istirahat, biar cepet selesai', 'setiap 6-12 jam', 'cuma istirahat kalo udah pusing', 'belajar sambil main game terus'],
      0),
  Question('Apa yang penting dipelajari biar siap sama dunia yang serba digital?',
      ['Coding dan literasi digital', 'Trik viral di medsos doang', 'Cara ngerjain tugas pake AI tanpa belajar', 'Gosip seleb internasional', 'Cheat game online'],
      0)
];