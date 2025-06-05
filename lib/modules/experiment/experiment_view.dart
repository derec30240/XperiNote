// experiment_view.dart
// 实验模块主页面，负责实验的展示、创建、批量操作等交互逻辑
// 支持进行中/已完成实验的切换、实验的多选与批量删除、实验的创建弹窗等

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/modules/experiment/widgets/experiment_card.dart';

/// 实验主页面，负责实验列表的展示、创建、批量操作等
class ExperimentView extends GetView<ExperimentController> {
  const ExperimentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Obx(() => _buildContent()),
          floatingActionButton: FloatingActionButton(
            onPressed: _showCreateDialog,
            child: const Icon(Icons.add),
          ),
          bottomSheet: _buildBottomSheet(),
        ),
      ),
    );
  }

  /// 构建顶部 AppBar，支持多选模式下的返回与全选
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Obx(
        () =>
            controller.isSelectionMode.value
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: controller.exitSelectionMode,
                )
                : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
      ),
      title: Obx(
        () => Text(
          controller.isSelectionMode.value
              ? '已选 ${controller.selectedIds.length} 项'
              : '实验',
        ),
      ),
      actions: [
        Obx(
          () =>
              controller.isSelectionMode.value
                  ? IconButton(
                    icon: const Icon(Icons.select_all),
                    onPressed: controller.toggleSelectAll,
                  )
                  : const SizedBox.shrink(),
        ),
      ],
      bottom: TabBar(
        tabs: const [
          Tab(text: '草稿'),
          Tab(text: '进行中'),
          Tab(text: '已暂停'),
          Tab(text: '已完成'),
        ],
      ),
    );
  }

  /// 根据当前异步状态构建内容区域
  Widget _buildContent() {
    return switch (controller.status) {
      AsyncStatus.loading => const Center(child: CircularProgressIndicator()),
      AsyncStatus.success => TabBarView(
        children: [
          Obx(() => _buildExperimentList(controller.draftExperiments)),
          Obx(() => _buildExperimentList(controller.ongoingExperiments)),
          Obx(() => _buildExperimentList(controller.pausedExperiments)),
          Obx(() => _buildExperimentList(controller.completedExperiments)),
        ],
      ),
      AsyncStatus.error => _buildErrorState(),
    };
  }

  /// 构建实验列表
  Widget _buildExperimentList(List<Experiment> experiments) {
    if (experiments.isEmpty) {
      return const Center(child: Text('没有实验'));
    }
    return ListView.builder(
      itemCount: experiments.length,
      itemBuilder: (context, index) {
        return SelectableExperimentCard(
          key: ValueKey(experiments[index].id),
          experiment: experiments[index],
        );
      },
      padding: const EdgeInsets.all(16.0),
    );
  }

  /// 构建错误状态提示
  Widget _buildErrorState() {
    return const Center(child: Text('数据加载失败'));
  }

  /// 弹出新建实验对话框
  void _showCreateDialog() {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();

    showDialog(
      context: Get.context!,
      builder:
          (context) => AlertDialog(
            title: const Text('新建实验'),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: '实验名称',
                  hintText: '请输入实验名称',
                ),
                validator: (value) => value?.isEmpty ?? true ? '标题不能为空' : null,
              ),
            ),
            actions: [
              TextButton(onPressed: Get.back, child: const Text('取消')),
              FilledButton(
                onPressed:
                    () => _handleCreateExperiment(
                      formKey,
                      titleController.text.trim(),
                    ),
                child: const Text('创建'),
              ),
            ],
          ),
    );
  }

  /// 处理实验创建逻辑，校验表单并添加实验
  void _handleCreateExperiment(GlobalKey<FormState> formKey, String title) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final experiment = Experiment(
      id: const Uuid().v4(),
      title: title,
      createAt: DateTime.now(),
      lastModifiedAt: DateTime.now(),
    );

    controller.addExperiment(experiment);
    Get.back();
  }

  /// 构建底部批量操作栏（多选模式下显示）
  Widget _buildBottomSheet() {
    return Obx(
      () =>
          controller.isSelectionMode.value
              ? Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16.0),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.push_pin,
                      label: '置顶',
                      onPressed: () {},
                    ),
                    _buildActionButton(
                      icon: Icons.folder_copy,
                      label: '组合',
                      onPressed: () {},
                    ),
                    _buildActionButton(
                      icon: Icons.delete,
                      label: '删除',
                      onPressed: _showDeleteDialog,
                      color: Colors.red,
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
    );
  }

  /// 构建底部操作栏按钮
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return TextButton.icon(
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color)),
      onPressed: onPressed,
    );
  }

  /// 弹出批量删除确认对话框
  void _showDeleteDialog() {
    showDialog(
      context: Get.context!,
      builder:
          (context) => AlertDialog(
            title: const Text('删除实验'),
            content: Text('确定要删除选中的 ${controller.selectedIds.length} 项实验吗？'),
            actions: [
              TextButton(onPressed: Get.back, child: const Text('取消')),
              FilledButton(
                onPressed: () {
                  controller.deleteSelectedExperiments();
                  Get.back();
                },
                child: const Text('删除'),
              ),
            ],
          ),
    );
  }
}
