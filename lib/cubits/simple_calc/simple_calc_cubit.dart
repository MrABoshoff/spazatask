import 'dart:ffi';
import 'dart:convert';
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
    if (tender < cost) {
      totalChange = cost - tender;
      
    } else {
      validDenominations
          .forEach((element) // Iterating through each of the denominations
              {
        num Count = (totalChange / element)
            .floor(); //Getting the amount of times each of the denominations can be used in the change
        totalChange = totalChange % element;

        if (Count != 0) {
          breakdown = {validDenominations.toString(): Count};
        }
      });
    }

    emit(SimpleCalcCalculated(breakdown, totalChange));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
