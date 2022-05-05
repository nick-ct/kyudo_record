import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/database_controller.dart';

class ShootRecordSummary extends StatefulWidget {
  const ShootRecordSummary({Key? key}) : super(key: key);
  @override
  _ShootRecordSummaryState createState() => _ShootRecordSummaryState();
}

class _ShootRecordSummaryState extends State<ShootRecordSummary> {
  final DatabaseController _databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('reset db'),
      onPressed: () => _databaseController.cleanDatabase(),
    );
  }
}
