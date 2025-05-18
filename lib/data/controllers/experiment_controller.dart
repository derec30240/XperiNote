import 'package:get/get.dart';
import 'package:xperinote/app/widgets/custom_snack_bar.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/repositories/experiment_repository.dart';

class ExperimentController extends GetxController {
  final ExperimentRepository _repository;
  final Rx<AsyncStatus> _status = AsyncStatus.loading.obs;
  final RxList<Experiment> _experiments = <Experiment>[].obs;
  final RxSet<String> _selectedIds = <String>{}.obs;

  final RxBool isSelectionMode = false.obs;

  ExperimentController(this._repository);

  AsyncStatus get status => _status.value;
  List<Experiment> get experiments => _experiments.toList();
  List<Experiment> get ongoingExperiments =>
      _experiments
          .where((experiment) => experiment.status == ExperimentStatus.ongoing)
          .toList();
  List<Experiment> get completedExperiments =>
      _experiments
          .where(
            (experiment) => experiment.status == ExperimentStatus.completed,
          )
          .toList();
  Set<String> get selectedIds => _selectedIds;

  @override
  void onInit() {
    super.onInit();
    _loadExperiments();
  }

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

  void toggleSelection(String id) {
    if (_selectedIds.contains(id)) {
      _selectedIds.remove(id);
    } else {
      _selectedIds.add(id);
    }
  }

  void toggleSelectAll() {
    if (_selectedIds.length == _experiments.length) {
      _selectedIds.clear();
    } else {
      _selectedIds.addAll(_experiments.map((e) => e.id));
    }
  }

  void exitSelectionMode() {
    _selectedIds.clear();
    isSelectionMode.value = false;
  }
}

enum AsyncStatus { loading, success, error }
