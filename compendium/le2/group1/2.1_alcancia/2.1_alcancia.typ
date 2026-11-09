#import "../../../../template.typ": project

#show: project.with(
  title: "2.1 Eigenvalue BVPs and Cauchy–Euler Equations: Solved Problems",
  contributor: "Alcancia",
  date: "November 9, 2026",
)

#set math.mat(delim: "[")
#set math.vec(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

== (Alcancia)
// Book Problem 1
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Solving a Cauchy–Euler Equation*
  #line(length: 100%)
  *Reference:* _Differential Equations and Boundary Value Problems: Computing and Modeling_ (5th ed.), C. Henry Edwards, David E. Penney, and David Calvis
  @edwards2015differential[Sec. 3.3, Problem 53, p. 172]

  *Problem Statement:* \
  Make the substitution $v = ln x$ to find a general solution (for $x > 0$) of the Euler equation
  $ x^2 y'' + 7 x y' + 25 y = 0. $
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Substitution $v = ln x$*
  $ (dif y) / (dif v) = x y', quad (dif^2 y) / (dif v^2) = x y' + x^2 y''
    quad ==> quad x y' = (dif y) / (dif v), quad x^2 y'' = (dif^2 y) / (dif v^2) - (dif y) / (dif v). $

  *Transform the equation*
  $ ((dif^2 y) / (dif v^2) - (dif y) / (dif v)) + 7 (dif y) / (dif v) + 25 y = 0
    quad ==> quad (dif^2 y) / (dif v^2) + 6 (dif y) / (dif v) + 25 y = 0. $

  *Characteristic equation*
  $ r^2 + 6 r + 25 = 0 quad ==> quad r = (-6 plus.minus sqrt(36 - 100)) / 2 = -3 plus.minus 4 i. $
  $ y = e^(-3 v) (c_1 cos 4 v + c_2 sin 4 v). $

  *Change back to $x$* (using $e^(-3 v) = x^(-3)$)
  $ y(x) = x^(-3) [c_1 cos(4 ln x) + c_2 sin(4 ln x)], quad x > 0. $

  *Check* ($C = cos(4 ln x)$, $S = sin(4 ln x)$, $y_1 = x^(-3) C$)
  $ y'_1 &= x^(-4) (-3 C - 4 S), quad y''_1 = x^(-5) (-4 C + 28 S), \
    x^2 y''_1 + 7 x y'_1 + 25 y_1 &= x^(-3) [(-4 - 21 + 25) C + (28 - 28) S] = 0. #sym.checkmark $

  *Answer*
  $ y(x) = x^(-3) [c_1 cos(4 ln x) + c_2 sin(4 ln x)] $
]

