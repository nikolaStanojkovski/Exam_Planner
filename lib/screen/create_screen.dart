import 'package:exam_planner/model/exam.dart';
import 'package:exam_planner/util/date_utils.dart';
import 'package:exam_planner/util/location_utils.dart';
import 'package:exam_planner/widget/form/button_form_field.dart';
import 'package:exam_planner/widget/form/form_field.dart';
import 'package:exam_planner/widget/form/text_form_field.dart';
import 'package:exam_planner/widget/map/map_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateExamScreen extends StatefulWidget {
  static const routeName = '/exam/create';

  const CreateExamScreen({Key? key}) : super(key: key);

  @override
  State<CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends State<CreateExamScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectNameController = TextEditingController();
  final TextEditingController _examDateController = TextEditingController();
  final TextEditingController _examTimeController = TextEditingController();
  LatLng? _locationController;
  String? _examAddress;

  late BuildContext _buildContext;

  void _navigateOut() {
    Navigator.of(_buildContext).pop();
  }

  String? _validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the name of the subject';
    }
    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the date of the exam';
    }
    List<String> stringParts = value.split(" ").cast();
    if (stringParts.length != 2) {
      return 'Please enter a valid date of the exam';
    }
    if (!DateTimeUtils.validateDate(stringParts, value)) {
      return 'Please enter a valid date of the exam';
    }
    return null;
  }

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the duration of the exam';
    }
    if (!DateTimeUtils.validateTime(value)) {
      return 'Please enter a valid time period';
    }
    return null;
  }

  void _validateLocation(LatLng? location) {
    setState(() {
      if (location != null) {
        _locationController = location;
        _getLocationAddress();
      }
    });
  }

  Future<void> _getLocationAddress() async {
    Address address =
        await LocationUtils.getLocationAddress(_locationController!);
    setState(() {
      _examAddress =
          '${address.streetAddress}, ${address.city} (${address.countryCode})';
    });
  }

  void _chooseLocation() {
    showDialog(
      context: _buildContext,
      builder: (context) {
        return MapDialog(_validateLocation);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<Object>;
    final _addExamFunction = arguments[0] as void Function(Object newExam);
    final _context = arguments[1] as BuildContext;
    _buildContext = _context;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Creation"),
      ),
      body: FormControl(_formKey, [
        FormTextField(_subjectNameController, 'Subject Name',
            const EdgeInsets.fromLTRB(30, 10, 5, 30), false, _validateSubject),
        FormTextField(_examDateController, 'Date (format: DD:MM:YYYY hh:mm)',
            const EdgeInsets.fromLTRB(30, 5, 5, 30), false, _validateDate),
        FormTextField(_examTimeController, 'Duration (format: hh:mm)',
            const EdgeInsets.fromLTRB(30, 5, 5, 30), false, _validateTime),
        ButtonFormField(
            const EdgeInsets.fromLTRB(0, 0, 0, 45),
            _chooseLocation,
            (_locationController == null || _examAddress == null)
                ? "Select Location"
                : _examAddress!,
            Colors.black12,
            Colors.white),
        ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_locationController == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please select the exam location'),
                    duration: Duration(seconds: 1),
                  ));
                } else {
                  var exam = Exam(
                      _subjectNameController.text,
                      _examDateController.text,
                      _examTimeController.text,
                      _locationController!);

                  _addExamFunction(exam);
                  _navigateOut();
                }
              }
            },
            child: const Text("Save"),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              padding: const EdgeInsets.all(8.0),
              minimumSize: const Size(300, 50),
            )),
        ButtonFormField(const EdgeInsets.fromLTRB(0, 10, 0, 0), _navigateOut,
            "Exit", Colors.redAccent, Colors.white),
      ]),
    );
  }
}
