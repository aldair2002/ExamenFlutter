import 'package:flutter/material.dart';
import './model/ticket.dart';
import './service/firebase_service.dart';

class CreateTicketPage extends StatefulWidget {
  final Map<String, String>? initialData;

  const CreateTicketPage({super.key, this.initialData});

  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final _formKey = GlobalKey<FormState>();


  late TextEditingController _numeroVueloController;
  late TextEditingController _nombrePasajeroController;
  late TextEditingController _apellidoPasajeroController;
  late TextEditingController _asientoController;
  late TextEditingController _fechaSalidaController;
  late TextEditingController _horaSalidaController;

  // Variables para Dropdown
  String? _origen;
  String? _destino;
  String? _clase;

  @override
  void initState() {
    super.initState();


    _numeroVueloController = TextEditingController(text: widget.initialData?['numeroVuelo'] ?? '');
    _nombrePasajeroController = TextEditingController(text: widget.initialData?['nombrePasajero'] ?? '');
    _apellidoPasajeroController = TextEditingController(text: widget.initialData?['apellidoPasajero'] ?? '');
    _asientoController = TextEditingController(text: widget.initialData?['asiento'] ?? '');
    _fechaSalidaController = TextEditingController(text: widget.initialData?['fechaSalida'] ?? '');
    _horaSalidaController = TextEditingController(text: widget.initialData?['horaSalida'] ?? '');


    _origen = widget.initialData?['origen'] ?? '';
    _destino = widget.initialData?['destino'] ?? '';
    _clase = widget.initialData?['clase'] ?? '';
  }

  @override
  void dispose() {
    // Liberar controladores cuando el widget se elimine
    _numeroVueloController.dispose();
    _nombrePasajeroController.dispose();
    _apellidoPasajeroController.dispose();
    _asientoController.dispose();
    _fechaSalidaController.dispose();
    _horaSalidaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Ticket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _numeroVueloController,
                decoration: const InputDecoration(labelText: 'Número de vuelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de vuelo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombrePasajeroController,
                decoration: const InputDecoration(labelText: 'Nombre del pasajero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del pasajero';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidoPasajeroController,
                decoration: const InputDecoration(labelText: 'Apellido del pasajero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el apellido del pasajero';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _origen,
                items: <String>['San Pedro', 'Miamis', 'Tegucigalpas'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Origen'),
                onChanged: (value) => setState(() => _origen = value),
                validator: (value) => value == null ? 'Seleccione un origen' : null,
              ),
              DropdownButtonFormField<String>(
                value: _destino,
                items: <String>['Tegucigalpa', 'Miami', 'San Pedro Sula'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Destino'),
                onChanged: (value) => setState(() => _destino = value),
                validator: (value) => value == null ? 'Seleccione un destino' : null,
              ),
              TextFormField(
                controller: _asientoController,
                decoration: const InputDecoration(labelText: 'Asiento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de asiento';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _clase,
                items: <String>['Económica', 'Negocios', 'Primera Clase'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Clase'),
                onChanged: (value) => setState(() => _clase = value),
                validator: (value) => value == null ? 'Seleccione una clase' : null,
              ),
              TextFormField(
                controller: _fechaSalidaController,
                decoration: const InputDecoration(labelText: 'Fecha de salida'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de salida';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _horaSalidaController,
                decoration: const InputDecoration(labelText: 'Hora de salida'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la hora de salida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _guardarTicket();
                  }
                },
                child: const Text('Guardar Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardarTicket() async {    
    Ticket nuevoTicket = Ticket(
      id: widget.initialData?['id'] ?? '', // Si no hay id, es un ticket nuevo
      numeroVuelo: _numeroVueloController.text,
      aerolinea: 'Aerolinea Ejemplo', // Placeholder para aerolínea
      nombrePasajero: _nombrePasajeroController.text,
      apellidoPasajero: _apellidoPasajeroController.text,
      origen: _origen ?? '',
      destino: _destino ?? '',
      asiento: _asientoController.text,
      clase: _clase ?? '',
      fechaSalida: DateTime.parse(_fechaSalidaController.text),
      horaSalida: _horaSalidaController.text,
    );

    try {
      if (widget.initialData?['id'] != null) {
        // Si el ticket tiene un id, es una actualización
        await FirebaseService.actualizarTicket(widget.initialData!['id']!, nuevoTicket.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket actualizado exitosamente')),
        );
      } else {
        // Si no hay id, es un nuevo ticket
        await FirebaseService.crearTicket(nuevoTicket.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ticket creado exitosamente')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar ticket: $e')),
      );
    }
  }
}
