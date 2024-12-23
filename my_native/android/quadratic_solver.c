#include <math.h>
#include <stdio.h>


typedef struct {
    double x1;
    double x2;
    int has_real_solution;
}Solution;

Solution solve_quadratic(double a, double b, double c){
    Solution result;
    double delta = b * b - 4 * a * c;

    if (delta < 0) {
        result.has_real_solution = 0;
    } else {
        result.has_real_solution = 1;
        result.x1 = (-b + sqrt(delta)) / (2 * a);
        result.x2 = (-b - sqrt(delta)) / (2 * a);
    }
    return result;
}
