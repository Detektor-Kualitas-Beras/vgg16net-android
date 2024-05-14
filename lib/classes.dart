enum DetectionClasses {
  ir64Medium,
  ir64NotFeasible,
  ir64Premium,
  pandanWangiMedium,
  pandanWangiNotFeasible,
  pandanWangiPremium,
  rojoLeleMedium,
  rojoLeleNotFeasible,
  rojoLelePremium,
  nothing
}

extension DetectionClassesExtension on DetectionClasses {
  String get label {
    switch (this) {
      case DetectionClasses.ir64Medium:
        return "IR64 Medium";
      case DetectionClasses.ir64NotFeasible:
        return "IR64 Not Feasible";
      case DetectionClasses.ir64Premium:
        return "IR64 Premium";
      case DetectionClasses.pandanWangiMedium:
        return "Pandan Wangi Medium";
      case DetectionClasses.pandanWangiNotFeasible:
        return "Pandan Wangi Not Feasible";
      case DetectionClasses.pandanWangiPremium:
        return "Pandan Wangi Premium";
      case DetectionClasses.rojoLeleMedium:
        return "Rojo Lele Medium";
      case DetectionClasses.rojoLeleNotFeasible:
        return "Rojo Lele Not Feasible";
      case DetectionClasses.rojoLelePremium:
        return "Rojo Lele Premium";
      case DetectionClasses.nothing:
        return "Nothing";
    }
  }
}
