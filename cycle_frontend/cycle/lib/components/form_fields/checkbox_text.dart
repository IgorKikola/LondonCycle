import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../pages/terms_policy_pages/privacy_policy_page.dart';
import '../../pages/terms_policy_pages/terms_of_use_page.dart';

class CheckboxText extends StatelessWidget {
  const CheckboxText({
    Key? key,
    required this.termsAndPolicyWereNotChecked,
  }) : super(key: key);

  final bool termsAndPolicyWereNotChecked;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "I accept the ",
            style: TextStyle(
              color: termsAndPolicyWereNotChecked
                  ? Theme.of(context).errorColor
                  : Colors.white,
              fontWeight: termsAndPolicyWereNotChecked
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: "Terms of Use ",
            style: TextStyle(
                color: termsAndPolicyWereNotChecked
                    ? Theme.of(context).errorColor
                    : Colors.blueAccent,
                fontWeight: termsAndPolicyWereNotChecked
                    ? FontWeight.bold
                    : FontWeight.normal,
                decoration: termsAndPolicyWereNotChecked
                    ? TextDecoration.underline
                    : TextDecoration.none),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, TermsOfUsePage.id);
              },
          ),
          TextSpan(
            text: "& ",
            style: TextStyle(
              color: termsAndPolicyWereNotChecked
                  ? Theme.of(context).errorColor
                  : Colors.white,
              fontWeight: termsAndPolicyWereNotChecked
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(
              color: termsAndPolicyWereNotChecked
                  ? Theme.of(context).errorColor
                  : Colors.blueAccent,
              fontWeight: termsAndPolicyWereNotChecked
                  ? FontWeight.bold
                  : FontWeight.normal,
              decoration: termsAndPolicyWereNotChecked
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, PrivacyPolicyPage.id);
              },
          ),
        ],
      ),
    );
  }
}
