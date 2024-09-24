class Ticket {
  final String id;
  final String numeroVuelo;
  final String aerolinea;
  final String nombrePasajero;
  final String apellidoPasajero;
  final String origen;
  final String destino;
  final String asiento;
  final String clase;
  final DateTime fechaSalida;
  final String horaSalida;

  Ticket({
    required this.id,
    required this.numeroVuelo,
    required this.aerolinea,
    required this.nombrePasajero,
    required this.apellidoPasajero,
    required this.origen,
    required this.destino,
    required this.asiento,
    required this.clase,
    required this.fechaSalida,
    required this.horaSalida,
  });

  // Método para convertir un Ticket a un Map (para enviar a Firebase)
  Map<String, dynamic> toMap() {
    return {
      'numeroVuelo': numeroVuelo,
      'aerolinea': aerolinea,
      'nombrePasajero': nombrePasajero,
      'apellidoPasajero': apellidoPasajero,
      'origen': origen,
      'destino': destino,
      'asiento': asiento,
      'clase': clase,
      'fechaSalida': fechaSalida.toIso8601String(),
      'horaSalida': horaSalida,
    };
  }

  // Método para crear una instancia de Ticket a partir de un Map (recibido de Firebase)
  factory Ticket.fromMap(Map<String, dynamic> map, String id) {
    return Ticket(
      id: id,
      numeroVuelo: map['numeroVuelo'] ?? '',
      aerolinea: map['aerolinea'] ?? '',
      nombrePasajero: map['nombrePasajero'] ?? '',
      apellidoPasajero: map['apellidoPasajero'] ?? '',
      origen: map['origen'] ?? '',
      destino: map['destino'] ?? '',
      asiento: map['asiento'] ?? '',
      clase: map['clase'] ?? '',
      fechaSalida: DateTime.parse(map['fechaSalida']),
      horaSalida: map['horaSalida'] ?? '',
    );
  }
}
