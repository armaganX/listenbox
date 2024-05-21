import 'dart:async';
import 'dart:io';

import 'package:listenbox/utils/AppException.dart';

AppException getException(Exception e) {
  if (e is BadRequestException ||
      e is InternalServerError ||
      e is NoContentException ||
      e is NotFoundException) {
    return e as AppException;
  } else if (e is FetchDataException) {
    return const FetchDataException("Veri çekiminde bir sorun oluştu.");
  } else if (e is SocketException) {
    return const SocketError("Sunucu ile bağlantı kurulamadı.");
  } else if (e is TimeoutException) {
    return const TimeoutError("İsteğiniz zaman aşımına uğradı.");
  } else if (e is FormatException) {
    return const FormatError("Gerçekleştilmesi istenen istekte hata mevcut.");
  }

  var b = (e.toString().split('.'));
  final seen = Set<String>();
  final unique = b.where((str) => seen.add(str)).toList();
  String message = unique
      .join(".")
      .replaceAll('Exception:', '')
      .replaceAll('Hata Oluştu', '')
      .replaceAll('\n', '');
  return DefaultException(message /*.split(":")[1] */);
}

Object getInternalException(int statusCode) async {
  switch (statusCode) {
    case 204:
      return const NoContentException("Sunucudan boş veri gönderdi.");
    case 401:
      return const NetworkException("Yetkisiz talep.");
    case 400:
      return const BadRequestException("Hatalı bilgi girişi yapıldı.");
    case 404:
      return const NotFoundException("Sorgulanan içeriğe ulaşılamadı.");
    case 408:
      return const NetworkException("İşlem zaman aşımına uğradı.");
    case 500:
      return const InternalServerError(
          "İşleminiz gerçekleştirilemedi. Yaptığınız işlemleri kontrol ederek. Tekrar deneyiniz.");
    case 503:
      return const NetworkException(
          "Geçici olarak servis kullanılamamaktadır.");
    default:
      return Exception("Bir hata meydana geldi.");
  }
}
