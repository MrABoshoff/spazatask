import 'dart:ffi';
import 'dart:convert';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

  void calculateWithMod(double? cost, double? tender) {
    if (cost == null || tender == null) return;

    num totalChange = tender - cost;
    Map<String, num> breakdown = {};

    // TODO - Calculate your breakdown here, put the results in a map, with the validDenominations as the key, and the result as the value
    num Count;
    if (cost > tender) {}
    validDenominations.forEach(// Iterating through each of the denominations.
        (element) {
      Count = (totalChange / element)
          .floor(); // Getting the amount of times each of the denominations can be used in the change.
      totalChange = totalChange % element;

      if (Count > 0) {
        breakdown['$element'] =
            Count; // Adding each element with a count larger than 0 into the breakdown to be printed.
      }
    });

    totalChange = tender - cost;

    emit(SimpleCalcCalculated(breakdown, totalChange));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
