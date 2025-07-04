import 'package:emekteb_mobile/Screens/arhiv_ucenika_screen.dart';
import 'package:emekteb_mobile/Screens/pregled_ocjena_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_IIINivo_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_IINivo_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_INivo_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_hatma_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_insert_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_sufara_screen.dart';
import 'package:emekteb_mobile/Screens/ucenici_tedzvid_screen.dart';
import 'package:emekteb_mobile/Widgets/master_screen.dart';
import 'package:flutter/material.dart';

class SelectUcenici extends StatefulWidget {
  const SelectUcenici({super.key});

  @override
  State<SelectUcenici> createState() => _SelectUceniciState();
}

class _SelectUceniciState extends State<SelectUcenici> {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Učenici",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    _buildAddButton(),
                    SizedBox(height: 20),
                    _buildLevelButtons(context),
                    SizedBox(height: 20),
                    _buildAllStudentsButton(),
                    //SizedBox(height: 20),
                   // _buildOcjeneButton(),
                  ],
                ),
              ),
            ),
          ],
        ),

    );
  }

  // Widget for the "+ Učenik" button
  Widget _buildAddButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(

          backgroundColor: Colors.lightGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => UceniciInsert(),
            ),
          );

        },
        child: const Text(
          '+ Učenik',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAllStudentsButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF88C0D0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Ucenici(),
          ),
        );
      },
      child: const Text(
        'Svi učenici',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  //Widget _buildOcjeneButton() {
  //  return ElevatedButton(
  //    style: ElevatedButton.styleFrom(
  //      backgroundColor: Color(0xFF8D88D0),
  //      shape: RoundedRectangleBorder(
  //        borderRadius: BorderRadius.circular(20),
  //      ),
  //      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
  //    ),
  //    onPressed: () {
  //      Navigator.of(context).push(
  //        MaterialPageRoute(
  //          builder: (context) => const Ocjene(),
  //        ),
  //      );
  //    },
  //    child: const Text(
  //      'Ocjene',
  //      style: TextStyle(fontSize: 18, color: Colors.white),
  //    ),
  //  );
  //}
  // Widget for level buttons (e.g., I nivo, II nivo, etc.)
  Widget _buildLevelButtons(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<String> levels = [
      'I nivo',
      'II nivo',
      'III nivo',
      'Sufara',
      'Tedžvid',
      'Hatma',
      'Arhiv'
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: levels.map((level) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: SizedBox(
            width: screenWidth * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 36.0, vertical: 12.0),
              ),
              onPressed: () {
                _navigateToLevelPage(
                    context, level); // Call the navigation method
              },
              child: Text(
                level,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _navigateToLevelPage(BuildContext context, String level) {
    // Determine which page to navigate to based on the level
    Widget destinationPage;

    switch (level) {
      case 'I nivo':
        destinationPage = UceniciINivo(); // Replace with your actual page widget
        break;
      case 'II nivo':
        destinationPage = UceniciIINivo(); // Replace with your actual page widget
        break;
      case 'III nivo':
        destinationPage = UceniciIIINivo(); // Replace with your actual page widget
        break;
      case 'Sufara':
        destinationPage = UceniciSufara(); // Replace with your actual page widget
        break;
      case 'Tedžvid':
        destinationPage = UceniciTedzvid(); // Replace with your actual page widget
        break;
      case 'Hatma':
        destinationPage = UceniciHatma(); // Replace with your actual page widget
        break;
        case 'Arhiv':
        destinationPage = UceniciArhiv(); // Replace with your actual page widget
        break;
      default:
        return; // If level does not match, do nothing
    }

    // Use Navigator.push to navigate to the selected page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    );
  }

}
