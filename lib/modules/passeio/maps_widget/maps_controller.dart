import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tutor/repositories/passeio_repository.dart';
import 'package:tutor/shared/models/passeio_lat_long_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';

class MapsController {
  final passeioRepository = PasseioRepository();

  Completer<GoogleMapController> googleMapController = Completer();

  Future<PasseioLatLongModel> posicaoAtual(int id) async {
    return await passeioRepository.posicaoAtual(id);
  }

  Future<List<PasseioLatLongModel>> posicaoCompleta(int id) async {
    return await passeioRepository.posicaoCompleta(id);
  }

  Future<PasseioModel> buscarPasseio(int id) async {
    return await passeioRepository.buscarPorId(id);
  }
}
