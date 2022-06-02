import 'dart:io';

import 'package:cuevaDelRecambio/domain/services/providers/theme_provider.dart';
import 'package:cuevaDelRecambio/domain/utils/parsers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String name = GetIt.I<FirebaseAuth>().currentUser.displayName;
  String email = GetIt.I<FirebaseAuth>().currentUser.email;
  bool emailVerified = GetIt.I<FirebaseAuth>().currentUser.emailVerified;
  bool phoneVerified = GetIt.I<FirebaseAuth>().currentUser.phoneNumber != null && GetIt.I<FirebaseAuth>().currentUser.phoneNumber != '';
  String phoneNumber =
      (GetIt.I<FirebaseAuth>().currentUser.phoneNumber ?? "No phone") != ''
          ? GetIt.I<FirebaseAuth>().currentUser.phoneNumber
          : "No phone";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder().copyWith(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white12
                            : Colors.black12,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Provider.of<ThemeProvider>(context).isDarkMode
                            ? Colors.white
                            : Colors.black54,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      "Edit Profile",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  buildChangeName(context),
                  const SizedBox(height: 10),
                  buildChangePassword(context),
                  const SizedBox(height: 10),
                  buildChangeEmail(context),
                  const SizedBox(height: 10),
                  buildChangePhoneNumber(context),
                  const SizedBox(height: 10),
                  buildChangeAvatar(context),
                ],
              ),
            ),
          )),
    );
  }

  buildChangeName(context) => Card(
        child: ListTile(
          style: Theme.of(context).listTileTheme.style,
          title: Text('Name'),
          leading: Icon(Icons.person),
          trailing: Icon(Icons.edit),
          subtitle: Text(name),
          onTap: () async {
            TextEditingController controller = TextEditingController();
            bool isSaved = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Name'),
                    content: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          GetIt.I
                              .get<FirebaseAuth>()
                              .currentUser
                              .updateDisplayName(controller.text);
                          Navigator.of(context).pop(true);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Name changed'),
                          ));
                        },
                      ),
                    ],
                  );
                });
            if (isSaved ?? false) {
              setState(() {
                name = controller.text;
              });
            }
          },
        ),
      );

  buildChangePassword(context) => Card(
        child: ListTile(
          title: Text('Password'),
          leading: Icon(Icons.password),
          trailing: Icon(Icons.edit),
          onTap: () async {
            TextEditingController oldController = TextEditingController();
            TextEditingController controller = TextEditingController();
            TextEditingController confirmController = TextEditingController();

            bool isSaved = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Password'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          obscureText: true,
                          controller: oldController,
                          decoration: InputDecoration(
                            hintText: 'Enter your old password',
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          controller: confirmController,
                          decoration: InputDecoration(
                            hintText: 'Enter your password again',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () async {
                          bool _isSaved = await checkPassword(
                              oldController.text,
                              controller.text,
                              confirmController.text);
                          if (_isSaved) {
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Password changed'),
                            ));
                            print('Password changed');
                          } else {
                            Navigator.of(context).pop(false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Password not changed'),
                            ));
                            print('Password not changed');
                          }
                        },
                      ),
                    ],
                  );
                });
            if (isSaved ?? false) {
              setState(() {});
            }
          },
        ),
      );

  Future<bool> checkPassword(String old, String newPass, String confirm) async {
    bool isSaved = false;
    if (old.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      return false;
    }
    if (newPass != confirm) {
      return false;
    }
    var credential = EmailAuthProvider.credential(
        email: GetIt.I<FirebaseAuth>().currentUser.email, password: old);
    if (credential == null) {
      return false;
    }
    isSaved = await GetIt.I<FirebaseAuth>()
        .currentUser
        .reauthenticateWithCredential(credential)
        .then((value) {
      GetIt.I<FirebaseAuth>().currentUser.updatePassword(newPass);
      return true;
    }).catchError((error) {
      return false;
    });
    return isSaved;
  }

  buildChangeEmail(context) => Card(
        child: ListTile(
            title: Text('Email'),
            leading: Icon(Icons.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    emailVerified ? Icons.check : Icons.error,
                    color: emailVerified ? Colors.green : Colors.red,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Email'),
                          content: Text(
                              'An email will be sent to your email: ($email)'),
                          actions: [
                            ElevatedButton(
                              child: Text('Ok'),
                              onPressed: () async {
                                GetIt.I
                                    .get<FirebaseAuth>()
                                    .currentUser
                                    .sendEmailVerification();
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      }),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  child: Icon(Icons.edit),
                ),
              ],
            ),
            subtitle: Text('${email ?? 'No email'}'),
            onTap: () async {
              TextEditingController controller = TextEditingController();
              bool isSaved = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Email'),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          child: Text('Save'),
                          onPressed: () {
                            controller.text = parseEmail(controller.text);
                            if (controller.text == null) {
                              Navigator.of(context).pop(false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Email not changed'),
                              ));
                              return;
                            }
                            GetIt.I
                                .get<FirebaseAuth>()
                                .currentUser
                                .updateEmail(controller.text);
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Email changed'),
                            ));
                          },
                        ),
                      ],
                    );
                  });
              if (isSaved ?? false) {
                setState(() {
                  email = controller.text;
                });
              }
            }),
      );

  buildChangeAvatar(context) => Card(
        child: ListTile(
            title: Text('Avatar'),
            leading: Icon(Icons.image),
            trailing: Icon(Icons.edit),
            onTap: () async {
              XFile image =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              String url;
              if (image != null) {
                await GetIt.I
                    .get<FirebaseStorage>()
                    .ref()
                    .child(
                        'avatar/${GetIt.I.get<FirebaseAuth>().currentUser.uid}')
                    .putFile(File(image.path))
                    .then((value) async {
                  await GetIt.I
                      .get<FirebaseStorage>()
                      .ref()
                      .child(
                          'avatar/${GetIt.I.get<FirebaseAuth>().currentUser.uid}')
                      .getDownloadURL()
                      .then((value) async {
                    url = value;
                  });
                });
              }
              if (url != null) {
                await GetIt.I
                    .get<FirebaseAuth>()
                    .currentUser
                    .updatePhotoURL(url);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Avatar changed'),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Avatar not changed'),
                ));
              }
            }),
      );

  buildChangePhoneNumber(context) => Card(
        child: ListTile(
          title: Text('Phone Number (Soon)'),
          leading: Icon(Icons.phone),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(phoneVerified ? Icons.check : Icons.error,
                color: phoneVerified ? Colors.green : Colors.red),
            const SizedBox(width: 10),
            Icon(Icons.edit),
          ]),
          subtitle: Text('$phoneNumber'),
          // onTap: () async {
          //   TextEditingController phoneController = TextEditingController();
          //   TextEditingController codeController = TextEditingController();
          //   await showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Phone Number'),
          //           content: TextField(
          //             controller: phoneController,
          //             decoration: InputDecoration(
          //               hintText: 'Enter your phone number',
          //             ),
          //           ),
          //           actions: [
          //             ElevatedButton(
          //               child: Text('Save'),
          //               onPressed: () async {
          //                 Navigator.of(context).pop(true);
          //                 String _providerId;
          //                 int _code;
          //                 await GetIt.I.get<FirebaseAuth>().verifyPhoneNumber(
          //                     phoneNumber: phoneController.text,
          //                     timeout: Duration(seconds: 60),
          //                     verificationCompleted:
          //                         (AuthCredential credential) {
          //                       _providerId = credential.providerId;
          //                     },
          //                     codeSent: (id, code) {
          //                       _code = code;
          //                     });

          //                 if (_providerId.isNotEmpty && _code != null) {
          //                   showDialog(
          //                       context: context,
          //                       builder: (context) => AlertDialog(
          //                             title: Text('Code'),
          //                             content: TextField(
          //                               controller: codeController,
          //                               decoration: InputDecoration(
          //                                 hintText: 'Enter code',
          //                               ),
          //                             ),
          //                             actions: [
          //                               ElevatedButton(
          //                                 child: Text('Save'),
          //                                 onPressed: () async {
          //                                   if (_code.toString() ==
          //                                       codeController.text) {
          //                                     AuthCredential credential =
          //                                         PhoneAuthProvider.credential(
          //                                             verificationId:
          //                                                 _providerId,
          //                                             smsCode:
          //                                                 codeController.text);
          //                                     await GetIt.I
          //                                         .get<FirebaseAuth>()
          //                                         .currentUser
          //                                         .updatePhoneNumber(
          //                                             credential);
          //                                     Navigator.of(context).pop(true);
          //                                     ScaffoldMessenger.of(context)
          //                                         .showSnackBar(SnackBar(
          //                                       content: Text(
          //                                           'Phone number changed'),
          //                                     ));
          //                                   } else {
          //                                     Navigator.of(context).pop(false);
          //                                     ScaffoldMessenger.of(context)
          //                                         .showSnackBar(SnackBar(
          //                                       content: Text(
          //                                           'Phone number not changed'),
          //                                     ));
          //                                   }
          //                                 },
          //                               ),
          //                             ],
          //                           ));
          //                 }
          //               },
          //             ),
          //           ],
          //         );
          //       });
          // },
        ),
      );
}
