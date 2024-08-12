import 'package:blueberry_flutter_template/model/UserDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/UserModel.dart';

/// UserInfoProvider.dart
///
/// User Info Provider
/// - 사용자 정보 데이터를 제공하는 Provider
/// - fetchUserInfoStream(): 사용자 정보 데이터 불러오기
///
/// @jwson-automation

// 사용자의 인증 상태를 실시간으로 추적
final loginStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

// 로그인한 사용자의 UID를 추적
final userIdProvider = FutureProvider<String?>((ref) {
  final user = ref.watch(loginStateProvider).asData?.value;
  return user?.uid;
});

// 사용자 정보를 가져오는 공급자
final userDataLoadProvider = FutureProvider<UserModel>((ref) async {
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) throw Exception('User not logged in');
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userDoc.exists) {
    return UserModel.fromJson(userDoc.data()!);
  }
  throw Exception('User not found');
});

final getUserDataProvider = FutureProvider<UserDataModel>((ref) async {
  final userId = await ref.watch(userIdProvider.future);
  if (userId == null) throw Exception('User not logged in');

  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

  if (userDoc.exists) {
    final userData = userDoc.data()!;
    return UserDataModel.fromJson(userData);
  }

  throw Exception('User not found');
});

final userInfoNotifierProvider =
    StateNotifierProvider<UserNotifier, UserModel>((ref) {
  final user = ref.watch(userDataLoadProvider);
  return UserNotifier(user.maybeWhen(
      data: (user) => user,
      orElse: () => UserModel(
          userId: '익명',
          name: '익명',
          email: '',
          age: 123,
          mbti: 'NULL',
          profileImageUrl: '',
          isMemberShip: false,
          createdAt: DateTime.now(),
          userClass: 'user',
          likeGivens: [""])));
});

// 유저 정보 업데이트를 위한 노티파이어
class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier(super.state);

  Future<void> updateUser(
      {String? name, int? age, String? profilePicture, String? mbti}) async {
    try {
      final userId = state.userId;
      final updateData = <String, dynamic>{};
      if (name != null) updateData['name'] = name;
      if (age != null) updateData['age'] = age;
      if (profilePicture != null) updateData['profilePicture'] = profilePicture;
      if (mbti != null) updateData['mbti'] = mbti;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update(updateData);
    } catch (e) {
      print('Failed to update user data: $e');
    }
  }
}
