import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../favorite_place/presentation/pages/favorite_places_page.dart';
import '../bloc/user_bloc.dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = TextEditingController();

  var password = TextEditingController();

  GlobalKey<FormState> keyLogin = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> FavoritePlacesPage()));
          }
        },
        builder: (context, state) {
          if(state is UserLoadingState)
            {
              return CircularProgressIndicator();
            }

            return Form(
            key: keyLogin,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,

                          ),
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
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.lock,

                          ),
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
                          onPressed: () {
                            if(keyLogin.currentState!.validate()) {
                              context.read<UserBloc>().add(GetUserEvent());
                            }
                          },
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont have an acount ? ',
                            style: TextStyle(
                                fontSize: 18
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) => SignUpPage()));
                            },
                            child: Text(
                                'Register now ',
                                style: TextStyle(
                                    fontSize: 18
                                )
                            ),)
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
