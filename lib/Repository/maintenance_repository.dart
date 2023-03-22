import 'package:flutter/material.dart';

abstract class MaintenanceRepository {
  Future addMaintenance(Map req, BuildContext context);
  Future resolveMaintenance(Map req, BuildContext context);
  Future viewMaintenance(Map req, BuildContext context);
}
