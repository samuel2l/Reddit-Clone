import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/constants/constants.dart';
import 'package:reddit/features/auth/controller/auth_controller.dart';
import 'package:reddit/features/user%20profile/controller/user_profile_controller.dart';
import 'package:reddit/utils.dart';

class EditProfile extends ConsumerStatefulWidget {
  final String uId;
  const EditProfile({super.key, required this.uId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  File? bannerImg;
  File? dp;
late TextEditingController nameController;  

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController=TextEditingController(text: ref.read(userProvider)!.name);
  }
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void pickBanner() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        bannerImg = File(res.files.first.path!);
      });
          setState(() {
        
      });
    }
  }

  void pickDp() async {
    final res = await pickImage();
    if (res != null) {
      setState(() {
        dp = File(res.files.first.path!);
      });
      setState(() {
        
      });
    }
  }

  // void save(BuildContext context){
  //   ref.read(userProfileControllerProvider.notifier).editUserProfile(banner: bannerImg, dp: dp, context: context, name: nameController.text.trim());
  // // trim() to remove any leading or trailing whitespace.

  // }

void save()  {
   ref.read(userProfileControllerProvider.notifier).editUserProfile(
    banner: bannerImg,
    dp: dp,
    context: context,
    name: nameController.text.trim(),
  );

}


  @override
  Widget build(BuildContext context) {
final isLoading=ref.watch(userProfileControllerProvider);
    return ref.watch(getUserDataProvider(widget.uId)).when(
          data: (data) {

            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Edit Profile'),
                  centerTitle: false,
                  actions: [
                    TextButton(
                      onPressed: ()=>save(),
                      child: const Text('Save'),
                    ),
                  ],
                ),
                body: isLoading?const Center(child: CircularProgressIndicator()):Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 6),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: ()=>pickBanner(),
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(10),
                                          dashPattern: const [10, 4],
                                          strokeCap: StrokeCap.round,
                                          color: Colors.white,
                                          child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            child: bannerImg != null
                                                ? Image.file(
                                                    bannerImg!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : data!.banner.isEmpty ||
                                                        data.banner ==
                                                            bannerDefault
                                                    ? const Center(
                                                        child: Icon(
                                                          Icons
                                                              .camera_alt_outlined,
                                                          size: 40,
                                                        ),
                                                      )
                                                    : Image.network(data.banner),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 20,
                                    bottom: 20,
                                    child: GestureDetector(
                                      onTap:  ()=>pickDp(),
                                      child: CircleAvatar(
                                        backgroundImage: dp != null
                                            ? FileImage(dp!)
                                            : NetworkImage(data!.dp)
                                                as ImageProvider,
                                        radius: 32,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                           TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              filled: true,
                              hintText:'Name',
                              focusedBorder: OutlineInputBorder(
                                borderSide:  const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(18)

                            ),
                          )
                          ],
                        ),
                        
                      ),
                      ),

            );
          },
          error: (error, stackTrace) =>
              Center(child: Text(error.toString())),
          loading: () =>
              const Center(child: CircularProgressIndicator()),
        );
  }
}
