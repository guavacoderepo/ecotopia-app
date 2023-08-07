import 'package:flutter/material.dart';
import 'package:technovationapp/constants/colors.dart';
import 'package:technovationapp/requestmodels/registerclass.dart';
import 'package:technovationapp/screens/onboarding/login.dart';
import 'package:technovationapp/utilities/router.dart';
import 'package:technovationapp/utilities/variables.dart';
import '../../utilities/font.dart';
import '../../utilities/textfield.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // init textediting controller
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _pwd1controller = TextEditingController();
  final TextEditingController _pwd2controller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
//  init variables
  bool? _checkvalue = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _namecontroller.dispose();
    _phonecontroller.dispose();
    _pwd1controller.dispose();
    _pwd2controller.dispose();
    _usernamecontroller.dispose();
    super.dispose();
  }

// button submit clicked
  Future _onSubmit() async {
    FocusScope.of(context).unfocus();
    _loadingState(true);
    register(
            _namecontroller.text,
            _phonecontroller.text,
            _usernamecontroller.text,
            _emailcontroller.text,
            _pwd1controller.text,
            _pwd2controller.text)
        .then((response) {
      // check if successful
      if (response["message"] == "") {
        _loadingState(false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: f5("Registration Successful", 12, color: white),
          ),
        );
        // navigate to login
        push(context, const Login());
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/ecobg.png"), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/img/ecologo.png"),
                      vgap(40),
                      Align(
                        alignment: Alignment.topCenter,
                        child: text("Create Account", 18,
                            weight: FontWeight.w500, color: deepgreen),
                      ),
                      vgap(15),
                      inputbox("Full Name", _namecontroller),
                      vgap(15),
                      inputbox("Email", _emailcontroller),
                      vgap(15),
                      inputbox("Username", _usernamecontroller),
                      vgap(15),
                      inputbox("Phone Number", _phonecontroller),
                      vgap(15),
                      inputbox("Password", _pwd1controller, obs: true),
                      vgap(15),
                      inputbox("Confirm Password", _pwd2controller, obs: true),
                      vgap(15),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: white,
                            activeColor: deepgreen,
                            value: _checkvalue,
                            onChanged: ((value) =>
                                setState(() => _checkvalue = value)),
                          ),
                          f7("Remomber me", 12, color: deepgreen),
                          Expanded(child: Container()),
                          InkWell(
                            child:
                                f7("Forgotten Password?", 12, color: deepgreen),
                          ),
                        ],
                      ),
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
                            : f7("Sign up", 15, color: Colors.white),
                      ),
                      vgap(15),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login())),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              f7("Already have an acount?", 12,
                                  color: deepgreen),
                              f7("sign in", 12, color: white),
                            ],
                          ),
                        ),
                      ),
                      vgap(30)
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
