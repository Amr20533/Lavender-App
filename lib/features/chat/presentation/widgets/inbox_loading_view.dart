import 'package:flutter/material.dart';
import 'package:lavender/features/chat/data/models/chat/inbox_user_profile.dart';
import 'package:lavender/features/chat/presentation/widgets/inbox_card.dart';
import 'package:lavender/features/profile/data/models/UserProfile.dart';
import 'package:lavender/features/profile/data/models/user.dart';

class InboxLoadingView extends StatelessWidget {
  const InboxLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 6,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (_, __) => InboxCard(
        // Placeholder data for Shimmer
        user: InboxUserProfile(user: User(id: 0, firstName: '', lastName: '', email: '')),
        message: '',
        isLoading: true,
        onTap: () {}, time: DateTime.timestamp(),
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
    );
  }
}