# CMPT-360-Lab-6
## 3D Linear Equation Solver

**Name:** Haoyu Pan  
**Student ID:** 630517  
**Course:** CMPT 360

## Description

This C program solves a system of three linear equations with three unknowns (x, y, z). It determines if the system has:
- A unique solution  
- Infinite solutions  
- No solution  

It uses **Cramer's Rule** and checks for special cases based on matrix determinants.

## How to Compile

```bash
gcc -o lab7 lab7.c -lm
```

## How to Run

```bash
./lab7
```

The program will run four test cases automatically.

## Test Cases

1. Unique solution (x = 1, y = 1, z = 1)  
2. No solution (inconsistent equations)  
3. Infinite solutions (equivalent equations)  
4. Infinite solutions (planes intersect in a line)
