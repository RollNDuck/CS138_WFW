#import "../../../template.typ": indiv

#show: indiv.with(
  title: "2.5 Nonlinear Finite Difference and Newton's Method: Solved Problems",
  contributor: "Ryan Luis Dela Cruz",
  date: "November 9, 2026",
)

#set math.vec(delim: "[")
#show bibliography: set heading(numbering: none)

// ----------------------------------------------------------------------------
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150), width: 100%)[
  *Problem 1: Nonlinear Finite Difference with One Interior Point*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 11.4, Problem 1 @burden2010numerical.

  *Problem Statement:* \
  Use the Nonlinear Finite-Difference method with $h = 0.5$ to approximate the solution to the boundary-value problem
  $ y'' = -(y')^2 - y + ln x, quad 1 <= x <= 2, quad y(1) = 0, quad y(2) = ln 2. $
  Compare your results to the actual solution $y = ln x$.
]

= Solution to Problem 1

*Setup: Discretizing the BVP* \
With $h = 0.5$, the only interior point is $x_1 = 1.5$. So we have one unknown $y_1 approx y(1.5)$, with $y_0 = 0$ and $y_2 = ln 2$.

Replace $y''$ and $y'$ with central differences, using $1/h^2 = 4$ and $1/(2h) = 1$:
$ F(y_1) = 4 (y_2 - 2 y_1 + y_0) + ((y_2 - y_0)/(2h))^2 + y_1 - ln x_1 = 0 $

The central difference for $y'(1.5)$ only uses the boundary values:
$ (y_2 - y_0)/(2h) = (ln 2 - 0)/1 = ln 2 $

So the $(y')^2$ term becomes the constant $(ln 2)^2$, and $F$ is linear in $y_1$:
$ F(y_1) = 4 ln 2 + (ln 2)^2 - ln 1.5 - 7 y_1, quad F'(y_1) = -7 $

*Iteration 1 ($k = 1$):* \
Start with the line through the boundary values: $y_1^((0)) = (0 + ln 2)/2 approx 0.34657359$.
- Evaluate the residual:
  $ F(y_1^((0))) = 0.5 ln 2 + (ln 2)^2 - ln 1.5 = 0.34657359 + 0.48045301 - 0.40546511 = 0.42156150 $
- Newton update:
  $ y_1^((1)) = y_1^((0)) - F(y_1^((0))) / F'(y_1^((0))) = 0.34657359 + 0.42156150 / 7 = 0.40679666 $
- Since $F$ is linear, $F(y_1^((1))) = 0$. The next correction is $0$, so the method stops.

This matches solving $F = 0$ directly:
$ y_1 = (4 ln 2 + (ln 2)^2 - ln 1.5) / 7 approx 0.40679666 $

*Comparison with Exact Solution:*
#table(
  columns: (1fr, 1.2fr, 1.2fr, 1.2fr),
  align: center,
  stroke: 0.5pt + luma(150),
  table.header([*$x_i$*], [*$w_i$*], [*$y(x_i) = ln x_i$*], [*$abs(w_i - y(x_i))$*]),
  [1.5], [0.40679666], [0.40546511], [$1.33 times 10^(-3)$],
)

*Note:* With one interior point, the central difference for $y'$ never involves the unknown, so any nonlinearity in $y'$ becomes a constant. The problem is nonlinear, but Newton's method converges in one step. Problem 3 shows what happens with two interior points: the $y'$ term then involves the unknowns, and the equation becomes a true nonlinear system.

// ----------------------------------------------------------------------------
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150), width: 100%)[
  *Problem 2: Newton's Method on a $2 times 2$ Nonlinear System*
  #line(length: 100%)
  *Reference:* _Numerical Analysis_ (9th ed.), Richard L. Burden and J. Douglas Faires, Exercise Set 10.2, Problem 1(a) @burden2010numerical.

  *Problem Statement:* \
  Use Newton's method with $bold(x)^((0)) = bold(0)$ to compute $bold(x)^((2))$ for the nonlinear system
  $ 4 x_1^2 - 20 x_1 + 1/4 x_2^2 + 8 &= 0, \
    1/2 x_1 x_2^2 + 2 x_1 - 5 x_2 + 8 &= 0. $
]

= Solution to Problem 2

*Setup: Residual and Jacobian* \
Write the system as $bold(F)(bold(x)) = bold(0)$:
$ bold(F)(bold(x)) = vec(4 x_1^2 - 20 x_1 + 1/4 x_2^2 + 8, 1/2 x_1 x_2^2 + 2 x_1 - 5 x_2 + 8) $

