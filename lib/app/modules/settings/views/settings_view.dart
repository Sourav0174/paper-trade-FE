import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/settings/controllers/settings_controller.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark
                ? AppColors.darkPrimaryText
                : AppColors.lightPrimaryText,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline_rounded,
              color: isDark
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64.w,
                        height: 64.h,
                        decoration: const BoxDecoration(
                          color: AppColors.lightPrimary,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'RK',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppColors.lightOnPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userName.value,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkPrimaryText
                                        : AppColors.lightPrimaryText,
                                  ),
                            ),
                            Text(
                              controller.userEmail.value,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: isDark
                                        ? AppColors.darkSecondaryText
                                        : AppColors.lightSecondaryText,
                                  ),
                            ),
                            SizedBox(height: 4.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff4ade8022),
                                borderRadius: BorderRadius.circular(9999.r),
                                border: Border.all(
                                  color: AppColors.lightSuccess,
                                ),
                              ),
                              child: Text(
                                'PRO MEMBER',
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: AppColors.lightSuccess,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_rounded,
                          color: AppColors.lightPrimary,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              _buildSectionHeader(context, 'ACCOUNT', isDark),
              _buildSettingsItem(
                context,
                icon: Icons.person_outline_rounded,
                title: 'Personal Information',
                subtitle: 'Change your name, email, and phone',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint,
                ),
                isDark: isDark,
              ),
              _buildSettingsItem(
                context,
                icon: Icons.account_balance_wallet_outlined,
                title: 'Virtual Funds',
                subtitle: 'Reset your ₹1,00,000 balance',
                trailing: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.lightPrimary,
                ),
                isDark: isDark,
              ),
              SizedBox(height: 24.h),
              _buildSectionHeader(context, 'PREFERENCES', isDark),
              Obx(
                () => _buildSettingsItem(
                  context,
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch app appearance',
                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    onChanged: controller.toggleDarkMode,
                    activeThumbColor: AppColors.lightPrimary,
                  ),
                  isDark: isDark,
                ),
              ),
              Obx(
                () => _buildSettingsItem(
                  context,
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Price alerts and trade updates',
                  trailing: Switch(
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.toggleNotifications,
                    activeThumbColor: AppColors.lightPrimary,
                  ),
                  isDark: isDark,
                ),
              ),
              _buildSettingsItem(
                context,
                icon: Icons.language_rounded,
                title: 'App Language',
                subtitle: 'English (India)',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint,
                ),
                isDark: isDark,
              ),
              SizedBox(height: 24.h),
              _buildSectionHeader(context, 'SUPPORT & SECURITY', isDark),
              _buildSettingsItem(
                context,
                icon: Icons.lock_outline_rounded,
                title: 'Privacy Policy',
                subtitle: '',
                trailing: Icon(
                  Icons.open_in_new_rounded,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint,
                  size: 18.sp,
                ),
                isDark: isDark,
              ),
              _buildSettingsItem(
                context,
                icon: Icons.headset_mic_outlined,
                title: 'Help & Support',
                subtitle: '',
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: isDark ? AppColors.darkHint : AppColors.lightHint,
                ),
                isDark: isDark,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 56.h,
                child: OutlinedButton.icon(
                  onPressed: controller.logout,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Logout'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.lightError,
                    side: const BorderSide(color: AppColors.lightError),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Column(
                children: [
                  Text(
                    'Paper Trade v2.4.0',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isDark ? AppColors.darkHint : AppColors.lightHint,
                    ),
                  ),
                  Text(
                    'Made with ❤️ for Indian Traders',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isDark ? AppColors.darkHint : AppColors.lightHint,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.lightPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.lightPrimary, size: 22.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.darkPrimaryText
                        : AppColors.lightPrimaryText,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
