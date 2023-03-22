import 'package:flutter/material.dart';

abstract class ProjectRepository {
  Future getProjectList(Map req, BuildContext context);

  Future getProjectDetailsList(Map req, BuildContext context);

  Future getProjectInfo(Map req, BuildContext context);

  Future getProjectStatus(Map req, BuildContext context);
  Future generateTaskReport(Map req, BuildContext context);
}