Each row of the Jacobian differentiates one equation, and each column one variable:
$ J_F (bold(x)) = mat(8 x_1 - 20, 1/2 x_2; 1/2 x_2^2 + 2, x_1 x_2 - 5) $

Each iteration solves $J_F Delta bold(x) = -bold(F)$ with Cramer's rule: for $J = mat(a, b; c, d)$ and $-bold(F) = vec(r_1, r_2)$,
$ Delta x_1 = (r_1 d - b r_2) / (a d - b c), quad Delta x_2 = (a r_2 - c r_1) / (a d - b c) $

*Iteration 1 ($k = 1$):*
- Evaluate at $bold(x)^((0)) = (0, 0)^T$:
  $ bold(F)(bold(x)^((0))) = vec(8, 8), quad J_F (bold(x)^((0))) = mat(-20, 0; 2, -5) $
- Solve $J_F Delta bold(x) = -bold(F)$. The Jacobian is lower triangular here, so forward substitution is enough:
  $ -20 Delta x_1 = -8 => Delta x_1 = 0.4, quad 2 (0.4) - 5 Delta x_2 = -8 => Delta x_2 = 1.76 $
- Update:
  $ bold(x)^((1)) = bold(x)^((0)) + Delta bold(x) = vec(0.4, 1.76) $

*Iteration 2 ($k = 2$):*
- Evaluate at $bold(x)^((1)) = (0.4, 1.76)^T$:
  $ bold(F)(bold(x)^((1))) = vec(1.4144, 0.61952), quad J_F (bold(x)^((1))) = mat(-16.8, 0.88; 3.5488, -4.296) $
- Cramer's rule with $det J = (-16.8)(-4.296) - (0.88)(3.5488) = 69.049856$:
  $ Delta x_1 &= ((-1.4144)(-4.296) - (0.88)(-0.61952)) / 69.049856 = 6.6214400 / 69.049856 = 0.09589361 \
    Delta x_2 &= ((-16.8)(-0.61952) - (3.5488)(-1.4144)) / 69.049856 = 15.4273587 / 69.049856 = 0.22342347 $
- Update:
  $ bold(x)^((2)) = bold(x)^((1)) + Delta bold(x) = vec(0.49589361, 1.98342347) $

*Summary of Iterations:*
#table(
  columns: (0.5fr, 1.2fr, 1.2fr, 1.4fr, 1.4fr),
  align: center,
  stroke: 0.5pt + luma(150),
  table.header([*$k$*], [*$x_1^((k))$*], [*$x_2^((k))$*], [*$norm(bold(F)(bold(x)^((k))))_infinity$*], [*$norm(bold(x)^((k)) - bold(x)^*)_infinity$*]),
  [0], [0.00000000], [0.00000000], [$8.00$], [$2.00$],
  [1], [0.40000000], [1.76000000], [$1.41$], [$2.40 times 10^(-1)$],
  [2], [0.49589361], [1.98342347], [$5.01 times 10^(-2)$], [$1.66 times 10^(-2)$],
  [3], [0.49998761], [1.99993705], [$2.02 times 10^(-4)$], [$6.30 times 10^(-5)$],
  [4], [0.50000000], [2.00000000], [$2.55 times 10^(-9)$], [$7.87 times 10^(-10)$],
)

*Note:* The iterates converge to $bold(x)^* = (0.5, 2)^T$, which satisfies both equations exactly: $4(0.25) - 10 + 1 + 8 = 0$ and $1/2 (0.5)(4) + 1 - 10 + 8 = 0$. The exercise only asks for $bold(x)^((2))$, but the extra rows show quadratic convergence: the error goes $10^(-2) -> 10^(-5) -> 10^(-10)$.

