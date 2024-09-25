import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_partner_app/commons/repo/get_profile.dart';
import 'package:studio_partner_app/commons/views/providers/profileprovider.dart';
import 'package:studio_partner_app/src/core/api.dart';
import 'package:studio_partner_app/src/feature/profile/repo/edit_profile.dart';
import 'package:studio_partner_app/commons/views/providers/authprovider.dart';
import 'package:studio_partner_app/utils/router.dart';

import '../models/profile.dart';

class Editprofile {
  Profile? profile;
  Editprofile({
    required this.profile,
  });

  Future<void> editProfile(WidgetRef ref, BuildContext context) async {
    final authToken = ref.read(authprovider);
    API api = API(authToken: authToken);
    Profile profileLocal = Profile(
        name: profile!.name,
        avatar: profile!.avatar,
        gender: profile!.gender,
        address: profile!.address,
        city: profile!.city,
        pincode: profile!.pincode,
        state: profile!.state,
        country: profile!.country,
        latitude: profile!.latitude,
        longitude: profile!.longitude,
        businessName: profile!.businessName);
    final response = await EditProfileRepo.editProfile(profileLocal, api);
    if (response == false) {
      context.mounted
          ? ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An unexpected error occurred'),
              ),
            )
          : null;
    } else {
      final response = context.mounted
          ? await GetProfileRepo.getProfile(authToken, context)
          : null;
      ref.read(profileProvider.notifier).setProfile(response!);
      // Map<String, dynamic> url = await GetImageUrl.getUploadUrl();
      // ref.read(imageUploadUrl.notifier).setImageUploadUrl(url['uploadUrl']);
      // ref.read(keyProvider.notifier).setKey(url['key']);
      context.mounted
          ? GoRouter.of(context).go(StudioRoutes.bottomNavBar)
          : null;
    }
  }
}
