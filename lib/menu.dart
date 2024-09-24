import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';




class Menu extends StatelessWidget {
  const Menu({super.key});
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //primary: Colors.blue, // Color de fondo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes redondeados
                ),
              ),
              onPressed: () {
                context.go('/create_ticket'); // Navega a la página de crear ticket
              },
              child: const Text('Crear Ticket'),
            ),
            const SizedBox(height: 20), // Espaciado entre botones
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                //primary: Colors.blue, // Color de fondo
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordes redondeados
                ),
              ),
              onPressed: () {
                context.go('/view_tickets'); // Navega a la página de ver tickets
              },
              child: const Text('Ver Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}

// Clase HomePage, CreateTicketPage y ViewTicketsPage se definen más abajo
