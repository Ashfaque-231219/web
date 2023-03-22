import 'package:flutter/material.dart';

abstract class PunchListRepository {
  Future addPunchListService(Map req, BuildContext context);
  Future resolvePunchListService(Map req, BuildContext context);
  Future viewPunchListService(Map req, BuildContext context);
}
