import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar(
      {super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final Function(int) onTap;
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: const Offset(0, 1),
          color: Colors.black.withOpacity(.25),
          blurRadius: 12,
        ),
      ]),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bag), label: 'Pesanan'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.layers), label: 'Riwayat'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Pengaturan'),
          ]),
    );
  }
}
