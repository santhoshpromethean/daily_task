import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _priorityController = TextEditingController();
  final TextEditingController _recurringController = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool showCalendar = false;

  Future<void> _saveTask(BuildContext context) async {
    final String title = _titleController.text.trim();
    final String location = _locationController.text.trim();
    // final String time = _timeController.text.trim();
    final String priority = _priorityController.text.trim();
    final String recurring = _recurringController.text.trim();

    if (title.isEmpty ||
        // time.isEmpty ||
        location.isEmpty ||
        priority.isEmpty ||
        recurring.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('tasksandgoals').add({
        'title': title,
        'location': location,
        // 'time': time,
        'priority': priority,
        'recurring': recurring,
        'time': _selectedDay?.toIso8601String() ?? '',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task added successfully")),
      );

      _titleController.clear();
      _locationController.clear();
      // _timeController.clear();
      _priorityController.clear();
      _recurringController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding task: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _priorityController.text = "High";
    _recurringController.text = "Never";
    _selectedDay = DateTime.now();
  }

  int _selectedPriorityIndex = 0;
  int _selectedRecurringIndex = 0;

  void _priorityPressed(int index) {
    setState(() {
      _selectedPriorityIndex = index;
      _priorityController.text = index == 0
          ? "High"
          : index == 1
              ? "Moderate"
              : "Low";
    });
  }

  void _recurringPressed(int index) {
    setState(() {
      _selectedRecurringIndex = index;
      _recurringController.text = index == 0
          ? "Never"
          : index == 1
              ? "Daily"
              : index == 2
                  ? "Weekly"
                  : "Monthly";
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          "New Task",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputField(
                labelText: 'Enter a Title',
                controller: _titleController,
                height: 60,
                width: width,
              ),
              SizedBox(height: height * 0.01),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select a time",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: 60,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDay != null
                                ? "${DateFormat('EEE, MMM d,').format(_selectedDay!)} ${DateFormat.jm().format(DateTime.now())}"
                                : "Select a date",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () =>
                                setState(() => showCalendar = !showCalendar),
                            icon: Icon(Icons.calendar_month_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (showCalendar)
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 20),
                  lastDay: DateTime.utc(2040, 10, 20),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  enabledDayPredicate: (day) => day.isAfter(
                      DateTime.now().subtract(const Duration(days: 1))),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      showCalendar = !showCalendar;
                      print(selectedDay);
                    });
                  },
                ),
              SizedBox(height: height * 0.01),
              CustomInputField(
                labelText: 'Enter a location (optional)',
                controller: _locationController,
                height: 60,
                width: width,
              ),
              SizedBox(height: height * 0.01),
              const Row(
                children: [
                  Text(
                    "Set Priority",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: 60,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 18.0),
                  child: Row(
                    children: [
                      CustomButton(
                        value: "High",
                        width: 90,
                        isSelected: _selectedPriorityIndex == 0,
                        onPressed: () => _priorityPressed(0),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: CustomButton(
                          width: 90,
                          value: "Moderate",
                          isSelected: _selectedPriorityIndex == 1,
                          onPressed: () => _priorityPressed(1),
                        ),
                      ),
                      CustomButton(
                        value: "Low",
                        width: 90,
                        isSelected: _selectedPriorityIndex == 2,
                        onPressed: () => _priorityPressed(2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              const Row(
                children: [
                  Text(
                    "Make recurring",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Container(
                height: 60,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 3,
                      spreadRadius: 0,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 18.0),
                  child: Row(
                    children: [
                      CustomButton(
                        value: "Never",
                        isSelected: _selectedRecurringIndex == 0,
                        width: 80,
                        onPressed: () => _recurringPressed(0),
                      ),
                      CustomButton(
                        value: "Daily",
                        isSelected: _selectedRecurringIndex == 1,
                        onPressed: () => _recurringPressed(1),
                        width: 80,
                      ),
                      CustomButton(
                        value: "Weekly",
                        isSelected: _selectedRecurringIndex == 2,
                        onPressed: () => _recurringPressed(2),
                        width: 80,
                      ),
                      CustomButton(
                        value: "Monthly",
                        isSelected: _selectedRecurringIndex == 3,
                        onPressed: () => _recurringPressed(3),
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () => _saveTask(context),
                child: const Text("Save Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final double height;
  final double width;

  const CustomInputField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 0,
                offset: const Offset(1, 1),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatefulWidget {
  final String value;
  final double width;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.value,
    required this.isSelected,
    required this.onPressed,
    required this.width,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.black : null,
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Center(
          child: Text(
            widget.value,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.black,
              fontSize: 15,
              fontFamily: "Nunito",
            ),
          ),
        ),
      ),
    );
  }
}
