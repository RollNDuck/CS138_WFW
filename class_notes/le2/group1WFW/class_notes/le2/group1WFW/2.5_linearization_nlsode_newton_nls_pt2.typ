#set page(paper: "a4", margin: 1in)
#set text(size: 11pt)
#set par(justify: true)
#set heading(numbering: none)

#align(center)[
  #text(size: 16pt, weight: "bold")[
    Newton's Method for NLS, Pseudocode, Example
  ]
]
= Week 10

== Prerequisite

=== Newton's Method for SNLE
#pad(left: 1.5em)[
  Newton's method for a single equation uses a tangent line to improve a
  current guess. For nonlinear systems, we apply the same idea to several
  equations at once. Since changing one unknown can affect several equations,
  all corrections must be solved together. @ruaya2026nonlinear

  ==== Formula
  Consider a system of $n$ nonlinear equations in $n$ unknowns:
  $ F(x)=0, $
  where $x=(x_1,x_2,dots,x_n)^T in RR^n$ and
  $F(x)=(f_1(x),f_2(x),dots,f_n(x))^T$.

  Using a first-order Taylor expansion about the current iterate $x^((k))$,
  with $Delta x^((k))=x^((k+1))-x^((k))$, gives
  $ f_i(x^((k+1))) approx f_i(x^((k)))
    +sum_(j=1)^n (partial f_i)/(partial x_j)(x^((k)))
      Delta x_j^((k)). $

  Setting this linear approximation to zero produces the correction system
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt,
    stroke: 0.5pt + luma(150), width: 100%)[
    $ J_F(x^((k))) Delta x^((k))=-F(x^((k))), $
    $ x^((k+1))=x^((k))+Delta x^((k)). $
  ]

  Here, $F(x^((k)))$ measures how far the current guess is from satisfying
  the equations. The term $J_F(x^((k)))Delta x^((k))$ predicts how the
  residual changes after adjusting the unknowns. We choose a correction that
  cancels the current residual in this linear approximation. Since this is
  only a local approximation, the updated guess may still have a nonzero
  residual, so the process is repeated. @burden2010numerical
=== Newton Pseudocode
  #pad(left: 1.5em)[
  #block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt,
    stroke: 0.5pt + luma(150), width: 100%)[
    To approximate a solution of $F(x)=0$, start with an initial approximation
    $x^((0))$.

    *Inputs:*
    - $n$: number of equations and unknowns;
    - $x=(x_1,x_2,dots,x_n)^T$: initial approximation;
    - $"TOL" > 0$: convergence tolerance;
    - $N$: maximum number of iterations.

    *Output:* an approximate solution $x$, or a failure message.

    #line(length: 100%, stroke: 0.5pt + luma(200))

    + *Step 1:* Set $k=1$. \
      _This starts the counter for the first Newton update._

    + *Step 2:* While $k <= N$, perform Steps 3-7. \
      _The iteration cap prevents the procedure from running indefinitely._

    + *Step 3:* Evaluate $F(x)$ and the Jacobian $J_F(x)$, where
      $ (J_F(x))_(i j)=(partial f_i(x))/(partial x_j),
        quad 1 <= i,j <= n. $ \
      _We substitute the current guess into every equation and derivative;
      row $i$ represents equation $f_i$, while column $j$ represents variable
      $x_j$._

    + *Step 4:* Solve the linear system
      $ J_F(x)y=-F(x) $
      for the correction vector $y$. \
      _The correction predicts the changes needed to cancel the current
      residual. We solve the system directly instead of computing
      $J_F(x)^(-1)$._

    + *Step 5:* Update $x <- x+y$. \
      _Each component of $y$ is added to its corresponding unknown._

    + *Step 6:* If $norm(y)<"TOL"$, output $x$ and stop successfully. \
      _A small correction means that the iterates are no longer changing much._

    + *Step 7:* Set $k <- k+1$. \
      _If the tolerance is not met, evaluate the system again at the new guess._

    + *Step 8:* Output "Maximum number of iterations exceeded" and stop. \
      _Reaching this step means that the requested tolerance was not obtained._
  ]
  #align(right)[#text(size: 9.5pt, style: "italic")[Adapted from Algorithm 10.1 in @burden2010numerical.]]
]

