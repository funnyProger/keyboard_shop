import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_shop/core/models/current_user_model.dart';
import 'package:keyboard_shop/data/model_objects/user/new_user.dart';
import 'package:keyboard_shop/giu/widgets/authorization_widgets/sign_up_screen_widgets/sign_up_screen_container.dart';
import 'package:provider/provider.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultUserProfileWidget(context);
  }


  Widget defaultUserProfileWidget(BuildContext context) {
    if(context.watch<CurrentUserModel>().isCurrentUserLoggedIn()) {
      return userProfile(context);
    } else {
      return defaultProfile(context);
    }
  }

  Widget defaultProfile(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/default_female_avatar_1.svg',
              height: 300,
              width: 300,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
            alignment: Alignment.center,
            child: const Text(
              'To use all functions of the application, register \nor log in to your account',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        Expanded(
            flex: 5,
            child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const SignUpScreenContainerWidget()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.green,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                      textDirection: TextDirection.ltr,
                    ),

                  ),
                )
            )
        ),
      ],
    );
  }

  Widget userProfile(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 100,
              child: context.read<CurrentUserModel>().getCurrentUserImage() == '1' ? SvgPicture.asset(
                'assets/images/default_female_avatar_1.svg',
                height: 300,
                width: 300,
              ) : Image.asset(context.read<CurrentUserModel>().getCurrentUserImage())
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              'Phone number: ${context.read<CurrentUserModel>().getCurrentUserPhoneNumber()}',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              'Name: ${context.read<CurrentUserModel>().getCurrentUserName()}',
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
              ),
              textAlign: TextAlign.center,
              softWrap: true,
              textDirection: TextDirection.ltr,
            ),
          ),
        ),

        Expanded(
            flex: 5,
            child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    context.read<CurrentUserModel>()
                        .setCurrentUserAndSharedPreferencesData(
                        false,
                        NewUser(
                            image: 'assets/images/default_female_avatar_1.svg',
                            name: 'User',
                            phoneNumber: '^.^',
                            password: 'T_T',
                        )
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.green,
                    ),
                    child: const Text(
                      'Exit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                      textDirection: TextDirection.ltr,
                    ),

                  ),
                )
            )
        ),
      ],
    );
  }
}