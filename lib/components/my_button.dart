import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData? icon; // Menggunakan IconData untuk ikon opsional
  final Color? color; // Warna opsional untuk tombol

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: color ??
              const Color(0xFF7973FF), // Warna default jika tidak diatur
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // Jika ikon tersedia
              Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Jarak ikon dengan teks
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
