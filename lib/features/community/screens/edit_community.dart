import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/themes/pallette.dart';

class EditCommunity extends ConsumerStatefulWidget {
  final String name;
  const EditCommunity( {super.key,required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditCommunityState();
}

class _EditCommunityState extends ConsumerState<EditCommunity> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Pallete.darkModeAppTheme.dialogBackgroundColor,
      appBar: AppBar(
        title: const Text('Edit Community'),
        centerTitle: false,
        actions: [
          TextButton(onPressed: (){}, child: const Text('Save')),
        ],
      ),
      body:  Column(
        children: [
          DottedBorder(child: Container())
        ],
      ),
    ));
  }
}