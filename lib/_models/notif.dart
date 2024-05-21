import '../_manager/bindings.dart';

class Notif {
  int id;
  String timestamp;
  int idDevice;
  String typeAlerte;
  String gravite;
  String descriptionAlerte;

  Notif({
    this.id = 0,
    this.timestamp = '',
    this.idDevice = 0,
    this.typeAlerte = '',
    this.gravite = '',
    this.descriptionAlerte = '',
  });

  // Convert Notif object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'id_device': idDevice,
      'type_alerte': typeAlerte,
      'gravite': gravite,
      'description_alerte': descriptionAlerte,
    };
  }

  // Create Notif object from JSON
  factory Notif.fromJson(Map<String, dynamic> json) {
    return Notif(
      id: json['id'] ?? 0,
      timestamp: json['timestamp'] ?? '',
      idDevice: json['id_device'] ?? 0,
      typeAlerte: json['type_alerte'] ?? '',
      gravite: json['gravite'] ?? '',
      descriptionAlerte: json['description_alerte'] ?? '',
    );
  }
}
