import 'dart:math';

class Transformer {
  String name = '';
  int power = 0;
  int dyn = 0;
  int primaryVoltage = 0;
  int secundaryVoltage = 0;
  double primaryCurrent = 0;
  double secundaryCurrent = 0;
  bool ratioOk = false;
  bool appliedLowVoltage = false;
  bool appliedHighVoltage = false;
  bool inducedVoltage = false;
  double temperature = 0.0;
  double testProgress = 0.0;
  List<double> resistanceLV = [];
  List<double> resistanceHV = [];
  List<double> loadLosses = [];
  List<double> noLoadLosses = [];
  int summaryReady = 0;

  Transformer() {
    name = 'T63N21 10-0,4';
    power = 630;
    dyn = 5;
    primaryVoltage = 10750;
    secundaryVoltage = 420;
    primaryCurrent = 33.84;
    secundaryCurrent = 866.0;
  }

  setName(String name) {
    this.name = name;
  }

  setPower(int power) {
    this.power = power;
  }

  setDyn(int dyn) {
    this.dyn = dyn;
  }

  setPrimaryVoltage(int primaryVoltage) {
    this.primaryVoltage = primaryVoltage;
  }

  setSecundaryVoltage(int secundaryVoltage) {
    this.secundaryVoltage = secundaryVoltage;
  }

  setPrimaryCurrent(double primaryCurrent) {
    this.primaryCurrent = primaryCurrent;
  }

  setSecundaryCurrent(double secundaryCurrent) {
    this.secundaryCurrent = secundaryCurrent;
  }

  setTemperature(double temperature) {
    this.temperature = temperature;
    summaryReady ++;
  }

  setRatioOK() {
    ratioOk = true;
  }

  setAppliedLowVoltage() {
    appliedLowVoltage = true;
  }

  setAppliedHighVoltage() {
    appliedHighVoltage = true;
  }

  setInducedVoltage() {
    inducedVoltage = true;
  }

  addResistance(List<double> resistanceLV, List<double> resistanceHV) {
    this.resistanceLV = resistanceLV;
    this.resistanceHV = resistanceHV;
  }

  addLoadLosses(double wattLoss, double voltLoss, List<double> currents) {
    loadLosses = [];
    loadLosses.add(wattLoss);
    loadLosses.add(voltLoss);
    loadLosses.addAll(currents);
  }

  addNoLoadLosses(double wattLoss, List<double> currents) {
    noLoadLosses = [];
    noLoadLosses.add(wattLoss);
    noLoadLosses.addAll(currents);
  }

  increaseProgress() {
    testProgress += 0.1667;
    if(testProgress > 100.0) {
      testProgress = 100.0;
    }
    summaryReady ++;
  }

  double calcAvgLVResistance() {
    double average = 0.0;
    for(int i = 0; i < resistanceLV.length; i++) {
      average += resistanceLV[i];
    }
    return average/resistanceLV.length;
  }

  double calcAvgHVResistance() {
    double average = 0.0;
    for(int i = 0; i < resistanceHV.length; i++) {
      average += resistanceHV[i];
    }
    return average/resistanceHV.length;
  }

  double calcAvgNoLoadCurrent() {
    double avg = 0.0;
    for(int i = 1; i < noLoadLosses.length; i ++) {
      avg += noLoadLosses.elementAt(i);
    }
    avg = double.parse((avg / (noLoadLosses.length - 1)).toStringAsFixed(2));
    return avg;
  }

  double calcAvgLoadCurrent() {
    double avg = 0.0;
    for(int i = 2; i < loadLosses.length; i ++) {
      avg += loadLosses.elementAt(i);
    }
    avg = double.parse((avg / (loadLosses.length - 2)).toStringAsFixed(2));
    return avg;
  }

  double calcLoadLossHigh () {
    return primaryCurrent * primaryCurrent * 1.5 * calcAvgHVResistance();
  }

  double calcLoadLossLow () {
    return secundaryCurrent * secundaryCurrent * 1.5 * calcAvgLVResistance()/1000;
  }

  double calcLoadLoss () {
    return calcLoadLossHigh() + calcLoadLossLow();
  }

  double calcLoadLoss75Degrees () {
    double load = calcLoadLoss () * (225 + 75)/(225 + temperature);
    return calcLoadLoss () * (225 + 75)/(225 + temperature);
  }

  double loadLossWithINom () {
    return (primaryCurrent / calcAvgLoadCurrent()) * (primaryCurrent / calcAvgLoadCurrent()) * loadLosses.first;
  }

  double extraLoadLosses () {
    return ((loadLossWithINom() *(225 + temperature))/(225 + temperature)) - calcLoadLoss();
  }

  double extraLoadLossesAt75Degrees () {
    return extraLoadLosses()* (225 + temperature)/(225 + 75);
  }

  double loadLossAt75Degrees () {
    return double.parse((extraLoadLossesAt75Degrees() + calcLoadLoss75Degrees()).toStringAsFixed(2));
  }

  double percentImpedanceVAt75Degrees () {
    double voltage = loadLosses.elementAt(1);
    double imp = 1000 * sqrt(pow((voltage/(primaryVoltage*1000)), 2) - pow((loadLossWithINom()/(power*1000)), 2) + pow((loadLossAt75Degrees()/(power*1000)), 2));
    print(imp);
    return double.parse(imp.toStringAsFixed(2));
  }

  bool isSummaryReady() {
    bool state = false;
    if(summaryReady == 7) {
      state = true;
    }
    return state;
  }

}