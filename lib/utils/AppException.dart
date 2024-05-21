// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException(this.message, [this.prefix = ""]);
  final String message;
  final String prefix;

  @override
  String toString() {
    return "$prefix: $message";
  }

  @override
  List<Object> get props => [];
}

class DefaultException extends AppException {
  const DefaultException(String message) : super("Hata Oluştu", message);
}

class BadRequestException extends AppException {
  const BadRequestException(String message) : super("Hatalı İstek", message);
}

class FetchDataException extends AppException {
  const FetchDataException(String message) : super("Bağlantı Hatası.", message);
}

class SocketError extends AppException {
  const SocketError(String message) : super("Bağlantı Hatası.", message);
}

class TimeoutError extends AppException {
  const TimeoutError(String message) : super("Zaman Aşımı.", message);
}

class FormatError extends AppException {
  const FormatError(String message) : super("Biçim Hatası.", message);
}

class NoContentException extends AppException {
  const NoContentException(String message)
      : super("İçerik Bulunamadı.", message);
}

class NotFoundException extends AppException {
  const NotFoundException(String message)
      : super("Hata Oluştu. Tekrar deneyiniz.", message);
}

class InternalServerError extends AppException {
  const InternalServerError(String message)
      : super("Hata Oluştu. Tekrar deneyiniz.", message);
  // const InternalServerError(String message) : super("Sunucu Hatası", message);
}

class NetworkException extends AppException {
  const NetworkException(String message)
      : super('Hata Oluştu. Tekrar deneyiniz.', message);
}
