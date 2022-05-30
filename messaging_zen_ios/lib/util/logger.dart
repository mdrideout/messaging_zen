import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
    lineLength: 120,
    colors: false,
  ),
);