#line(length: 100%)
// Book Problem 2
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Eigenvalues of a Damped Endpoint Problem*
  #line(length: 100%)
  *Reference:* _Differential Equations and Boundary Value Problems: Computing and Modeling_ (5th ed.), C. Henry Edwards, David E. Penney, and David Calvis
  @edwards2015differential[Sec. 3.8, Problem 13, p. 227]

  *Problem Statement:* \
  Consider the eigenvalue problem
  $ y'' + 2 y' + lambda y = 0; quad y(0) = y(1) = 0. $
  (a) Show that $lambda = 1$ is not an eigenvalue. (b) Show that there is no eigenvalue $lambda$ such that $lambda < 1$. (c) Show that the $n$th positive eigenvalue is $lambda_n = n^2 pi^2 + 1$, with associated eigenfunction $y_n (x) = e^(-x) sin n pi x$.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Characteristic equation*
  $ r^2 + 2 r + lambda = 0 quad ==> quad r = (-2 plus.minus sqrt(4 - 4 lambda)) / 2 = -1 plus.minus sqrt(1 - lambda). $
  The sign of $1 - lambda$ decides the type of root, so the cases split at $lambda = 1$.

  *(a) Case $lambda = 1$* (double root $r = -1$)
  $ y = (A + B x) e^(-x), quad y(0) = A = 0, quad y(1) = B e^(-1) = 0 quad ==> quad B = 0. $
  Only the trivial solution, so $lambda = 1$ is *not* an eigenvalue.

  *(b) Case $lambda < 1$* (real roots $r = -1 plus.minus beta$, $beta = sqrt(1 - lambda) > 0$)
  $ y = e^(-x) (A cosh beta x + B sinh beta x), quad y(0) = A = 0, $
  $ y(1) = B e^(-1) sinh beta = 0. $
  Since $beta > 0$, $sinh beta > 0$, so $B = 0$. Only the trivial solution, so there is *no* eigenvalue $lambda < 1$.

  *(c) Case $lambda > 1$* (complex roots $r = -1 plus.minus i omega$, $omega = sqrt(lambda - 1) > 0$)
  $ y = e^(-x) (A cos omega x + B sin omega x), quad y(0) = A = 0, $
  $ y(1) = B e^(-1) sin omega = 0. $
  For a nontrivial solution, $B != 0$, so $sin omega = 0 ==> omega = n pi$. Since $omega^2 = lambda - 1$:
  $ lambda_n = n^2 pi^2 + 1, quad y_n (x) = e^(-x) sin n pi x, quad n = 1, 2, 3, dots $

  *Check* ($n = 1$, $y = e^(-x) sin pi x$)
  $ y' &= e^(-x) (pi cos pi x - sin pi x), quad y'' = e^(-x) ((1 - pi^2) sin pi x - 2 pi cos pi x), \
    y'' + 2 y' + (pi^2 + 1) y &= e^(-x) [(1 - pi^2 - 2 + pi^2 + 1) sin pi x + (-2pi + 2pi) cos pi x] = 0. #sym.checkmark $

  *Answer*
  $ lambda_n = n^2 pi^2 + 1, quad y_n (x) = e^(-x) sin n pi x, quad n = 1, 2, 3, dots $
  so $lambda_1 = pi^2 + 1 approx 10.870$, $lambda_2 = 4 pi^2 + 1 approx 40.478$, $lambda_3 = 9 pi^2 + 1 approx 89.826$.
]

#line(length: 100%)

