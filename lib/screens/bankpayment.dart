import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technovationapp/utilities/router.dart';
import 'package:technovationapp/utilities/textfield.dart';
import 'package:technovationapp/requestmodels/bankcheckout.dart';
import 'package:technovationapp/requestmodels/usersclass.dart';
import 'package:technovationapp/screens/dashboard.dart';
import 'package:technovationapp/utilities/variables.dart';
import '../constants/colors.dart';
import '../utilities/font.dart';
import 'package:uuid/uuid.dart';

class BankPayment extends StatefulWidget {
  const BankPayment({super.key});

  @override
  State<BankPayment> createState() => _BankPaymentState();
}

class _BankPaymentState extends State<BankPayment> {
  final TextEditingController _accountname = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _accountnumber = TextEditingController();
  String _selectedbank = "Select Bank";
  String? token = "";

  bool isProcessing = false;

  @override
  void initState() {
    setState(() {
      token = const Uuid().v4();
    });
    // print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Users>(context, listen: true).user;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // backgroundColor: white,
        appBar: AppBar(
          backgroundColor: transparent,
          elevation: 0,
          title: f5("Bank Cashout", 16),

          // cart icon
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10, top: 15),
                child:
                    text("∆${user.data!.balance!.toStringAsPrecision(3)}", 16)),
          ],
          // pop icon
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: deepgreen,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                vgap(10),
                inputbox("Acoount Name", _accountname),
                vgap(10),
                inputbox("Acoount Number", _accountnumber,
                    keyboard: TextInputType.number),
                vgap(10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    isExpanded: true,
                    hint: f1(_selectedbank, 14, color: blacklight),
                    items: <String>[
                      "Acess Bank",
                      "UBA Bank",
                      "Kuda MIcrofinance Bank",
                      "Zenith Bank"
                    ].map((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: f1(val, 14, color: blacklight),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedbank = value!),
                  ),
                ),
                vgap(10),
                inputbox("Amount", _amount, keyboard: TextInputType.number),
                vgap(10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: deepgreen,
                    ),
                    onPressed: () async => proceedPayment(
                      "$_selectedbank,${_accountnumber.text}",
                      token,
                      user.data!.username,
                      _accountname.text,
                      double.parse(_amount.text),
                    ),
                    child: f1("Proceed", 15),
                  ),
                ),
                vgap(10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future proceedPayment(bank, token, username, name, amount) async {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: isProcessing
                ? null
                : f1('proceed to Cashout', 15, color: black),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  isProcessing
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: green,
                            strokeWidth: 1,
                          ),
                        )
                      : f1('Are you sure you want to cashout', 13,
                          color: black),
                ],
              ),
            ),
            actions: isProcessing
                ? null
                : <Widget>[
                    TextButton(
                      child: f1("Yes", 14, color: deepgreen),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        setState(() => isProcessing = true);
                        payment(bank, token, username, name, amount);
                      },
                    ),
                  ],
          );
        });
  }

  payment(bank, token, username, name, amount) async =>
      bankpay(bank, token, username, name, amount).then((value) async {
        if (value["status"] == true) {
          await users(context).then((value) {
            // show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: f5("Transfer successful.", 12, color: white),
              ),
            );
            setState(() => isProcessing = false);
            // go back to dashboard page
            pushUntil(context, const Dashboard());
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: f5(value["message"], 12, color: white),
            ),
          );
          setState(() => isProcessing = false);
        }
      });
}
// ["Acess Bank", "UBA Bank","Kuda MIcrofinance Bank","Zenith Bank"]
