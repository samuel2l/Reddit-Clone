// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostType extends ConsumerStatefulWidget {
  final String type;
   const AddPostType({super.key, 
    required this.type,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostTypeState();
}

class _AddPostTypeState extends ConsumerState<AddPostType> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}