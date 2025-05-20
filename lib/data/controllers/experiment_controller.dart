// experiment_controller.dart
// 实验控制器，负责实验数据的加载、增删改查及多选操作逻辑

import 'package:get/get.dart';
import 'package:xperinote/app/widgets/custom_snack_bar.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/repositories/experiment_repository.dart';

/// 异步状态枚举
/// [loading] 加载中，[success] 成功，[error] 失败
enum AsyncStatus { loading, success, error }

/// [ExperimentController] 负责管理实验数据的状态、加载、增删改查操作，
/// 以及多选、批量删除等交互逻辑。
class ExperimentController extends GetxController {
  /// 实验数据仓库
  final ExperimentRepository _repository;
  /// 当前异步状态（加载中/成功/失败）
  final Rx<AsyncStatus> _status = AsyncStatus.loading.obs;
  /// 实验列表
  final RxList<Experiment> _experiments = <Experiment>[].obs;
  /// 当前选中的实验ID集合
  final RxSet<String> _selectedIds = <String>{}.obs;
  /// 是否处于多选模式
  final RxBool isSelectionMode = false.obs;

  /// 构造函数，注入实验仓库
  ExperimentController(this._repository);

  /// 当前异步状态
  AsyncStatus get status => _status.value;
  /// 所有实验列表
  List<Experiment> get experiments => _experiments.toList();
  /// 进行中的实验列表
  List<Experiment> get ongoingExperiments =>
      _experiments
          .where((experiment) => experiment.status == ExperimentStatus.ongoing)
          .toList();
  /// 已完成的实验列表
  List<Experiment> get completedExperiments =>
      _experiments
          .where(
            (experiment) => experiment.status == ExperimentStatus.completed,
          )
          .toList();
  /// 当前选中的实验ID集合
  Set<String> get selectedIds => _selectedIds;

  @override
  void onInit() {
    super.onInit();
    _loadExperiments();
  }

  /// 加载所有实验数据
  Future<void> _loadExperiments() async {
    _status.value = AsyncStatus.loading;
    try {
      final result = await _repository.getAllExperiments();
      _experiments.assignAll(result);
      _status.value = AsyncStatus.success;
    } catch (e) {
      _status.value = AsyncStatus.error;
      CustomSnackBar.show(Get.context!, '错误！数据加载失败: ${e.toString()}');
    } finally {
      update();
    }
  }

  /// 添加实验并刷新列表
  Future<void> addExperiment(Experiment experiment) async {
    try {
      await _repository.addExperiment(experiment);
      await _loadExperiments();
      CustomSnackBar.show(Get.context!, '实验 ${experiment.title} 添加成功');
    } catch (e) {
      CustomSnackBar.show(Get.context!, '实验添加失败：${e.toString()}');
    } finally {
      update();
    }
  }

  /// 批量删除选中的实验
  Future<void> deleteSelectedExperiments() async {
    try {
      await _repository.deleteExperiments(_selectedIds.toList());
      await _loadExperiments();
      CustomSnackBar.show(Get.context!, '已删除 ${_selectedIds.length} 个实验');
      _selectedIds.clear();
      isSelectionMode.value = false;
    } catch (e) {
      CustomSnackBar.show(Get.context!, '删除失败：${e.toString()}');
    } finally {
      update();
    }
  }

  /// 切换单个实验的选中状态
  void toggleSelection(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
  }

  /// 全选/取消全选
  void toggleSelectAll() {
    if (_selectedIds.length == _experiments.length) {
      _selectedIds.clear();
    } else {
      _selectedIds.addAll(_experiments.map((e) => e.id));
    }
  }

  /// 退出多选模式并清空选中
  void exitSelectionMode() {
    _selectedIds.clear();
    isSelectionMode.value = false;
  }
}
