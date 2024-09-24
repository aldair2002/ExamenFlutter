import 'package:flutter/material.dart';
import './service/firebase_service.dart';
import '../model/ticket.dart'; 

class ViewTicketPage extends StatefulWidget {
  const ViewTicketPage({super.key});

  @override
  _ViewTicketPageState createState() => _ViewTicketPageState();
}

class _ViewTicketPageState extends State<ViewTicketPage> {
  late Future<List<Ticket>> _ticketsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = FirebaseService.obtenerTodosLosTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Tickets'),
      ),
      body: FutureBuilder<List<Ticket>>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los tickets'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay tickets disponibles'));
          }

          // Lista de tickets
          List<Ticket> tickets = snapshot.data!;
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              Ticket ticket = tickets[index];
              return ListTile(
                title: Text('Ticket ID: ${ticket.id}'),
                subtitle: Text('Aerolinea: ${ticket.aerolinea}'), 
                onTap: () {
                  // Puedes agregar navegación o acciones al seleccionar un ticket
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ticket seleccionado: ${ticket.id}')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
