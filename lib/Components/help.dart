import 'dart:io';

import 'package:duds/Components/home.dart';
import 'package:duds/Components/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:duds/Components/uploadpreview_screen.dart';

import 'package:duds/Components/rooms.dart';

void main() {
  runApp(HelpPage());
}

class HelpPage extends StatefulWidget {
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late int currentIndex;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 100, 64),
            title: const Text('FAQ'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(
                    context, '/homebar'); // Kembali ke halaman sebelumnya
              },
            )),
        body: const Steps(),
      );
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step('Mengapa saya tidak bisa membuat pesanan di checkout?', 'answer'),
    Step('Mengapa saya tidak bisa login ke akun BigFood saya?',
        '1. Pastikan password dan email yang dimasukan sudah benar, 2. Apakah anda sudah 5 kali berturut-turut salah password? jika ya, akun ada sudah terblokir sehingga anda tidak dapat login ke akun BigFood anda, 3. Jika lupa Password, anda bisa melakukan `reset password`'),
    Step('Bagaimana cara memperbarui profile saya?',
        'Untuk memperbarui profile, anda bisa klik `ProfilePage` di kanan bawah'),
    Step('Dapatkah akun BigFood saya masuk di beberapa perangkat?',
        'Ya, akun BigFood anda dapat masuk dan digunakan di beberapa perangkat'),
    Step('Bagaimana cara menyimpan pesanan di keranjang',
        'Anda dapat membuka halaman `home` kami lalu mengklik tanda `+` untuk menambah menu lalu `-` untuk menurangi menu'),
    Step('Bagaimana cara mengatur ulang akun BigFood saya jika lupa password?',
        'Anda dapat melakukan `reset password` dihalaman login'),
    Step('Apakah saya dapat mengubah metode pembayaran?',
        'Ya bisa, anda dapat mengubah metode pembayaran pada saat checkout'),
    Step('Bagaimana cara menghapus akun BigFood?',
        '1. Anda dapat membuka halaman `ProfilePage`, 2. Setelah itu anda dapat klik `Delete Account` untuk menghapus akun BigFood anda'),
    Step('Bisakah saya mengganti menu setelah pemesanan terbuat?',
        'Tidak, anda tidak dapat mengganti menu saat pesanan terbuat. Oleh sebab itu perhatikan menu dan jumlah sebelum anda checkout'),
    Step('Dimana saya melapor jika terjadi kendala dalam hal pembayaran?',
        'Untuk kendala pembayaran, anda bisa menghubungi bigfood@gmail.com atau hubungi cs kami 08...'),
    Step(
        'Aplikasi tidak dapat terbuka, tiba tiba tertutup atau muncul kode error',
        'Perhatikan informasi yang diberikan dari error, pastikan benar'),
    Step('Saya tidak mendapatkan email untuk reset password',
        '1. Pastikan email anda benar, 2. Anda bisa `refresh` halaman email anda, 3. Anda juga bisa cek halaman `all mail` di email anda'),
    Step('Akun saya terblokir',
        'Akun anda akan terblokir apabila anda salah memasukan password sebanyak 5 kali berturut-turut saat melakukan login'),
    Step('Pendaftaran BigFood saya bermasalah',
        'Pastikan Username dan Email anda belum pernah terpakai'),
    Step('Bisakah saya menghapus riwayat pemesanan saya?',
        'Tidak, anda tidak dapat menghapus riwayat pemesanan anda'),
    Step('Bagaimana cara mengajukan keluhan?',
        'Dapat melaporkan ke bigfood@gmail.com'),
    Step('Bagaimana kontak driver?', 'Dapat melalui fitur Chat'),
    Step('Lapor kendala pembayaran',
        'Untuk kendala pembayaran, anda bisa menghubungi bigfood@gmail.com atau hubungi cs kami 08...'),
    Step('Bagaimana cara melakukan check out pesanan saya?',
        'Untuk melakukan checkout pesanan, anda dapat klik halaman `checkout` pada aplikasi kami, lalu anda bisa melakukan pembayaran untuk checkout'),
  ];
}

class Steps extends StatefulWidget {
  const Steps({Key? key}) : super(key: key);
  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _renderSteps(),
      ),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(step.title),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}
