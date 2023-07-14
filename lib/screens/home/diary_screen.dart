import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zola/screens/home/components/diary_body.dart';
import 'package:iconsax/iconsax.dart';
import 'package:zola/theme.dart';
import 'package:zola/constants/route.dart';
import 'package:zola/services/notification.dart' as notificationService;
import 'package:zola/services/socket_service.dart';
import 'package:get/get.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int unreadNotification = 0;
  SocketService socketService = Get.find<SocketService>();

  @override
  void initState() {
    super.initState();

    // check is socket service initialized
    socketService.connectToSocket().then((_) {
      socketService.onReceiveNotification((p0) {
        //show snack bar
		unreadNotification++;
        print("New notification");
      });

    });

    notificationService.countUnreadNotification().then((value) {
      setState(() {
        unreadNotification = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading:
            IconButton(icon: const Icon(Icons.search), onPressed: () => {}),
        title: GestureDetector(
          onTap: () => context.push(RouteConst.search),
          child: Text(
            'Tìm kiếm',
            style: GoogleFonts.getFont(primaryFont, fontSize: 18),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Iconsax.edit),
                onPressed: () => context.push(RouteConst.createPost),
              ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Iconsax.notification),
                    onPressed: () => context.push(RouteConst.notification),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        unreadNotification.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
	  // Add drop down menu to select following or recommend

      // floating button to scroll to top
      body: DiaryBody(),
    );
  }
}
