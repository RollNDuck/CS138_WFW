#import "../../../template.typ": project

#show: project.with(
  title: "Exercise 6.1 & 6.2 Remixed Problems",
  contributor: "Dean Robin Alcancia",
  date: "September 28, 2026",
)

**= Problem**

A persymmetric matrix is a matrix that is symmetric about both diagonals; that is, an $N times N$ matrix
$A = (a_(i j))$ is persymmetric if $a_(i j) = a_(j i) = a_(N+1-i,N+1-j)$, for all $i = 1,2,...,N$ and $j = 1,2,...,N$.

A number of problems in communication theory have solutions that involve the eigenvalues and eigenvectors of matrices that are in persymmetric form. For example, the eigenvector corresponding to the minimal eigenvalue of the $4 times 4$ persymmetric matrix

$
A =
mat(
  2, -1, 0, 0;
  -1, 2, -1, 0;
  0, -1, 2, -1;
  0, 0, -1, 2
)
$

gives the unit energy-channel impulse response for a given error sequence of length 2, and subsequently the minimum weight of any possible error sequence.

*Part (a).* Use the Gershgorin Circle Theorem to show that if $A$ is the matrix given above and $lambda$ is its minimal eigenvalue, then
$|lambda - 4| = rho(A - 4 I)$,
where $rho$ denotes the spectral radius.

**= Solution**

**== Step 1: Form $A - 4I$**

Subtract $4I$ from $A$:

$
A - 4I =
mat(
  -2, -1, 0, 0;
  -1, -2, -1, 0;
  0, -1, -2, -1;
  0, 0, -1, -2
)
$

Let $mu$ be an eigenvalue of $A - 4I$. Since subtracting $4I$ shifts every eigenvalue by $-4$, the eigenvalues of $A - 4I$ are
$mu_i = lambda_i - 4$,
where $lambda_i$ are the eigenvalues of $A$.

**== Step 2: Apply the Gershgorin Circle Theorem**

For $A - 4I$, the Gershgorin disks are determined by the diagonal entries and the sums of the absolute values of the off-diagonal entries in each row.

For rows 1 and 4:

$
c_1 = c_4 = -2, quad r_1 = r_4 = 1,
$

so the corresponding disks are

$
|mu + 2| <= 1.
$

These disks lie on the real interval $[-3,-1]$.

For rows 2 and 3:

$
c_2 = c_3 = -2, quad r_2 = r_3 = 2,
$

so the corresponding disks are

$
|mu + 2| <= 2.
$

These disks lie on the real interval $[-4,0]$ along the real axis.

By the Gershgorin Circle Theorem, every eigenvalue $mu$ of $A - 4I$ lies in the union of these disks. Since $A - 4I$ is symmetric, all of its eigenvalues are real. Therefore,

$
-4 <= mu_i <= 0
$

for every eigenvalue $mu_i$.

**== Step 3: Relate the spectral radius to the minimal eigenvalue**

Because $mu_i = lambda_i - 4$, and $lambda$ is the minimal eigenvalue of $A$, we have

$
mu_min = lambda - 4.
$

The Gershgorin result shows that all eigenvalues of $A - 4I$ are nonpositive. Hence the eigenvalue with the largest absolute value is the smallest eigenvalue:

$
rho(A - 4I)
= max_i |mu_i|
= |mu_min|
= |lambda - 4|.
$

Since $lambda <= 4$, we can also write

$
|lambda - 4| = 4 - lambda.
$

Therefore,

$
b o x e d(|lambda - 4| = rho(A - 4I)).
$

**== Conclusion**

The Gershgorin Circle Theorem places all eigenvalues of $A - 4I$ in the interval $[-4,0]$ on the real axis. Because $A - 4I$ is symmetric, its eigenvalues are real, and the eigenvalue farthest from the origin is the shifted minimal eigenvalue $lambda - 4$. Thus,

$
b o x e d(|lambda - 4| = rho(A - 4I)).
$

