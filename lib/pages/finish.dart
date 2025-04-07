import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class MyFinish extends StatelessWidget {
  const MyFinish({super.key});

  Future<void> _shareImage(BuildContext context) async {
    try {
      final byteData = await rootBundle.load('assets/invitation_sample.png');  // Placeholder for file
      final Uint8List bytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/invitation.png').create();
      await file.writeAsBytes(bytes);

      await Share.shareXFiles([XFile(file.path)], text: 'Jemput hadir ke majlis kami 💍');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal untuk kongsi: $e')),
      );
    }
  }

  Future<void> _downloadImage(BuildContext context) async {
    try {
      final byteData = await rootBundle.load('assets/invitation_sample.png');  // Placeholder for file
      final Uint8List bytes = byteData.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(bytes, quality: 100, name: "Kad_Jemputan");
      if (result['isSuccess']) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kad berjaya disimpan ke galeri!')),
        );
      } else {
        throw Exception("Gagal simpan");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal untuk simpan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Kad Siap', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Kad jemputan awak sudah siap.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                fontFamily: 'Parisienne',
                color: Color(0xFFB68D40),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://cdn.pixabay.com/photo/2025/03/24/06/51/pre-wedding-9490176_1280.jpg', // Gambar sementara dari internet
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _downloadImage(context),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text('Muat Turun'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB68D40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _shareImage(context),
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text('Kongsi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB68D40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