=== SNLE Example: Circle-Hyperbola Intersection
#pad(left: 1.5em)[
  Approximate an intersection of $x^2+y^2=3$ and $x y=1$, starting from
  $(x^((0)),y^((0)))=(0.5,1.5)$. Define
  $ F(x,y)=mat(x^2+y^2-3;x y-1), quad
    J_F(x,y)=mat(2x,2y;y,x). $
  @ruayavillar2026nonlinear

  ==== First Iteration
  *1. Evaluate residual.* Substitute $(0.5,1.5)$ into both equations:
  $ f_1(0.5,1.5)
    &=(0.5)^2+(1.5)^2-3 \
    &=0.25+2.25-3=-0.5, $
  $ f_2(0.5,1.5)
    &=(0.5)(1.5)-1 \
    \ &= 0.75-1=-0.25. $
  Therefore,
  $ F(0.5,1.5)=mat(-0.5;-0.25). $

  *2. Evaluate Jacobian.*
  $ J_F(0.5,1.5)
    =mat(2(0.5),2(1.5);1.5,0.5)
    =mat(1,3;1.5,0.5). $

  *3. Solve for correction*
  $ mat(1,3;1.5,0.5)mat(Delta x;Delta y)
    =-mat(-0.5;-0.25)=mat(0.5;0.25). $
  The two equations are
  $ Delta x+3Delta y=0.5, quad
    1.5Delta x+0.5Delta y=0.25. $
  From the first equation, $Delta x=0.5-3Delta y$. Substituting into
  the second equation gives
  $ 1.5(0.5-3Delta y)+0.5Delta y&=0.25 \
    0.75-4Delta y&=0.25 \
    Delta y&=0.125. $
  Hence, $Delta x=0.5-3(0.125)=0.125$.

  *4. Update the guess.*
  $ x^((1))&=0.5+0.125=0.625, \
    y^((1))&=1.5+0.125=1.625. $
  Thus, $(x^((1)),y^((1)))=(0.625,1.625)$.

  ==== Second Iteration
  *1. Re-evaluate residual.*
  $ f_1(0.625,1.625)
    &=(0.625)^2+(1.625)^2-3 \
    &=0.390625+2.640625-3=0.03125, $
  $ f_2(0.625,1.625)
    &=(0.625)(1.625)-1\
    &=1.015625-1=0.015625. $
  #v(0.4em)
  Therefore,
  $ F(0.625,1.625)=mat(0.03125;0.015625). $

  #v(0.4em)
  *2. Re-evaluate Jacobian.*
  $ J_F(0.625,1.625)
    =mat(1.25,3.25;1.625,0.625). $

  #v(0.4em)
  *3. Solve for new correction.*
  $ mat(1.25,3.25;1.625,0.625)mat(Delta x;Delta y)
    =mat(-0.03125;-0.015625). $
  slovign gives
  $ Delta x=Delta y=-1/144 approx -0.00694444.  $

  #v(0.4em)
  *4. Update the guess.*
  $ x^((2))&=0.625-1/144 approx 0.61805556, \
    y^((2))&=1.625-1/144 approx 1.61805556. 
    $

  ==== Newton Iteration Table
  Each row records the current guess and the correction used to obtain the next
  row. 

  #set text(size: 9.5pt)
  #table(
    columns: (0.35fr, 1fr, 1fr, 1fr, 1fr, 1.15fr),
    align: center,
    inset: 5pt,
    stroke: 0.5pt + luma(150),
    fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
    table.header([$k$], [$x^((k))$], [$y^((k))$],
      [$Delta x^((k))$], [$Delta y^((k))$], [$norm(F)_oo$]),
    [0], [0.50000000], [1.50000000], [+0.12500000], [+0.12500000], [0.50000000],
    [1], [0.62500000], [1.62500000], [-0.00694444], [-0.00694444], [0.03125000],
    [2], [0.61805556], [1.61805556], [-], [-], [$9.6451 times 10^(-5)$],
  )
==== Connection to Nonlinear BVP Methods

In the circle-hyperbola example, we guessed two unknown numbers, $x$ and
$y$. For a BVP, we need an unknown function $u(x)$. We approximate that
function using finitely many unknown numbers.

- *Finite differences:* The unknown numbers are approximate function values
  at fixed grid points. For example,
  $ U^((k))=mat(u_1^((k));u_2^((k));u_3^((k))) $
  represents our current guesses for three interior points. Substituting
  finite-difference formulas into the ODE produces equations. We write this as $F(U)=0$.

- *Collocation:* We choose a trial function, such as
  $ p(x)=a_0+a_1 x+a_2 x^2. $
  Here, the unknown numbers are $a_0$, $a_1$, and $a_2$. Requiring the trial
  function to satisfy the ODE at selected points and the boundary conditions
  produces equations for these coefficients.

For either method, we now have an SNLE and can use the same Newton
procedure: evaluate the residual and Jacobian, solve for a correction,
and update the unknown numbers.

A Newton iteration table records these guesses. For finite differences, each row represents a guessed solution grid. On the other hand,  the coefficient form of collocation, each row contains
coefficients defining a guessed curve.
]]

=== AI Contribution
*(Alphonso Clarence C. Carandang)*
I used ChatGPT to help check the Newton derivation, expand the arithmetic in the
worked example, clarify each pseudocode step, and format the section in Typst.
I verified the formulas and numerical results against the October 28 lecture
slides and Burden and Faires book.
\ (link: https://chatgpt.com/share/6aeb219f-eaf4-83ec-a13b-fc7e3273d550) 

// END Carandang ================================

slides and Burden and Faires.


= References

#bibliography(
  "../../../resources/bibs/class_notes/le2/2.5_linearization_nlsode_newton_nls_pt2.bib",
  style: "apa",
  title: none,
)
