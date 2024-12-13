import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              height: 180,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Tasks",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.info_outline)
                          ],
                        ),
                        // SizedBox(height: height * 0.01),
                        Text(
                            "You marked 1 tasks as complete in\n this period."),
                        // SizedBox(height: height * 0.01),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Center(
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text("Last 7 days."),
                        SizedBox(height: height * 0.015),
                        Icon(
                          Icons.note_alt_rounded,
                          size: 60,
                          color: Colors.blue,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              height: 180,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Goals",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.info_outline)
                          ],
                        ),
                        // SizedBox(height: height * 0.01),
                        Text(
                            "You marked 1 goals as complete in\n this period."),
                        // SizedBox(height: height * 0.01),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Center(
                              child: Text(
                                "See all",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text("Last 7 days."),
                        SizedBox(height: height * 0.01),
                        Image.asset(
                          "lib/assets/images/img_1.png",
                          scale: 5,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
