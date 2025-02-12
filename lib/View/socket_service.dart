// import 'package:dealer_caryanam/Model/token_model.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SocketService {
//   final TokenModel tokenModel;
//   SocketService({required this.tokenModel});
//   late IO.Socket _socket;
//   final String _namespace =
//       'https://cf-production.up.railway.app/Aucbidding'; // Use your updated endpoint
//
//   // Connect to the server
//   void connect(Function(Map<String, dynamic>) onData) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String userId = prefs.getString('UserId') ?? '';
//
//     // Initialize the socket connection
//     _socket = IO.io(
//       _namespace,
//       IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders({
//         'Authorization': 'Bearer ${tokenModel.originalToken}'
//       }) // Set transports to websocket for real-time connection
//           .build(),
//       // IO.OptionBuilder()
//       //     .setTransports(['websocket'])
//       //     .enableAutoConnect()
//       //     .build()
//     );
//
//     // Connect the socket
//     IO.Socket my = _socket.connect();
//     my.onError((error) {
//       print(error.toString());
//     });
//     my.onConnect((h) {
//       print('May connected');
//     });
//
//     print("trying to connect");
//     _socket.on('connect', (_) {
//       print('Connected to server with userId: $userId');
//     });
//
//     // Listen for 'message' events from the server
//     _socket.on('message', (data) {
//       print('Received message: $data');
//       onData(data); // Handle incoming data
//     });
//
//     // Handle error events
//     _socket.on('error', (error) {
//       print('Socket error: $error');
//     });
//
//     // Handle disconnection events
//     _socket.on('disconnect', (_) {
//       print('Disconnected from server');
//     });
//   }
//
//   // Send data to the server
//   void sendMessage(String event, dynamic data) {
//     if (_socket.connected) {
//       _socket.emit(event, data);
//       print('Message sent: $data');
//     } else {
//       print('Socket is not connected');
//     }
//   }
//
//   // Disconnect the socket
//   void disconnect() {
//     _socket.disconnect();
//     print('Disconnected from socket');
//   }
//
//   // Check if the socket is connected
//   bool isConnected() {
//     return _socket.connected;
//   }
// }
import 'package:dealer_caryanam/Model/token_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';

class SocketService {
  late IO.Socket _socket;
  final TokenModel tokenModel;
  SocketService({required this.tokenModel});
  final String _namespace = 'https://cf-production.up.railway.app/Aucbidding';

  void connect(Function(Map<String, dynamic>) onData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('UserId') ?? '';

    _socket = IO.io(_namespace, <String, dynamic>{
      'transports': ['websocket'],
      // 'auth': {
      //   //'userId': tokenModel.userId,
      //   'token': tokenModel.originalToken, // Add token or any required details
      // },
    });

    // _socket.on('connect', () {
    //   print('connected to $_namespace');
    //   _socket.emit('customerData', {'UserId': userId});
    //   print(_socket.id);
    // });
    _socket.onError((handler) {
      print("error:${handler.toString()}");
    });
    _socket.on('connect', (_) {
      print('Connected to server with userId: $userId');
    });

    // socket.on('disconnect', () {
    //   print('disconnected from $_namespace');
    // });

    _socket.on('extraAmountRequestedToCustomer', (data) {
      print(data.toString());
      if (data is Map<String, dynamic>) {
        onData(data);
      }
    });

    _socket.on('rideTimer', (data) {
      print(data.toString());
      if (data is Map<String, dynamic>) {
        onData(data);
      }
    });
  }

  void disconnect() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userId = prefs.getString('UserId') ?? '';
    // socket.on('disconnect', () {
    //   print('disconnected from $_namespace');
    //   _socket.emit('customer_disconnect', {'UserId': userId});
    // });
    _socket.disconnect();
  }
}
