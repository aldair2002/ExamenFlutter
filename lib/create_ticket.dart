import 'package:flutter/material.dart';

class CreateTicketPage extends StatefulWidget {
  final Map<String, String>? initialData; // Para actualizar el formulario

  const CreateTicketPage({super.key, this.initialData});

  @override
  _CreateTicketPageState createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos del formulario
  late String _numeroVuelo;
  late String _nombrePasajero;
  late String _apellidoPasajero;
  late String _origen;
  late String _destino;
  late String _asiento;
  late String _clase;
  late String _fechaSalida;
  late String _horaSalida;

  @override
  void initState() {
    super.initState();

    // Carga inicial para actualización de datos
    _numeroVuelo = widget.initialData?['numeroVuelo'] ?? '';
    _nombrePasajero = widget.initialData?['nombrePasajero'] ?? '';
    _apellidoPasajero = widget.initialData?['apellidoPasajero'] ?? '';
    _origen = widget.initialData?['origen'] ?? '';
    _destino = widget.initialData?['destino'] ?? '';
    _asiento = widget.initialData?['asiento'] ?? '';
    _clase = widget.initialData?['clase'] ?? '';
    _fechaSalida = widget.initialData?['fechaSalida'] ?? '';
    _horaSalida = widget.initialData?['horaSalida'] ?? '';
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
                initialValue: _numeroVuelo,
                decoration: const InputDecoration(labelText: 'Número de vuelo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de vuelo';
                  }
                  return null;
                },
                onSaved: (value) => _numeroVuelo = value!,
              ),
              TextFormField(
                initialValue: _nombrePasajero,
                decoration: const InputDecoration(labelText: 'Nombre del pasajero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del pasajero';
                  }
                  return null;
                },
                onSaved: (value) => _nombrePasajero = value!,
              ),
              TextFormField(
                initialValue: _apellidoPasajero,
                decoration: const InputDecoration(labelText: 'Apellido del pasajero'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el apellido del pasajero';
                  }
                  return null;
                },
                onSaved: (value) => _apellidoPasajero = value!,
              ),
              DropdownButtonFormField<String>(
                value: _origen.isEmpty ? null : _origen,
                items: <String>['San Pedro Sula', 'Miami', 'Tegucigalpa'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Origen'),
                onChanged: (value) => setState(() => _origen = value!),
                validator: (value) => value == null ? 'Seleccione un origen' : null,
              ),
              DropdownButtonFormField<String>(
                value: _destino.isEmpty ? null : _destino,
                  items: <String>['Tegucigalpa', 'Miami', 'San Pedro Sula'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Destino'),
                onChanged: (value) => setState(() => _destino = value!),
                validator: (value) => value == null ? 'Seleccione un destino' : null,
              ),
              TextFormField(
                initialValue: _asiento,
                decoration: const InputDecoration(labelText: 'Asiento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de asiento';
                  }
                  return null;
                },
                onSaved: (value) => _asiento = value!,
              ),
              DropdownButtonFormField<String>(
                value: _clase.isEmpty ? null : _clase,
                items: <String>['Económica', 'Negocios', 'Primera Clase'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Clase'),
                onChanged: (value) => setState(() => _clase = value!),
                validator: (value) => value == null ? 'Seleccione una clase' : null,
              ),
              TextFormField(
                initialValue: _fechaSalida,
                decoration: const InputDecoration(labelText: 'Fecha de salida'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de salida';
                  }
                  return null;
                },
                onSaved: (value) => _fechaSalida = value!,
              ),
              TextFormField(
                initialValue: _horaSalida,
                decoration: const InputDecoration(labelText: 'Hora de salida'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la hora de salida';
                  }
                  return null;
                },
                onSaved: (value) => _horaSalida = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí puedes agregar la lógica para enviar el formulario o actualizar el ticket
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ticket guardado correctamente')),
                    );
                  }
                },
                child: const Text('Crear Ticket'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
