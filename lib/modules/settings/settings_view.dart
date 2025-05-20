// settings_view.dart
// 设置页面，支持主题色与主题模式的切换，界面简洁直观
// 通过下拉选择器实现主题相关设置，所有更改实时生效

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/data/controllers/settings_controller.dart';
import 'package:xperinote/app/theme/app_theme.dart';

/// 设置页面组件
///
/// 提供主题颜色和主题模式的选择，所有设置通过 SettingsController 实时生效。
class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  /// 全局设置控制器，负责主题色与模式的管理
  final SettingsController _settings = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 主题色选择器
            _buildThemeColorPicker(context),
            const SizedBox(height: 24),
            // 主题模式选择器
            _buildThemeModeSelector(context),
          ],
        ),
      ),
    );
  }

  /// 构建主题色选择器
  Widget _buildThemeColorPicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('主题颜色', style: Theme.of(context).textTheme.titleMedium),
        DropdownButtonFormField<MaterialColor>(
          value: _settings.primaryColor,
          items:
              AppTheme.presetColors.map((color) {
                return DropdownMenuItem<MaterialColor>(
                  value: color,
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(_getColorName(color)),
                    ],
                  ),
                );
              }).toList(),
          onChanged: (color) => _settings.updatePrimaryColor(color!),
        ),
      ],
    );
  }

  /// 构建主题模式选择器
  Widget _buildThemeModeSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('主题模式', style: Theme.of(context).textTheme.titleMedium),
        DropdownButtonFormField<String>(
          value: _settings.themeMode,
          items: const [
            DropdownMenuItem<String>(value: 'system', child: Text('跟随系统')),
            DropdownMenuItem<String>(value: 'light', child: Text('浅色模式')),
            DropdownMenuItem<String>(value: 'dark', child: Text('深色模式')),
          ],
          onChanged: (mode) => _settings.updateThemeMode(mode!),
        ),
      ],
    );
  }

  /// 获取主题色的中文名称
  String _getColorName(Color color) {
    switch (color) {
      case Colors.red:
        return '红色';
      case Colors.green:
        return '绿色';
      case Colors.blue:
        return '蓝色';
      case Colors.yellow:
        return '黄色';
      case Colors.purple:
        return '紫色';
      case Colors.orange:
        return '橙色';
      case Colors.teal:
        return '青色';
      case Colors.cyan:
        return '青绿色';
      default:
        return '未知颜色';
    }
  }
}
