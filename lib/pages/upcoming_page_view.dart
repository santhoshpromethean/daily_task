import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.lightBlue,
      Colors.orangeAccent,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.lightGreen,
      Colors.redAccent,
    ];
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('tasksandgoals').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final tasks = snapshot.data?.docs;
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 18.0,
              mainAxisSpacing: 18.0,
              childAspectRatio: 7 / 7,
            ),
            itemCount: tasks!.length,
            itemBuilder: (context, index) {
              final doc = tasks[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      height: 25,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doc["title"] ?? "No Title",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Text(
                      "Priority: ${doc["priority"] ?? "N/A"}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateTime.parse(doc["time"])
                              .isBefore(DateTime.now().add(Duration(days: 1)))
                          ? "Time left: ${DateFormat('HH').format(DateTime.parse(doc["time"]))} hours."
                          : "Time left: ${DateTime.parse(doc["time"]).difference(DateTime.now()).inDays} days",
                      style: TextStyle(
                        fontSize: 14,
                        color: (doc["priority"] == "High")
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}