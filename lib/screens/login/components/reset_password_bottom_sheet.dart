import 'package:flutter/material.dart';

class PasswordBottomSheet {
  static void showResetPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return const ResetPasswordPage();
        });
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  int currentPage = 0;
  late List<Widget> pages;
  late String email;
  late String otp;
  late String newPassword;
  late String retypeNewPassword;

  void buildPage(BuildContext context) {
    setState(() {
      pages = [
        emailPage(context),
        otpPage(context),
        newPasswordPage(context),
      ];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    buildPage(context);
    return pages[currentPage];
  }

  Widget emailPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                const Center(
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //  check here: https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
                    key: const Key("EMAIL_RESET_PASSWORD"),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Reset mật khẩu'),
                    onPressed: () {
                      // Handle resetting password here
                      setState(() {
                        currentPage = 1;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget otpPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            // padding: EdgeInsets.only(
            // bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                const Center(
                  child: Text(
                    'Nhập mã OTP',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //  check here: https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
                    onChanged: (value) => setState(() {
                      otp = value;
                    }),
                    key: const Key("OTP_RESET_PASSWORD"),
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      hintText: '000000',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Tiếp tục'),
                    onPressed: () {
                      // Handle resetting password here
                      setState(() {
                        currentPage = 2;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget newPasswordPage(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            // padding: EdgeInsets.only(
            // bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 16,
                ),
                const Center(
                  child: Text(
                    'Nhập mật khẩu',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //  check here: https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
                    onChanged: (value) => setState(() {
                      newPassword = value;
                    }),
                    key: const Key("PASSWORD_RESET_PASSWORD"),
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu mới',
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //  check here: https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t
                    onChanged: (value) => setState(() {
                      retypeNewPassword = value;
                    }),
                    key: const Key("VALID_RESET_PASSWORD"),
                    decoration: const InputDecoration(
                      labelText: 'Xác nhận lại',
                      hintText: '',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Hoàn thành'),
                    onPressed: () {
                      // Handle resetting password here
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