// ----------------------------------------------------------------------------
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150), width: 100%)[
  *Problem 3: Original Remix — From One Unknown to a $2 times 2$ Newton System*
  #line(length: 100%)
  *Reference:* Original remix connecting Problems 1 and 2, from _Numerical Analysis_ (9th ed.), Exercise Set 11.4, Problem 1 and Exercise Set 10.2, Problem 1(a) @burden2010numerical.

  *Problem Statement:* \
  In Problem 1, one interior point made the nonlinear FD equation linear. Take the same BVP,
  $ y'' = -(y')^2 - y + ln x, quad 1 <= x <= 2, quad y(1) = 0, quad y(2) = ln 2, $
  but use $h = 1/3$.
  1. Set up the nonlinear FD system and show that, unlike Problem 1, it is a true $2 times 2$ nonlinear system.
  2. Solve it with Newton's method as in Problem 2, starting from the line through the boundary values, with $"TOL" = 10^(-4)$.
  3. Compare the errors with Problem 1.
]

= Solution to Problem 3

*Part 1: Setting Up the System* \
With $h = 1/3$, the interior points are $x_1 = 4/3$ and $x_2 = 5/3$, with $y_0 = 0$, $y_3 = ln 2$, $1/h^2 = 9$, and $1/(2h) = 3/2$:
$ F_1 (y_1, y_2) &= 9 (y_2 - 2 y_1) + (3/2 y_2)^2 + y_1 - ln(4/3) = 0 \
  F_2 (y_1, y_2) &= 9 (ln 2 - 2 y_2 + y_1) + (3/2 (ln 2 - y_1))^2 + y_2 - ln(5/3) = 0 $

Now the central difference for $y'$ at each point involves an unknown ($y_2$ in $F_1$, $y_1$ in $F_2$), so the squared terms do not disappear. Unlike Problem 1, this is a true nonlinear system, of the same type as Problem 2.

The Jacobian:
$ J_F (bold(y)) = mat(-17, 9 + 4.5 y_2; 9 - 4.5 (ln 2 - y_1), -17) $

*Part 2: Newton's Method* \
Start with the line through the boundary values:
$ bold(y)^((0)) = vec(ln 2 \/ 3, 2 ln 2 \/ 3) approx vec(0.23104906, 0.46209812) $

*Iteration 1 ($k = 1$):*
- Evaluate the residual. On the line, every second difference is $0$ and both $y'$ approximations equal $ln 2$, so $F_i = (ln 2)^2 + y_i - ln x_i$:
  $ bold(F)(bold(y)^((0))) = vec(0.48045301 + 0.23104906 - 0.28768207, 0.48045301 + 0.46209812 - 0.51082562) = vec(0.42382000, 0.43172551) $
- Evaluate the Jacobian:
  $ J_F (bold(y)^((0))) = mat(-17, 11.07944154; 6.92055846, -17) $
- Cramer's rule with $det J = (-17)^2 - (11.07944154)(6.92055846) = 212.32407712$:
  $ Delta y_1 &= ((-0.42382000)(-17) - (11.07944154)(-0.43172551)) / 212.32407712 = 0.05646188 \
    Delta y_2 &= ((-17)(-0.43172551) - (6.92055846)(-0.42382000)) / 212.32407712 = 0.04838078 $
- Update:
  $ bold(y)^((1)) = vec(0.28751094, 0.51047890) $

*Iterations 2–3 ($k = 2, 3$):*
- Repeating gives a correction of $8.20 times 10^(-4)$, then $1.91 times 10^(-7) < "TOL"$, so the method stops.

*Summary of Iterations:*
#table(
  columns: (0.5fr, 1.3fr, 1.3fr, 1.3fr),
  align: center,
  stroke: 0.5pt + luma(150),
  table.header([*$k$*], [*$y_1^((k))$*], [*$y_2^((k))$*], [*$norm(Delta bold(y))_infinity$*]),
  [0], [0.23104906], [0.46209812], [$5.65 times 10^(-2)$],
  [1], [0.28751094], [0.51047890], [$8.20 times 10^(-4)$],
  [2], [0.28833118], [0.51124700], [$1.91 times 10^(-7)$],
  [3], [0.28833137], [0.51124717], [—],
)

*Part 3: Comparison with Problem 1*
#table(
  columns: (0.8fr, 1fr, 1.2fr, 1.2fr, 1.2fr),
  align: center,
  stroke: 0.5pt + luma(150),
  table.header([*$h$*], [*$x_i$*], [*$w_i$*], [*$ln x_i$*], [*$abs(w_i - ln x_i)$*]),
  [$1/2$], [1.5], [0.40679666], [0.40546511], [$1.33 times 10^(-3)$],
  [$1/3$], [4/3], [0.28833137], [0.28768207], [$6.49 times 10^(-4)$],
  [$1/3$], [5/3], [0.51124717], [0.51082562], [$4.22 times 10^(-4)$],
)

The smaller $h$ gives smaller errors, as expected from the $cal(O)(h^2)$ central differences, but it costs a $2 times 2$ Newton system instead of one linear equation.

*Conclusion:* \
Problem 1's linearity was a side effect of having only one interior point. Adding a second point turns nonlinear FD into exactly the kind of system solved in Problem 2: the same Jacobian, Cramer's rule, and quadratic convergence. Nonlinear FD is Newton's method for systems, applied to the grid values.

#bibliography("../../../resources/bibs/compendium/le2/2.5_book_exercise_nonlinear_fda.bib", style: "apa")
