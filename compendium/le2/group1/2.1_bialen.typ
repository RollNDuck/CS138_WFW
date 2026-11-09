#import "../../../template.typ": project

#show: project.with(
  title: "Eigenvalue BVPs and Cauchy–Euler Equations: Solved Problems",
  contributor: "Bialen",
  date: "November 9 2026",
)

#show bibliography: set heading(numbering: none)
#set math.mat(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)

== (Bialen)

// Book Problem 1
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *A Cauchy–Euler Eigenvalue Boundary Value Problem*
  #line(length: 100%)
  *Reference:* _Examples of Eigenvalue Problems: Calculus 4c-2_, Leif Mejlbro
  @mejlbro2008eigenvalue[Example 2.15, pp. 46–48]

  *Problem Statement:* \
  Find all real eigenvalues $lambda$ and corresponding nonzero eigenfunctions for
  $ x^2 y'' + x y' + lambda y = 0, quad 1 < x < e, quad y(1) = 0, quad y(e) = 0. $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Trial solution $y = x^r$*
  $ y' = r x^(r-1), quad y'' = r(r-1) x^(r-2)
    quad ==> quad x^r (r(r-1) + r + lambda) = 0
    quad ==> quad r^2 + lambda = 0. $

  *Case $lambda = -mu^2 < 0$*
  $ r = plus.minus mu, quad y = C_1 x^mu + C_2 x^(-mu). $
  $ y(1) = 0 ==> C_2 = -C_1, quad y(e) = 0 ==> C_1 (e^mu - e^(-mu)) = 0. $
  Since $e^mu - e^(-mu) > 0$, $C_1 = C_2 = 0$. No negative eigenvalues.

  *Case $lambda = 0$*
  $ r = 0 "(repeated)", quad y = C_1 + C_2 ln x. $
  $y(1) = 0 ==> C_1 = 0$, and $y(e) = 0 ==> C_2 = 0$ (since $ln e = 1$). $lambda = 0$ is *not* an eigenvalue.

  *Case $lambda = mu^2 > 0$*
  $ r = plus.minus mu i, quad y = C_1 cos(mu ln x) + C_2 sin(mu ln x). $
  $y(1) = 0 ==> C_1 = 0$ (since $ln 1 = 0$). Then
  $ y(e) = C_2 sin mu = 0. $
  For a nonzero eigenfunction, $C_2 != 0$, so $sin mu = 0 ==> mu = n pi$, $n = 1, 2, 3, dots$

  *Check* ($k = n pi$, $y_n = sin(k ln x)$)
  $ y'_n &= k / x cos(k ln x), quad y''_n = -k / x^2 cos(k ln x) - k^2 / x^2 sin(k ln x), \
    x^2 y''_n + x y'_n &= -k cos(k ln x) - k^2 sin(k ln x) + k cos(k ln x) = -k^2 y_n. $
  Since $lambda_n = k^2$, the equation holds, and $y_n(1) = sin 0 = 0$, $y_n(e) = sin n pi = 0$. #sym.checkmark

  *Answer*
  $ lambda_n = n^2 pi^2, quad y_n (x) = sin(n pi ln x), quad n = 1, 2, 3, dots $
  (any nonzero constant multiple of $y_n$ is also an eigenfunction).
]

#line(length: 100%)

// Book Problem 2
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *A Periodic-Boundary Eigenvalue Problem on $[-pi, pi]$*
  #line(length: 100%)
  *Reference:* _Examples of Eigenvalue Problems: Calculus 4c-2_, Leif Mejlbro
  @mejlbro2008eigenvalue[Example 2.17, pp. 51–52]

  *Problem Statement:* \
  Find all real eigenvalues $lambda$ and the corresponding eigenfunctions for
  $ y'' + lambda y = 0, quad -pi < x < pi, $
  subject to the periodic boundary conditions
  $ y(-pi) = y(pi), quad y'(-pi) = y'(pi). $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Case $lambda = -k^2 < 0$*
  $ y = C_1 cosh k x + C_2 sinh k x, quad y' = k C_1 sinh k x + k C_2 cosh k x. $
  $ y(-pi) - y(pi) = -2 C_2 sinh k pi = 0 ==> C_2 = 0, $
  $ y'(-pi) - y'(pi) = -2 k C_1 sinh k pi = 0 ==> C_1 = 0. $
  Since $sinh k pi > 0$, only the trivial solution exists. No negative eigenvalues.

  *Case $lambda = 0$*
  $ y = C_1 x + C_2, quad y' = C_1. $
  $ y(-pi) = y(pi) ==> -C_1 pi + C_2 = C_1 pi + C_2 ==> C_1 = 0. $
  The derivative condition then holds automatically, and $C_2$ is free. So $lambda = 0$ *is* an eigenvalue with $y_0 = 1$.

  *Case $lambda = k^2 > 0$*
  $ y = C_1 cos k x + C_2 sin k x, quad y' = -k C_1 sin k x + k C_2 cos k x. $
  Using that $cos$ is even and $sin$ is odd:
  $ y(-pi) = y(pi) &==> -2 C_2 sin k pi = 0, \
    y'(-pi) = y'(pi) &==> 2 k C_1 sin k pi = 0. $
  For a nonzero pair $(C_1, C_2)$: $sin k pi = 0 ==> k = n$, $n = 1, 2, 3, dots$ Both $C_1$ and $C_2$ are then free, so each eigenspace is two-dimensional.

  *Check*
  For integer $n >= 1$, $cos n x$ and $sin n x$ solve $y'' + n^2 y = 0$, and
  $ cos(-n pi) = cos(n pi), quad sin(-n pi) = sin(n pi), $
  $ -n sin(-n pi) = -n sin(n pi), quad n cos(-n pi) = n cos(n pi). #sym.checkmark $

  *Answer*
  $ lambda_0 = 0, quad y_0 (x) = 1; quad
    lambda_n = n^2, quad y_n (x) = C_1 cos n x + C_2 sin n x, quad n = 1, 2, 3, dots $
  with basis $\{cos n x, sin n x\}$ for each eigenspace $n >= 1$.
]

