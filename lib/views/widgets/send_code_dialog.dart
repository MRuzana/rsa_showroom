import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/constants/string_constants.dart';
import 'package:rsa_showroom/core/themes/text_styles.dart';


void showCustomDialog(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      bool isLoading = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red, width: 1.5),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign In with phone number",
                    style: AppTextStyles.textXSmallGrey,
                  ),
                  SizedBox(height: 10),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    alertTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color(0xFFFF0000),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                setState(() => isLoading = true);
                                // if (await ConnectionChecker.checkConnection(context)) {
                                //   final bool isSent = await OtpService().sendOtp(phoneNumber);
                                //   if (isSent) {
                                //     Navigator.pushNamedAndRemoveUntil(
                                //       context,
                                //       '/enterOtp',
                                //       (route) => false,
                                //       arguments: {'phone': phoneNumber},
                                //     );
                                //   } else {
                                //     setState(() => isLoading = false);
                                //   }
                                // } else {
                                //   setState(() => isLoading = false);
                                // }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF0000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Next",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}












// void showCustomDialog(BuildContext context, String phoneNumber) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevent closing when tapping outside
//     builder: (context) {

      
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//             border: Border.all(color: Colors.red, width: 1.5),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Shrinks to fit content
//             children: [
//               Text(
//                 "Sign In with phone number",
//                 style: AppTextStyles.textXSmallGrey,
//               ),
//               SizedBox(height: 10),
//               Text(
//                 phoneNumber,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 alertTitle,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       "Cancel",
//                       style: TextStyle(
//                         color: Color(0xFFFF0000),
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () async {
//                      if (await ConnectionChecker.checkConnection(context)) {
//                         final bool isSent = await OtpService().sendOtp(phoneNumber);
//                         if (isSent) {
//                           Navigator.pushNamedAndRemoveUntil(
//                             context,
//                             '/enterOtp',
//                             (route) => false,
//                             arguments: {'phone': phoneNumber},
//                           );
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFFFF0000),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Next",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
