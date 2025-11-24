import 'package:flutter/material.dart';
import 'glass.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Glass(
        padding: const EdgeInsets.all(28),
        blur: 24,
        opacity: 0.12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tentang Saya',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text(
              'Halo, saya Aji. Saya berfokus dibidang data science, deep learning, dan pengembangan backend. Saya telah mengerjakan beberapa proyek, termasuk model CNN dengan interpretabilitas Grad-CAM, sistem enkripsi hybrid (AES-256, IPFS, dan smart contract), serta beberapa aplikasi layanan backend.'
              'Saya senang membangun solusi yang terstruktur, scalable, dan bisa dikembangkan lebih lanjut sesuai kebutuhan. Jika Anda tertarik berdiskusi atau berkolaborasi, silakan hubungi saya.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
