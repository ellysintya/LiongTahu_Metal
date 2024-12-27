import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class GambarProvider extends ChangeNotifier {
  dynamic gambar;

  void gantiGambar(Uint8List gbr) {
    gambar = gbr;
    notifyListeners();
  }

  String? konversiGambarKeBase64() {
    if (gambar == null) return null;
    return base64Encode(gambar!);
  }
}

class SaveUrl with ChangeNotifier {
  String? FotoMenuUrl;

  String? get fotoMenuUrl => FotoMenuUrl;

  void simpanFotoMenu(String url) {
    FotoMenuUrl = url;
    notifyListeners();
  }
}

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final bool hasError;

  AuthState({
    this.isLoading = false,
    this.hasError = false,
    this.isAuthenticated = false,

  });

  factory AuthState.isAuthenticated() {
    return AuthState(isAuthenticated: true);
  }

  factory AuthState.isLoading() {
    return AuthState(isLoading: true);
  }


  factory AuthState.initial() {
    return AuthState();
  }
}