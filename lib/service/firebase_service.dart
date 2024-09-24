import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/ticket.dart';

class FirebaseService {
  // Instancia de la colección de tickets en Firestore
  static final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');

  //  crear 
  static Future<void> crearTicket(Map<String, dynamic> ticketData) async {
    try {      
      await ticketsCollection.add(ticketData);
      print('Ticket creado exitosamente');
    } catch (e) {
      print('Error al crear ticket: $e');
      throw Exception('Error al crear el ticket');
    }
  }

  // Obtener todos los tickets
  static Future<List<Ticket>> obtenerTodosLosTickets() async {
    try {
      QuerySnapshot querySnapshot = await ticketsCollection.get();
      return querySnapshot.docs
          .map((doc) => Ticket.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error al obtener todos los tickets: $e');
      throw Exception('Error al obtener los tickets');
    }
  }
  
  // Actualizar 
  static Future<void> actualizarTicket(String ticketId, Map<String, dynamic> ticketData) async {
    try {
      await ticketsCollection.doc(ticketId).update(ticketData);
      print('Ticket actualizado exitosamente');
    } catch (e) {
      print('Error al actualizar el ticket: $e');
      throw Exception('Error al actualizar el ticket');
    }
  }

  //get de ticket por id
  static Future<Ticket?> obtenerTicketPorId(String ticketId) async {
    try {
      DocumentSnapshot doc = await ticketsCollection.doc(ticketId).get();
      if (doc.exists) {
        return Ticket.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        return null;
      }
    } catch (e) {
      print('Error al obtener el ticket: $e');
      return null;
    }
  }

  // Eliminar
  static Future<void> eliminarTicket(String ticketId) async {
    try {      
      await ticketsCollection.doc(ticketId).delete();
      print('Ticket eliminado exitosamente');
    } catch (e) {
      print('Error al eliminar el ticket: $e');
      throw Exception('Error al eliminar el ticket');
    }
  }
}