#line(length: 100%)

// Remix of Book Problems 1 and 2
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix: A Cauchy–Euler Eigenvalue Problem with Periodic-Type Conditions*
  #line(length: 100%)
  *Based on Book Problems 1 and 2* @mejlbro2008eigenvalue[Examples 2.15 and 2.17].

  *Problem Statement:* \
  Combine the Cauchy–Euler equation of Book Problem 1 with the periodic boundary structure of Book Problem 2. Find all real eigenvalues $lambda$ and corresponding eigenfunctions for
  $ x^2 y'' + x y' + lambda y = 0, quad 1 < x < e^(2 pi), $
  subject to
  $ y(1) = y(e^(2 pi)), quad y'(1) = e^(2 pi) y'(e^(2 pi)). $
]

=== Solutions
#line(length: 50%)

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  #v(0.5em)
  *Step 1: Substitution $t = ln x$*

  Let $t = ln x$ and $z(t) = y(e^t)$. By the chain rule,
  $ z'(t) = x y'(x), quad z''(t) = x y'(x) + x^2 y''(x)
    quad ==> quad x^2 y'' + x y' = z''. $
  The equation becomes
  $ z'' + lambda z = 0, quad 0 < t < 2 pi. $

  #v(0.5em)
  *Step 2: Transform the boundary conditions*

  $x = 1$ corresponds to $t = 0$ and $x = e^(2 pi)$ to $t = 2 pi$, so $y(1) = y(e^(2 pi))$ becomes $z(0) = z(2 pi)$. Using $z' = x y'$:
  $ z'(0) = y'(1), quad z'(2 pi) = e^(2 pi) y'(e^(2 pi)) quad ==> quad z'(0) = z'(2 pi). $
  This is a periodic eigenvalue problem on $[0, 2 pi]$:
  $ z'' + lambda z = 0, quad z(0) = z(2 pi), quad z'(0) = z'(2 pi). $

  #v(0.5em)
  *Step 3: Case $lambda = -k^2 < 0$*

  $ z = A cosh k t + B sinh k t. $
  With $c = cosh 2 pi k$ and $s = sinh 2 pi k$, the conditions give
  $ (1 - c) A - s B = 0, quad -s A + (1 - c) B = 0. $
  The determinant is $(1 - c)^2 - s^2 = 2(1 - c)$. Since $c > 1$, it is nonzero, so $A = B = 0$. No negative eigenvalues.

  #v(0.5em)
  *Step 4: Case $lambda = 0$*

  $ z = A t + B, quad z(0) = z(2 pi) ==> B = 2 pi A + B ==> A = 0. $
  The derivative condition holds and $B$ is free, so $lambda = 0$ is an eigenvalue with $z_0 = 1$, i.e. $y_0 (x) = 1$.

  #v(0.5em)
  *Step 5: Case $lambda = k^2 > 0$*

  $ z = A cos k t + B sin k t. $
  With $c = cos 2 pi k$ and $s = sin 2 pi k$, the conditions give
  $ (1 - c) A - s B = 0, quad s A + (1 - c) B = 0. $
  The determinant is $(1 - c)^2 + s^2 = 2(1 - c)$. A nonzero solution requires $c = 1$:
  $ 2 pi k = 2 n pi quad ==> quad k = n, quad n = 1, 2, 3, dots $
  Both $A$ and $B$ are free, so the eigenspace in $t$ is spanned by $cos n t$ and $sin n t$.

  #v(0.5em)
  *Step 6: Back to $x$*

  Since $t = ln x$:
  $ y_(n,1) (x) = cos(n ln x), quad y_(n,2) (x) = sin(n ln x). $

  #v(0.5em)
  *Step 7: Check*

  For $y = cos(n ln x)$ or $sin(n ln x)$, the same computation as in Book Problem 1 gives $x^2 y'' + x y' = -n^2 y$, so the equation holds with $lambda = n^2$. In $t$ these are $cos n t$ and $sin n t$, which together with their derivatives agree at $t = 0$ and $t = 2 pi$ because $n$ is an integer. So the original conditions in $x$ hold. #sym.checkmark

  #v(0.8em)
  *Answer*
  $ lambda_0 = 0, quad y_0 (x) = 1; quad
    lambda_n = n^2, quad y_n (x) = C_1 cos(n ln x) + C_2 sin(n ln x), quad n = 1, 2, 3, dots $
  The remix keeps the eigenvalues of Book Problem 2, while the eigenfunctions pick up the $ln x$ argument of Book Problem 1.
]

#line(length: 100%)


// ─────────────────────────────────────────────
#bibliography("../../../resources/bibs/compendium/le2/2.1_bialen.bib", style: "apa")
