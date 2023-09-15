import 'package:get/get.dart';

mixin StepperControllerMixin {
  abstract final int length;

  abstract final int initialStep;

  String get title;

  String get continueText;

  late RxInt currentStep = initialStep.obs;
  RxBool isFirstStep = true.obs;
  RxBool isLastStep = false.obs;

  void onStepContinue() {
    if (currentStep.value < length - 1) {
      currentStep.value++;
      isFirstStep.value = currentStep.value == 0;
      isLastStep.value = currentStep.value == length - 1;
    }
  }

  void onStepPrevious() {
    if (currentStep.value > 0) {
      currentStep.value--;
      isFirstStep.value = currentStep.value == 0;
      isLastStep.value = currentStep.value == length - 1;
    } else {
      Get.back();
    }
  }

  void goToStep(int index) {
    currentStep.value = index;
    isFirstStep.value = currentStep.value == 0;
    isLastStep.value = currentStep.value == length - 1;
  }
}
