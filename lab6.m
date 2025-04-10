// Name: Haoyu Pan
// Student Number: 630517
// CMPT 360 Lab #7
  
  
#include <stdio.h>
#include <math.h>

typedef struct {
    double x;
    double y;
    double z;
} Solution;

typedef enum {
    SolutionTypeUnique,
    SolutionTypeInfinite,
    SolutionTypeNone
} SolutionType;

void printHeader() {
    printf("----------------------------------------\n");
    printf("Lab #7 by Haoyu Pan - Student ID: 630517\n");
    printf("Three-Dimensional Linear Equation Solver\n");
    printf("----------------------------------------\n\n");
}

void solveSystem(double a1, double b1, double c1, double d1,
                 double a2, double b2, double c2, double d2,
                 double a3, double b3, double c3, double d3,
                 SolutionType *type, Solution *solution) {
    
    // Calculate the determinant of the coefficient matrix
    double det = a1*(b2*c3 - b3*c2) - b1*(a2*c3 - a3*c2) + c1*(a2*b3 - a3*b2);
    
    // Check for special cases
    if (fabs(det) > 1e-10) { // Unique solution
        // Calculate determinants for x, y, z using Cramer's Rule
        double detX = d1*(b2*c3 - b3*c2) - b1*(d2*c3 - d3*c2) + c1*(d2*b3 - d3*b2);
        double detY = a1*(d2*c3 - d3*c2) - d1*(a2*c3 - a3*c2) + c1*(a2*d3 - a3*d2);
        double detZ = a1*(b2*d3 - b3*d2) - b1*(a2*d3 - a3*d2) + d1*(a2*b3 - a3*b2);
        
        solution->x = detX / det;
        solution->y = detY / det;
        solution->z = detZ / det;
        *type = SolutionTypeUnique;
    } else {
        // Check if all three planes are parallel
        double ratio1 = a1/a2, ratio2 = b1/b2, ratio3 = c1/c2, ratio4 = d1/d2;
        double ratio5 = a1/a3, ratio6 = b1/b3, ratio7 = c1/c3, ratio8 = d1/d3;
        
        int allParallel12 = (fabs(ratio1 - ratio2) < 1e-10) && 
                           (fabs(ratio1 - ratio3) < 1e-10) && 
                           (fabs(ratio1 - ratio4) < 1e-10);
        
        int allParallel13 = (fabs(ratio5 - ratio6) < 1e-10) && 
                           (fabs(ratio5 - ratio7) < 1e-10) && 
                           (fabs(ratio5 - ratio8) < 1e-10);
        
        if (allParallel12 && allParallel13) {
            // All three equations are multiples of each other - infinite solutions
            *type = SolutionTypeInfinite;
        } else {
            // Check if any two equations are inconsistent
            int inconsistent12 = (fabs(ratio1 - ratio2) < 1e-10) && 
                                (fabs(ratio1 - ratio3) < 1e-10) && 
                                (fabs(ratio1 - ratio4) > 1e-10);
            
            int inconsistent13 = (fabs(ratio5 - ratio6) < 1e-10) && 
                                (fabs(ratio5 - ratio7) < 1e-10) && 
                                (fabs(ratio5 - ratio8) > 1e-10);
            
            int inconsistent23 = 0;
            double ratio9 = a2/a3, ratio10 = b2/b3, ratio11 = c2/c3, ratio12 = d2/d3;
            if ((fabs(ratio9 - ratio10) < 1e-10) && 
                 (fabs(ratio9 - ratio11) < 1e-10) && 
                 (fabs(ratio9 - ratio12) > 1e-10)) {
                inconsistent23 = 1;
            }
            
            if (inconsistent12 || inconsistent13 || inconsistent23) {
                // At least one pair is inconsistent - no solution
                *type = SolutionTypeNone;
            } else {
                // The system has infinitely many solutions (planes intersect in a line)
                *type = SolutionTypeInfinite;
            }
        }
    }
}

void printSolution(SolutionType type, Solution solution) {
    switch(type) {
        case SolutionTypeUnique:
            printf("Unique solution: x = %f, y = %f, z = %f\n", 
                   solution.x, solution.y, solution.z);
            break;
        case SolutionTypeInfinite:
            printf("Infinitely many solutions\n");
            break;
        case SolutionTypeNone:
            printf("No solution exists\n");
            break;
    }
}

int main() {

    printHeader();
    
    Solution solution;
    SolutionType type;
    
    // Test 1: Unique solution
    printf("Test 1: Unique solution (x=1, y=1, z=1)\n");
    solveSystem(1, 1, 1, 3,
               1, -1, 1, 1,
               2, 1, -1, 2,
               &type, &solution);
    printSolution(type, solution);
    
    // Test 2: No solution (inconsistent)
    printf("\nTest 2: No solution (inconsistent)\n");
    solveSystem(1, 1, 1, 3,
               1, 1, 1, 4,
               1, 1, 1, 5,
               &type, &solution);
    printSolution(type, solution);
    
    // Test 3: Infinite solutions (all equations equivalent)
    printf("\nTest 3: Infinite solutions (all equations equivalent)\n");
    solveSystem(1, 2, 3, 6,
               2, 4, 6, 12,
               3, 6, 9, 18,
               &type, &solution);
    printSolution(type, solution);
    
    // Test 4: Infinite solutions (planes intersect in a line)
    printf("\nTest 4: Infinite solutions (planes intersect in a line)\n");
    solveSystem(1, 1, 1, 3,
               1, 1, -1, 1,
               1, 1, 0, 2,
               &type, &solution);
    printSolution(type, solution);
    
    return 0;
}