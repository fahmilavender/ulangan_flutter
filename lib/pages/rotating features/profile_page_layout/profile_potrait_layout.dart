import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/logout_controller.dart';

class ProfilePortraitLayout extends StatelessWidget {
  ProfilePortraitLayout({super.key});

  final controller = Get.find<LogoutController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 20),
          decoration: const BoxDecoration(
            color: Customcolors.bluecontainer,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
          child: const Center(
            child: Text(
              "Profile",
              style: TextStyle(
                color: Customcolors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Customcolors.background,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage("assets/images/Raff.jpg"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama: Raffaditya Alvaro",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Kelas: 11 PPLG 2"),
                            Text("Absen: 28"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Customcolors.background,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage("assets/images/fahmi.jpg"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama: Shidqi Dzil Fahmi",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Kelas: 11 PPLG 2"),
                            Text("Absen: 33"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              Container(padding: const EdgeInsets.only(top: 120)),
                CustomButton(
                  myText: "Logout",
                  myTextColor: Customcolors.white,
                  backgroundColor: Customcolors.bluewidget,
                  onPressed: () {
                    controller.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
