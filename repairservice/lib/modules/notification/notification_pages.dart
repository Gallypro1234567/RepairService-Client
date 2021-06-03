import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repairservice/config/themes/theme_config.dart';
import 'package:signalr_client/signalr_client.dart';
import '../../../utils/service/server_hosting.dart' as Host;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final serverUrl =
      Uri.http(Host.Server_hosting, "/notificationshub").toString();
  final serverUrls = "http://repairservice.somee.com/notificationshub";
  HubConnection hubConnection;
  double width = 100, height = 100;
  IconData icon;

  Offset positon;

  @override
  void initState() {
    super.initState();
    initialSignalR();
    positon = Offset(0.0, -20.0);
    icon = Icons.stop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppTheme.fullHeight(context) * .06,
        title: Text("Thông báo"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
              left: positon.dx,
              top: positon.dy,
              child: Draggable(
                child: Container(
                    width: width,
                    height: height,
                    color: Colors.blue,
                    child: Center(
                        child: Text(
                      "Move me",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
                feedback: Container(
                    width: width,
                    height: height,
                    color: Colors.red[900],
                    child: Center(
                        child: Text(
                      "Move me",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
                onDraggableCanceled: (velocity, offset) async {
                  if (hubConnection.state == HubConnectionState.Connected) {
                    await hubConnection.invoke("MoveViewFromServer",
                        args: <Object>[offset.dx, offset.dy]);
                  }
                  setState(() {
                    positon = offset;
                  });
                },
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            hubConnection.state == HubConnectionState.Disconnected ||
                    hubConnection.state == null
                ? await hubConnection.start()
                : await hubConnection.stop();
            setState(() {
              icon = hubConnection.state == HubConnectionState.Disconnected
                  ? Icons.stop
                  : Icons.play_arrow;
              print(hubConnection.state);
            });
          } on Exception catch (ex) {
            print(ex);
          }
        },
        tooltip: "Start/Stop",
        child: Icon(icon),
      ),
    );
  }

  Future<void> initialSignalR() async {
    hubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    hubConnection.onclose((error) => print("Connection Error"));
    hubConnection.on("ReceiveNewPosition", (val) {
      return _handNewPosition(val);
    });
    await hubConnection.start();
    print(hubConnection.state);
  }

  _handNewPosition(List<Object> args) {
    setState(() {
      positon = Offset(args[0], args[1]);
    });
  }
}
