import 'package:get/get.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/repositories/experiment_repository.dart';

class ExperimentController extends GetxController {
  final ExperimentRepository _repository;
  final Rx<AsyncStatus> _status = AsyncStatus.loading.obs;
  final RxList<Experiment> _experiments = <Experiment>[].obs;

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
      Get.snackbar('错误', '数据加载失败: ${e.toString()}');
    } finally {
      update();
    }
  }
}

enum AsyncStatus { loading, success, error }
