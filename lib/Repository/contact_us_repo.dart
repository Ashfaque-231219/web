import 'package:flutter/material.dart';

abstract class ContactUsRepository {
  Future contactAdmin(Map req, BuildContext context);
}
