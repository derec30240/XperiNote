import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';
import 'package:xperinote/data/models/experiment_step.dart';

class ExperimentDetailView extends GetView<ExperimentController> {
  final String currentId;

  const ExperimentDetailView({super.key, required this.currentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Obx(() {
        final currentExperiment = controller.getExperiment(currentId).value;
        return currentExperiment == null
            ? const Center(child: Text('未找到实验'))
            : buildBody(context, currentExperiment);
      }),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.push_pin_outlined)),
      ],
    );
  }

  Widget buildBody(BuildContext context, Experiment exp) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildLeading(context, exp),
        _buildActionButtons(exp),
        _buildStatusCard(exp),
        exp.tags == null || exp.tags!.isEmpty
            ? SizedBox.shrink()
            : _buildTagsCard(context, exp.tags!),
        _buildStepsCard(context, exp),
        exp.data == null || exp.data!.records.isEmpty
            ? SizedBox.shrink()
            : _buildDataCard(context, exp),
        exp.history == null || exp.history!.isEmpty
            ? SizedBox.shrink()
            : _buildHistoryCard(context, exp),
        Divider(),
        _buildSettingsList(context),
        Divider(),
        _buildTrailing(exp),
      ],
    );
  }

  Widget _buildLeading(BuildContext context, Experiment exp) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        children: [
          Text(
            exp.title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(exp.description ?? '无描述', textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Experiment exp) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            spacing: 4.0,
            children: [
              IconButton.filledTonal(
                onPressed:
                    exp.status == ExperimentStatus.ongoing ? () {} : null,
                icon: const Icon(Icons.pause),
              ),
              const Text('暂停实验'),
            ],
          ),
          Column(
            spacing: 4.0,
            children: [
              IconButton.filledTonal(
                onPressed:
                    (exp.status == ExperimentStatus.draft &&
                                exp.steps != null) ||
                            exp.status == ExperimentStatus.paused ||
                            exp.status == ExperimentStatus.completed
                        ? () {}
                        : null,
                icon: const Icon(Icons.play_arrow),
              ),
              const Text('开始实验'),
            ],
          ),
          Column(
            spacing: 4.0,
            children: [
              IconButton.filledTonal(
                onPressed:
                    exp.status == ExperimentStatus.ongoing ||
                            exp.status == ExperimentStatus.paused
                        ? () {}
                        : null,
                icon: const Icon(Icons.stop),
              ),
              const Text('中止实验'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(Experiment exp) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 8.0,
          children: [
            Icon(switch (exp.status) {
              ExperimentStatus.draft => Icons.drafts,
              ExperimentStatus.ongoing => Icons.access_time,
              ExperimentStatus.paused => Icons.pause_circle_outline,
              ExperimentStatus.completed => Icons.check_circle_outline,
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前状态：${exp.status.name.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                exp.status == ExperimentStatus.ongoing
                    ? Text(
                      '开始时间：${DateFormat('yyyy-MM-dd HH:mm').format(exp.startAt!)}',
                    )
                    : SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepsCard(BuildContext context, Experiment exp) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              spacing: 8.0,
              children: [
                const Icon(Icons.biotech_outlined),
                Text(
                  '实验步骤',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            exp.steps == null
                ? TextButton(
                  onPressed: () => _showAddStepDialog(exp),
                  child: Text('添加实验步骤'),
                )
                : ListView.separated(
                  shrinkWrap: true,
                  itemCount: exp.steps!.length,
                  itemBuilder: (ctx, index) {
                    return Row(
                      spacing: 8.0,
                      children: [
                        Text('${index + 1}'),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp.steps![index].title,
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                exp.steps![index].description ?? '无描述',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCard(BuildContext context, Experiment exp) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              spacing: 8.0,
              children: [
                const Icon(Icons.assessment_outlined),
                Text(
                  '实验数据汇总',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ListView.separated(
              itemCount: exp.data!.records.length,
              itemBuilder: (ctx, index) {
                return Row(
                  spacing: 8.0,
                  children: [
                    Text('$index'),
                    Column(
                      children: [
                        Text(exp.steps![index].title),
                        Text(exp.steps![index].description ?? '无描述'),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Experiment exp) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              spacing: 8.0,
              children: [
                const Icon(Icons.history_outlined),
                Text(
                  '历史记录',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ListView.separated(
              itemCount: exp.history!.length,
              itemBuilder: (ctx, index) {
                return Row(
                  spacing: 8.0,
                  children: [
                    Text('$index'),
                    Column(
                      children: [
                        Text(
                          '开始时间：${DateFormat('yyyy-MM-dd HH:mm').format(exp.history![index].startAt)}',
                        ),
                        Text(
                          '结束时间：${DateFormat('yyyy-MM-dd HH:mm').format(exp.history![index].startAt)}',
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTagsCard(BuildContext context, List<String> tags) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.0,
          children: [
            Row(
              spacing: 8.0,
              children: [
                Icon(Icons.label_outline),
                Text(
                  '标签',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Wrap(
              spacing: 8.0,
              alignment: WrapAlignment.start,
              children:
                  tags.map((tag) {
                    return Chip(
                      label: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 150),
                        child: Text(
                          tag,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '实验设置',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: const Icon(Icons.clear_all),
            title: const Text('清除当前数据'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history_toggle_off),
            title: const Text('清除历史记录'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.delete_outlined),
            title: const Text('删除该实验'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTrailing(Experiment exp) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        spacing: 8.0,
        children: [
          Text('创建于 ${DateFormat('yyyy-MM-dd HH:mm').format(exp.createAt)}'),
          Text(
            '最后编辑于 ${DateFormat('yyyy-MM-dd HH:mm').format(exp.lastModifiedAt)}',
          ),
        ],
      ),
    );
  }

  void _showAddStepDialog(Experiment exp) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: Get.context!,
      builder:
          (context) => AlertDialog(
            title: const Text('添加实验步骤'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: '步骤名称',
                      border: OutlineInputBorder(),
                    ),
                    validator:
                        (value) => value?.isEmpty ?? true ? '标题不能为空' : null,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: '步骤描述（可选）',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: Get.back, child: const Text('取消')),
              FilledButton(
                onPressed:
                    () => _handleAddStep(
                      formKey,
                      exp,
                      titleController.text.trim(),
                      descriptionController.text.trim(),
                    ),
                child: const Text('添加'),
              ),
            ],
          ),
    );
  }

  void _handleAddStep(
    GlobalKey<FormState> formKey,
    Experiment exp,
    String title,
    String description,
  ) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final ExperimentStep step = ExperimentStep(
      id: const Uuid().v4(),
      title: title,
      order: 0,
      description: description.isNotEmpty ? description : null,
    );
    controller.addStep(exp, step);
    Get.back();
  }
}
