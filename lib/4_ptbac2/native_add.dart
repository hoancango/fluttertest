import 'dart:ffi';
import 'dart:io';

DynamicLibrary _lib = Platform.isAndroid
    ? DynamicLibrary.open('libmy_native.so')
    : DynamicLibrary.process();

base class Solution extends Struct {
  @Double()
  external double x1;

  @Double()
  external double x2;

  @Int32()
  external int hasRealSolution;
}

typedef SolveQuadraticNative = Solution Function(Double a, Double b, Double c);
typedef SolveQuadraticDart = Solution Function(double a, double b, double c);

final SolveQuadraticDart solveQuadratic = _lib
    .lookup<NativeFunction<SolveQuadraticNative>>('solve_quadratic')
    .asFunction();
