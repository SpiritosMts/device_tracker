import 'package:fl_chart/fl_chart.dart';

class Devicee {
  int adresse;
  int type;
  int seuil;

  String name;
  String description;
  String region;

  Devicee({
    this.adresse = 0,
    this.name = '',
    this.description = '',
    this.type = 0,
    this.region = '',
    this.seuil = 0,
  });

  factory Devicee.fromJson(Map<String, dynamic> json) {
    return Devicee(
      adresse: json['adresse'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 0,
      region: json['region'] ?? '',
      seuil: json['seuil'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adresse': adresse,
      'name': name,
      'description': description,
      'type': type,
      'region': region,
      'seuil': seuil,
    };
  }
}

class DeviceModel {
  Devicee device;
  double latitude;
  double longitude;
  String energy;
  String emission;
  String money;
  List<FlSpot> flSpots;

  DeviceModel({
    required this.device,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.energy = '',
    this.emission = '',
    this.money = '',
     this.flSpots = const [],
  });

  factory DeviceModel.fromJson(Map<String, dynamic> json) {

    return DeviceModel(
      device: Devicee.fromJson(json['device'] ?? {}),
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      energy: json['energy'] ?? '',
      emission: json['emission'] ?? '',
      money: json['money'] ?? '',
      flSpots: json['flSpots'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device': device.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'energy': energy,
      'emission': emission,
      'money': money,
      'flSpots': flSpots.map((e) => {'x': e.x, 'y': e.y}).toList(),
    };
  }
}