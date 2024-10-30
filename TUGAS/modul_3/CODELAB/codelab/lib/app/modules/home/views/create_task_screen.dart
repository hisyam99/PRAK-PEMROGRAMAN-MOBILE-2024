import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../data/appcolor.dart';
import '../../../data/widget_background.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  final bool isEdit;
  final String documentId;
  final String name;
  final String description;
  final String date;
  
  const CreateTaskScreen({
    Key? key,
    required this.isEdit,
    this.documentId = '',
    this.name = '',
    this.description = '',
    this.date = '',
  }) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final AppColor appColor = AppColor();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  
  late double widthScreen;
  late double heightScreen;
  late DateTime date;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    date = DateTime.now().add(const Duration(days: 1));

    if (widget.isEdit) {
      date = DateFormat('dd MMMM yyyy').parse(widget.date);
      controllerName.text = widget.name;
      controllerDescription.text = widget.description;
      controllerDate.text = widget.date;
    } else {
      controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
    }
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerDescription.dispose();
    controllerDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    widthScreen = mediaQueryData.size.width;
    heightScreen = mediaQueryData.size.height;
    return Scaffold(
      key: scaffoldState,
      backgroundColor: appColor.colorPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WidgetBackground(),
            SizedBox(
              width: widthScreen,
              height: heightScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildWidgetFormPrimary(),
                  const SizedBox(height: 16.0),
                  _buildWidgetFormSecondary(),
                  if (isLoading)
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              appColor.colorTertiary),
                        ),
                      ),
                    )
                  else
                    _buildWidgetButtonCreateTask(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFormPrimary() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            widget.isEdit ? 'Edit\nTask' : 'Create\nNew Task',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith( // Updated deprecated display1
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: controllerName,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetFormSecondary() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controllerDescription,
              decoration: const InputDecoration(
                labelText: 'Description',
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.description),
                  ],
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controllerDate,
              decoration: const InputDecoration(
                labelText: 'Date',
                suffixIcon: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(Icons.today),
                  ],
                ),
              ),
              style: const TextStyle(fontSize: 18.0),
              readOnly: true,
              onTap: () async {
                DateTime today = DateTime.now();
                DateTime? datePicker = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: today,
                  lastDate: DateTime(2025), // Updated year
                );
                if (datePicker != null) {
                  setState(() {
                    date = datePicker;
                    controllerDate.text = DateFormat('dd MMMM yyyy').format(date);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonCreateTask() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton( // Updated deprecated RaisedButton
        style: ElevatedButton.styleFrom(
          backgroundColor: appColor.colorTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Text(widget.isEdit ? 'UPDATE TASK' : 'CREATE TASK'),
        onPressed: () async {
          String name = controllerName.text;
          String description = controllerDescription.text;
          String date = controllerDate.text;
          
          if (name.isEmpty) {
            _showSnackBarMessage('Name is required');
            return;
          } else if (description.isEmpty) {
            _showSnackBarMessage('Description is required');
            return;
          }
          
          setState(() => isLoading = true);
          
          try {
            if (widget.isEdit) {
              DocumentReference documentTask =
                  firestore.doc('tasks/${widget.documentId}'); // Updated document to doc
              await firestore.runTransaction((transaction) async {
                DocumentSnapshot task = await transaction.get(documentTask);
                if (task.exists) {
                  await transaction.update(
                    documentTask,
                    <String, dynamic>{
                      'name': name,
                      'description': description,
                      'date': date,
                    },
                  );
                  Navigator.pop(context, true);
                }
              });
            } else {
              CollectionReference tasks = firestore.collection('tasks');
              DocumentReference result = await tasks.add(<String, dynamic>{
                'name': name,
                'description': description,
                'date': date,
              });
              // ignore: unnecessary_null_comparison
              if (result.id != null) { // Updated documentID to id
                Navigator.pop(context, true);
              }
            }
          } catch (e) {
            _showSnackBarMessage('Error: ${e.toString()}');
          } finally {
            setState(() => isLoading = false);
          }
        },
      ),
    );
  }

  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar( // Updated to use ScaffoldMessenger
      content: Text(message),
    ));
  }
}
