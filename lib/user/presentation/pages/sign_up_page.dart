import 'package:favorite_places_app/user/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/user.dart';
import '../bloc/user_bloc.dart';

class SignUpPage extends StatelessWidget {

  SignUpPage({super.key});

  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> GlobalKeyForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if(state is UserLoadingState) {
            return CircularProgressIndicator();
          }
          if(state is UserInitial) {
            return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: GlobalKeyForm,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: name,
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'field can not be null';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'field can not be null';
                          }
                          if (text.length < 6 ||
                              !text.contains('@') ||
                              !text.endsWith('.com') ||
                              text.startsWith('@')) {
                            return 'Wrong data ';
                          } else
                            return null;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'field can not be null';
                          }
                          if (text.length < 8) {
                            return 'password must be strong';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Container(
                        width: double.infinity,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple,
                        ),
                        child: MaterialButton(
                          onPressed: () async {
                            if (GlobalKeyForm.currentState!.validate()) {
                              User user = User(
                                  name: name.text,
                                  email: email.text,
                                  password: password.text);
                              context
                                  .read<UserBloc>()
                                  .add(SetUserEvent(user: user));
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                       LoginPage()));
                            }
                          },
                          child: Text(
                            'Sign up',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),


                    ],
                  ),
                ),
              ),
            ),
          );
          }
          return SizedBox();
        },
      ),
    );
  }
}
