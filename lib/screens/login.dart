import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/modules/loginclass.dart';
import 'package:technovationapp/screens/dashboard.dart';
import 'package:technovationapp/screens/register.dart';
import 'package:technovationapp/utilities/shareprefrence.dart';
import '../constants/colors.dart';
import '../constants/font.dart';
import '../constants/textfield.dart';
import '../modules/usersclass.dart';
import '../utilities/variables.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // init textediting controller
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  bool _isLoading = false;

  // button submit clicked
  Future _onSubmit() async {
    FocusScope.of(context).unfocus();
    _loadingState(true);

    // check if admin login
    if (_usernamecontroller.text.trim() == "admin" &&
        _pwdcontroller.text.trim() == "00000") {
      // print admin
      _loadingState(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: f5("Admin login Successful", 12, color: white),
        ),
      );
      Provider.of<Users>(context, listen: false).user;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
      return;
    }

    // users login auth
    login(_usernamecontroller.text, _pwdcontroller.text).then((response) async {
      // check if successful
      if (response["status"] == true) {
        _loadingState(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: f5("Login Successful", 12, color: white),
          ),
        );
        // navigate to login
        var useraddresss = response["data"]["Address"];

        // print(useraddresss);
        await save(useraddresss);

// ###############
        Provider.of<Users>(context, listen: false).users(username: useraddresss);
// ###############
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        // error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: f5(response["message"], 12, color: white),
          ),
        );
        _loadingState(false);
      }
    });
  }

  @override
  void dispose() {
    _pwdcontroller.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/ecobg.png"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // title: Image.asset(
            //   "assets/logo.png",
            //   height: 65,
            // ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08,
                      right: MediaQuery.of(context).size.width * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/ecologo.png"),
                      vgap(80),
                      Align(
                        alignment: Alignment.topCenter,
                        child: text("Login", 18,
                            weight: FontWeight.w600, color: deepgreen),
                      ),
                      vgap(15),
                      inputbox("Username|Email", 
                          _usernamecontroller),
                      vgap(15),
                      inputbox(
                          "Password",  _pwdcontroller,
                          obs: true),
                      vgap(15),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register())),
                            child:
                                f7("Don't have acount?", 12, color: deepgreen),
                          ),
                          Expanded(child: Container()),
                          InkWell(
                            child:
                                f7("Forgotten Password?", 12, color: deepgreen),
                          ),
                        ],
                      ),
                      vgap(15),
                      MaterialButton(
                        onPressed: _isLoading ? null : () async => _onSubmit(),
                        minWidth: MediaQuery.of(context).size.width,
                        color: deepgreen,
                        padding: const EdgeInsets.all(15),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: white,
                                strokeWidth: 1,
                              )
                            : f7("Login", 15, color: Colors.white),
                      ),
                      vgap(40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.fingerprint_rounded,
                            color: white.withOpacity(0.4),
                            size: 70,
                          ),
                        ),
                      ),
                      vgap(70)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _loadingState(s) {
    setState(() {
      _isLoading = s;
    });
  }
}