#pagebreak()

**= Problem 2**

Find the first two iterations of the Jacobi method for the following linear systems, using $x^(0) = 0$.

+ **Part (a):**
  $
    cases(
      3 x_1 - x_2 + x_3 = 1,
      3 x_1 + 6 x_2 + 2 x_3 = 0,
      3 x_1 + 3 x_2 + 7 x_3 = 4
    )
  $

+ **Part (b):**
  $
    cases(
      10 x_1 - x_2 = 9,
      -x_1 + 10 x_2 - 2 x_3 = 7,
      -2 x_2 + 10 x_3 = 6
    )
  $

+ **Part (c):**
  $
    cases(
      10 x_1 + 5 x_2 = 6,
      5 x_1 + 10 x_2 - 4 x_3 = 25,
      -4 x_2 + 8 x_3 - x_4 = -11,
      -x_3 + 5 x_4 = -11
    )
  $

+ **Part (d):**
  $
    cases(
      4 x_1 + x_2 + x_3 + x_5 = 6,
      -x_1 - 3 x_2 + x_3 + x_4 = 6,
      2 x_1 + x_2 + 5 x_3 - x_4 - x_5 = 6,
      -x_1 - x_2 - x_3 + 4 x_4 = 6,
      2 x_2 - x_3 + x_4 + 4 x_5 = 6
    )
  $

**= Solution: Part (a)**

**== Rewrite the system for Jacobi iteration**

Solve each equation for its corresponding variable:

$
  x_1 = frac(1 + x_2 - x_3, 3),
  quad
  x_2 = frac(-3x_1 - 2x_3, 6),
  quad
  x_3 = frac(4 - 3x_1 - 3x_2, 7).
$


Since $x^(0) = (0,0,0)^T$, the first iteration is

$
  x_1^((1)) = frac(1 + 0 - 0,3) = frac(1,3),
  \\
  x_2^((1)) = frac(-3(0)-2(0),6) = 0,
  \\
  x_3^((1)) = frac(4-3(0)-3(0),7) = frac(4,7).
$

Thus,

$
  b o x e d(x^((1)) = mat(delim: "[", 1/3; 0; 4/7)).
$

For the second iteration, use only the values from $x^((1))$:

$
  x_1^((2)) = frac(1 + 0 - 4/7,3) = frac(1,7),
  \\
  x_2^((2)) = frac(-3(1/3)-2(4/7),6) = -frac(23,42),
  \\
  x_3^((2)) = frac(4-3(1/3)-3(0),7) = frac(3,7).
$

Therefore,

$
  b o x e d(x^((2)) = mat(delim: "[", 1/7; -5/14; 3/7)).
$

**= Solution: Part (b)**

**== Rewrite the system for Jacobi iteration**

$
  x_1 = frac(9+x_2,10),
  quad
  x_2 = frac(7+x_1+2x_3,10),
  quad
  x_3 = frac(6+2x_2,10).
$

Starting from $x^((0))=(0,0,0)^T$:

$
  x_1^((1)) = frac(9,10),
  \\
  x_2^((1)) = frac(7,10),
  \\
  x_3^((1)) = frac(6,10) = frac(3,5).
$

Hence,

$
  b o x e d(x^((1)) = mat(delim: "[", 9/10; 7/10; 3/5)).
$

For the second iteration:

$
  x_1^((2)) = frac(9+7/10,10) = frac(97,100),
  \\
  x_2^((2)) = frac(7+9/10+2(3/5),10) = frac(91,100),
  \\
  x_3^((2)) = frac(6+2(7/10),10) = frac(37,50).
$

Thus,

$
  b o x e d(x^((2)) = mat(delim: "[", 97/100; 91/100; 37/50)).
$

**= Solution: Part (c)**

**== Rewrite the system for Jacobi iteration**

$
  x_1 = frac(6-5x_2,10),
  quad
  x_2 = frac(25-5x_1+4x_3,10),
  quad
  x_3 = frac(-11+4x_2+x_4,8),
  quad
  x_4 = frac(-11+x_3,5).
