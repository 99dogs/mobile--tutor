import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tutor/modules/passeio/maps_widget/maps_controller.dart';
import 'package:tutor/shared/models/passeio_lat_long_model.dart';
import 'package:tutor/shared/models/passeio_model.dart';
import 'package:tutor/shared/themes/app_colors.dart';
import 'package:tutor/shared/widgets/title_page_widget/title_page_widget.dart';

const double CAMERA_ZOOM = 19;
const double CAMERA_TILT = 40;
const double CAMERA_BEARING = 5;

class MapsWidget extends StatefulWidget {
  final int id;
  const MapsWidget({
    Key? key,
    int,
    required this.id,
  }) : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final controller = MapsController();
  PasseioModel passeio = PasseioModel();

  late LocationData currentLocation;
  Set<Marker> _markers = Set<Marker>();
  final CameraPosition _inicialCameraPosition = CameraPosition(
    target: LatLng(-22.2338215, -45.7029303),
    zoom: CAMERA_ZOOM,
    tilt: CAMERA_TILT,
    bearing: CAMERA_BEARING,
  );

  Timer? timer;
  late BitmapDescriptor icon;
  String title = "";

  @override
  void initState() {
    super.initState();
    buscarPasseio();
    initIcon();
  }

  initIcon() async {
    icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(24, 24)),
      'assets/images/dogwalker-walking-icon.png',
    );
  }

  buscarPasseio() async {
    passeio = await controller.buscarPasseio(widget.id);
    setState(() {
      buscarPosicao();
    });
  }

  buscarPosicao() async {
    if (passeio.status == "Andamento") {
      setState(() {
        title = "Andamento do passeio";
      });
      timer = Timer.periodic(
        new Duration(seconds: 3),
        (timer) async {
          try {
            PasseioLatLongModel latLong =
                await controller.posicaoAtual(widget.id);
            updatePinOnMap(
              double.parse(latLong.latitude),
              double.parse(latLong.longitude),
            );
          } catch (e) {
            print(e);
          }
        },
      );
    } else if (passeio.status == "Finalizado") {
      setState(() {
        title = "Trajetória do passeio";
      });
      mountPinOnMap();
    }
  }

  void updatePinOnMap(double latitude, double longitude) async {
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(latitude, longitude),
    );

    if (!mounted) return;

    final GoogleMapController controllerMap =
        await controller.googleMapController.future;
    controllerMap.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(
      () {
        _markers.removeWhere((m) => m.markerId.value == 'dogwalker');
        _markers.add(
          Marker(
            icon: icon,
            markerId: MarkerId('dogwalker'),
            position: LatLng(latitude, longitude),
          ),
        );
      },
    );
  }

  void mountPinOnMap() async {
    List<PasseioLatLongModel> listLatLong = await controller.posicaoCompleta(
      widget.id,
    );
    int markerId = 0;
    listLatLong.forEach((element) {
      _markers.add(
        Marker(
          icon: icon,
          markerId: MarkerId(markerId.toString()),
          position: LatLng(
            double.parse(element.latitude),
            double.parse(element.longitude),
          ),
        ),
      );
      markerId++;
    });

    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(
        double.parse(listLatLong[0].latitude),
        double.parse(listLatLong[0].longitude),
      ),
    );

    if (!mounted) return;

    final GoogleMapController controllerMap =
        await controller.googleMapController.future;
    controllerMap.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(
      () {
        _markers;
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                color: AppColors.primary,
              ),
              Container(
                color: AppColors.background,
                child: Column(
                  children: [
                    TitlePageWidget(
                      title: title,
                      enableBackButton: true,
                      routePage: "/passeio/detail",
                      args: widget.id,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: GoogleMap(
                    myLocationEnabled: false,
                    zoomControlsEnabled: true,
                    markers: _markers,
                    initialCameraPosition: _inicialCameraPosition,
                    mapType: MapType.normal,
                    onMapCreated: (GoogleMapController mapsController) {
                      controller.googleMapController.complete(mapsController);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