// Remix Problem Part 1 and Part 2
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix: A Cauchy–Euler Dirichlet Eigenvalue Problem*
  #line(length: 100%)
  *Based on Book Problems 1 and 2* @edwards2015differential[Sec. 3.3, Problem 53; Sec. 3.8, Problem 13].

  *Problem Statement:* \
  Replace the constant $25$ in Book Problem 1 with an eigenvalue parameter $lambda$:
  $ x^2 y'' + 7 x y' + lambda y = 0. $
  + *Part A:* Find all eigenvalues and eigenfunctions with $y(1) = 0$, $y(e^pi) = 0$. Is $lambda = 25$ (the equation of Book Problem 1) an eigenvalue?
  + *Part B:* Write the equation in Sturm–Liouville form, identify the weight, and show that $y_1$ and $y_2$ from Part A are orthogonal with respect to it. Then put Book Problem 2 in Sturm–Liouville form and explain how its weight relates to the remix weight under $t = ln x$.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  #v(0.5em)
  *Step 1: Substitution $t = ln x$*

  As in Book Problem 1, let $t = ln x$ (so $x = e^t$) and $Y(t) = y(e^t)$. By the chain rule,
  $ (dif Y) / (dif t) = (dif y) / (dif x) dot (dif x) / (dif t) = x y', quad
    (dif^2 Y) / (dif t^2) = (dif) / (dif t) (x y') = x y' + x^2 y''. $
  So
  $ x y' = Y', quad x^2 y'' = Y'' - Y'. $
  Substituting into the remix equation:
  $ x^2 y'' + 7 x y' + lambda y &= (Y'' - Y') + 7 Y' + lambda Y \
    &= Y'' + 6 Y' + lambda Y = 0. $
  This is a constant-coefficient equation in $t$.

  #v(0.6em)
  #v(0.5em)
  *Step 2: Characteristic equation and the three cases*

  Trying $Y = e^(r t)$:
  $ r^2 + 6 r + lambda = 0 quad ==> quad r = (-6 plus.minus sqrt(36 - 4 lambda)) / 2 = -3 plus.minus sqrt(9 - lambda). $
  The sign of $9 - lambda$ decides the type of root, so the cases split at $lambda = 9$ (just as the $2 y'$ term in Book Problem 2 moved its split to $lambda = 1$):

  - *$lambda < 9$* (two real roots $r = -3 plus.minus beta$, with $beta = sqrt(9 - lambda) > 0$):
    $ Y(t) = e^(-3t) (A cosh beta t + B sinh beta t). $
  - *$lambda = 9$* (double root $r = -3$):
    $ Y(t) = e^(-3t) (A + B t). $
  - *$lambda > 9$* (complex roots $r = -3 plus.minus i omega$, with $omega = sqrt(lambda - 9) > 0$):
    $ Y(t) = e^(-3t) (A cos omega t + B sin omega t). $

  In every case $Y$ has the factor $e^(-3t)$, which is never zero. So whether $Y(t_0) = 0$ holds depends only on the bracketed part.

  #v(0.8em)
  *Part A*

  #v(0.5em)
  *Step 3: Convert the boundary conditions*

  $x = 1 ==> t = ln 1 = 0$ and $x = e^pi ==> t = ln e^pi = pi$, so
  $ y(1) = 0, quad y(e^pi) = 0 quad <==> quad Y(0) = 0, quad Y(pi) = 0. $

  #v(0.5em)
  *Step 4: Apply the boundary conditions in each case*

  - *$lambda < 9$:*
    $ Y(0) = e^0 (A cosh 0 + B sinh 0) = A = 0 quad ==> quad Y(t) = B e^(-3t) sinh beta t. $
    $ Y(pi) = B e^(-3pi) sinh beta pi = 0. $
    Since $beta > 0$, $sinh beta pi > 0$, and $e^(-3pi) > 0$, so $B = 0$. Only $Y equiv 0$: *no eigenvalues* here.

  - *$lambda = 9$:*
    $ Y(0) = A = 0 quad ==> quad Y(t) = B t e^(-3t), quad Y(pi) = B pi e^(-3pi) = 0 quad ==> quad B = 0. $
    Only $Y equiv 0$: *$lambda = 9$ is not an eigenvalue.*

  - *$lambda > 9$:*
    $ Y(0) = A cos 0 + B sin 0 = A = 0 quad ==> quad Y(t) = B e^(-3t) sin omega t. $
    $ Y(pi) = B e^(-3pi) sin omega pi = 0. $
    For a nontrivial solution we need $B != 0$, so
    $ sin omega pi = 0 quad ==> quad omega pi = n pi quad ==> quad omega = n, quad n = 1, 2, 3, dots $

  #v(0.5em)
  *Step 5: Eigenvalues and eigenfunctions*

  From $omega^2 = lambda - 9$ and $omega = n$:
  $ lambda_n = n^2 + 9. $
  Changing back with $t = ln x$ and $e^(-3t) = e^(-3 ln x) = x^(-3)$:
  $ y_n (x) = x^(-3) sin(n ln x), quad n = 1, 2, 3, dots $

  #align(center)[
    #table(
      columns: 3,
      align: center,
      stroke: 0.5pt + luma(180),
      table.header([$n$], [$lambda_n = n^2 + 9$], [$y_n (x)$]),
      [1], [$10$], [$x^(-3) sin(ln x)$],
      [2], [$13$], [$x^(-3) sin(2 ln x)$],
      [3], [$18$], [$x^(-3) sin(3 ln x)$],
      [4], [$25$], [$x^(-3) sin(4 ln x)$],
    )
  ]

  *Check:* $y_n (1) = 1^(-3) sin(n dot 0) = 0$ and $y_n (e^pi) = e^(-3pi) sin(n pi) = 0$. #sym.checkmark

  #v(0.5em)
  *Step 6: Is $lambda = 25$ an eigenvalue?*

  Set $n^2 + 9 = 25$, so $n^2 = 16$ and $n = 4$. *Yes:* $lambda = 25 = lambda_4$, with eigenfunction $y_4 = x^(-3) sin(4 ln x)$.

  We can confirm this directly from Book Problem 1's general solution, $y = x^(-3) [c_1 cos(4 ln x) + c_2 sin(4 ln x)]$:
  $ y(1) = 1^(-3) [c_1 cos 0 + c_2 sin 0] = c_1 = 0, $
  $ y(e^pi) = e^(-3pi) [0 dot cos 4 pi + c_2 sin 4 pi] = e^(-3pi) c_2 dot 0 = 0 quad "for every" c_2. $
  So the BVP $x^2 y'' + 7 x y' + 25 y = 0$, $y(1) = y(e^pi) = 0$ has infinitely many solutions $c_2 x^(-3) sin(4 ln x)$, which is exactly what it means for $25$ to be an eigenvalue.

  #v(0.8em)
  *Part B*

  #v(0.5em)
  *Step 7: Sturm–Liouville form of the remix equation*

  Divide $x^2 y'' + 7 x y' + lambda y = 0$ by $x^2$ to get leading coefficient $1$:
  $ y'' + 7 / x y' + lambda / x^2 y = 0. $
  The integrating factor is
  $ mu(x) = exp(integral 7 / x dif x) = exp(7 ln x) = x^7. $
  Multiply through by $x^7$:
  $ x^7 y'' + 7 x^6 y' + lambda x^5 y = 0. $
  The first two terms are exactly $(x^7 y')' = x^7 y'' + 7 x^6 y'$, so
  $ (x^7 y')' + lambda x^5 y = 0. $
  Comparing with $(p y')' + q y + lambda r y = 0$:
  $ p(x) = x^7, quad q(x) = 0, quad r(x) = x^5. $
  Both $p$ and $r$ are positive on $[1, e^pi]$, and the boundary conditions are separated, so this is a regular Sturm–Liouville problem with *weight $r(x) = x^5$*.

  #v(0.5em)
  *Step 8: Orthogonality of $y_1$ and $y_2$ from Part A*

  With $y_1 = x^(-3) sin(ln x)$ and $y_2 = x^(-3) sin(2 ln x)$, the weighted inner product is
  $ chevron.l y_1, y_2 chevron.r_r = integral_1^(e^pi) x^5 dot x^(-3) sin(ln x) dot x^(-3) sin(2 ln x) dif x. $
  The powers of $x$ combine as $x^5 dot x^(-3) dot x^(-3) = x^(-1)$:
  $ chevron.l y_1, y_2 chevron.r_r = integral_1^(e^pi) sin(ln x) sin(2 ln x) (dif x) / x. $
  Substitute $t = ln x$, $dif t = dif x slash x$, with limits $x = 1 -> t = 0$ and $x = e^pi -> t = pi$:
  $ chevron.l y_1, y_2 chevron.r_r = integral_0^pi sin t sin 2t dif t. $
  Using $sin A sin B = 1/2 [cos(A - B) - cos(A + B)]$:
  $ integral_0^pi sin t sin 2t dif t
    = 1/2 integral_0^pi (cos t - cos 3t) dif t
    = 1/2 [sin t - (sin 3t) / 3]_0^pi
    = 1/2 [(0 - 0) - (0 - 0)] = 0. #sym.checkmark $
  The weight $x^5$ exactly cancels the two factors of $x^(-3)$ and leaves $1 slash x = dif t slash dif x$, so orthogonality in $x$ reduces to the familiar orthogonality of sines in $t$.

  #v(0.5em)
  *Step 9: Sturm–Liouville form of Book Problem 2*

  For $y'' + 2 y' + lambda y = 0$, the integrating factor is
  $ mu(x) = exp(integral 2 dif x) = e^(2x). $
  Multiply through by $e^(2x)$:
  $ e^(2x) y'' + 2 e^(2x) y' + lambda e^(2x) y = 0 quad ==> quad (e^(2x) y')' + lambda e^(2x) y = 0, $
  so $p(x) = e^(2x)$, $q(x) = 0$, and the *weight is $r(x) = e^(2x)$*. Its eigenfunctions $y_n = e^(-x) sin n pi x$ are orthogonal with this weight:
  $ integral_0^1 e^(2x) dot e^(-x) sin m pi x dot e^(-x) sin n pi x dif x = integral_0^1 sin m pi x sin n pi x dif x = 0, quad m != n. $
  As in Step 8, the weight exactly cancels the decaying factors of the eigenfunctions.

  #v(0.5em)
  *Step 10: Connecting the two weights through $t = ln x$*

  In Step 1 the remix became $Y'' + 6 Y' + lambda Y = 0$, which has the *same form* as Book Problem 2 with $2$ replaced by $6$. Its integrating factor in $t$ is $e^(6t)$:
  $ (e^(6t) Y')' + lambda e^(6t) Y = e^(6t) (Y'' + 6 Y' + lambda Y) = 0, $
  so in the $t$ variable the weight is $e^(6t)$, just as Book Problem 2 has weight $e^(2x)$.

  This matches the weight $x^5$ found in Step 7. Since $x = e^t$ and $dif x = e^t dif t$:
  $ r(x) dif x = x^5 dif x = e^(5t) dot e^t dif t = e^(6t) dif t. $
  So the weight $x^5$ in $x$ and the weight $e^(6t)$ in $t$ describe the same inner product. #sym.checkmark

  #v(0.5em)
  *Step 11: The common pattern*

  Both problems are instances of the damped Dirichlet problem
  $ Y'' + 2 a Y' + lambda Y = 0, quad Y(0) = Y(L) = 0. $
  Repeating the case analysis of Book Problem 2 with $r = -a plus.minus sqrt(a^2 - lambda)$ shows there are no eigenvalues for $lambda <= a^2$, and for $lambda > a^2$ gives
  $ lambda_n = ((n pi) / L)^2 + a^2, quad Y_n = e^(-a t) sin((n pi t) / L), quad "weight" e^(2 a t). $

  #align(center)[
    #table(
      columns: 5,
      align: center,
      stroke: 0.5pt + luma(180),
      table.header([*Problem*], [$a$], [$L$], [$lambda_n$], [*Weight*]),
      [Book Problem 2], [$1$], [$1$], [$n^2 pi^2 + 1$], [$e^(2x)$],
      [Remix (in $t$)], [$3$], [$pi$], [$n^2 + 9$], [$e^(6t)$ (in $t$), i.e. $x^5$ (in $x$)],
    )
  ]

  Both rows agree with what we found directly: Book Problem 2 in part (c), and the remix in Step 5.

  #v(0.8em)
  *Answer*
  - *Part A:* $lambda_n = n^2 + 9$, $y_n (x) = x^(-3) sin(n ln x)$, $n = 1, 2, 3, dots$ Yes, $lambda = 25 = lambda_4$, with eigenfunction $x^(-3) sin(4 ln x)$.
  - *Part B:* The Sturm–Liouville form is $(x^7 y')' + lambda x^5 y = 0$ with weight $r(x) = x^5$, and $chevron.l y_1, y_2 chevron.r_r = 0$. Book Problem 2 has the form $(e^(2x) y')' + lambda e^(2x) y = 0$ with weight $e^(2x)$. Under $t = ln x$, the remix weight becomes $e^(6t)$, the same kind of weight as Book Problem 2 with damping $6$ in place of $2$.
]


#bibliography("../../../../resources/bibs/compendium/le2/2.1_alcancia.bib", style: "apa")
