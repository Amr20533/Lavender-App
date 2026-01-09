import 'package:flutter/material.dart';

IconData getErrorIconFromMessage(String message) {
  final lower = message.toLowerCase();

  if (lower.contains("internet") || lower.contains("connection")) {
    return Icons.wifi_off_rounded;
  }

  if (lower.contains("session") || lower.contains("unauthorized")) {
    return Icons.lock_outline_rounded;
  }

  if (lower.contains("server") || lower.contains("500")) {
    return Icons.cloud_off_rounded;
  }

  return Icons.error_outline_rounded;
}