$

Starting from $x^((0))=(0,0,0,0)^T$:

$
  x_1^((1)) = frac(6,10) = frac(3,5),
  \\
  x_2^((1)) = frac(25,10) = frac(5,2),
  \\
  x_3^((1)) = frac(-11,8),
  \\
  x_4^((1)) = frac(-11,5).
$

Therefore,

$
  b o x e d(x^((1)) = mat(delim: "[", 3/5; 5/2; -11/8; -11/5)).
$

For the second iteration, substitute the first-iteration values:

$
  x_1^((2)) = frac(6-5(5/2),10) = -frac(13,20),
  \\
  x_2^((2)) = frac(25-5(3/5)+4(-11/8),10) = frac(33,20),
  \\
  x_3^((2)) = frac(-11+4(5/2)-11/5,8) = -frac(2,5),
  \\
  x_4^((2)) = frac(-11-11/8,5) = -frac(99,40).
$

Hence,

$
  b o x e d(x^((2)) = mat(delim: "[", -13/20; 33/20; -2/5; -99/40)).
$

**= Solution: Part (d)**

**== Rewrite the system for Jacobi iteration**

Solve each equation for its corresponding variable:

$
  x_1 = frac(6-x_2-x_3-x_5,4),
  quad
  x_2 = frac(-6-x_1+x_3+x_4,3),
  \\
  x_3 = frac(6-2x_1-x_2+x_4+x_5,5),
  \\
  x_4 = frac(6+x_1+x_2+x_3,4),
  quad
  x_5 = frac(6-2x_2+x_3-x_4,4).
$

Starting from $x^((0))=(0,0,0,0,0)^T$:

$
  x_1^((1)) = frac(6,4) = frac(3,2),
  \\
  x_2^((1)) = frac(-6,3) = -2,
  \\
  x_3^((1)) = frac(6,5),
  \\
  x_4^((1)) = frac(6,4) = frac(3,2),
  \\
  x_5^((1)) = frac(6,4) = frac(3,2).
$

Thus,

$
  b o x e d(x^((1)) = mat(delim: "[", 3/2; -2; 6/5; 3/2; 3/2)).
$

For the second iteration, substitute $x^((1))$ into every right-hand side:

$
  x_1^((2)) = frac(6-(-2)-6/5-3/2,4) = frac(53,40),
  \\
  x_2^((2)) = frac(-6-3/2+6/5+3/2,3) = -frac(8,5),
  \\
  x_3^((2)) = frac(6-2(3/2)-(-2)+3/2+3/2,5) = frac(8,5),
  \\
  x_4^((2)) = frac(6+3/2-2+6/5,4) = frac(67,40),
  \\
  x_5^((2)) = frac(6-2(-2)+6/5-3/2,4) = frac(97,40).
$

Therefore,

$
  b o x e d(x^((2)) = mat(delim: "[", 53/40; -8/5; 8/5; 67/40; 97/40)).
$

**= Summary of the First Two Jacobi Iterations**

The results are:

#table(
  columns: 3,
  align: center + horizon,
  [Part], [First iteration $x^((1))$], [Second iteration $x^((2))$],
  [a], [$(1/3, 0, 4/7)^T$], [$(1/7, -5/14, 3/7)^T$],
  [b], [$(9/10, 7/10, 3/5)^T$], [$(97/100, 91/100, 37/50)^T$],
  [c], [$(3/5, 5/2, -11/8, -11/5)^T$], [$(-13/20, 33/20, -2/5, -99/40)^T$],
  [d], [$(3/2, -2, 6/5, 3/2, 3/2)^T$], [$(53/40, -8/5, 8/5, 67/40, 97/40)^T$]
)


**= AI Contribution Statement**

During the preparation of this work, the author(s) utilized ChatGPT solely to aid in typesetting, formatting of mathematical expressions in Typst, syntax verification, and proofreading.
