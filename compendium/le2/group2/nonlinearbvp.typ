#set page(paper: "a4", margin: (x: 2cm, y: 2cm))
#set text(font: "Liberation Serif", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)
#set math.mat(delim: "[")

#show heading.where(level: 1): set text(size: 22pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 13pt)
#show bibliography: set heading(numbering: none)
#show math.equation.where(block: true): set block(above: 0.4em, below: 0.4em)

// For the central compendium, copy the two problem blocks and their solutions.
// Use the central file's existing Group / Contributor headings and bibliography.

= Group 1 (WFW-1)
#v(1.5em)
== Carandang

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Nonlinear Pendulum BVP: One Newton Iteration*
  #line(length: 100%)
  *Reference:* Adapted from 
  #cite(<leveque2007>)
  @leveque2007[Sec. 2.16.1, pp. 38–39, Eqs. (2.77)–(2.82); PDF pp. 53–54].

  *Problem Statement:* \
  $ theta''(t)=-sin(theta(t)), quad 0 <= t <= 2pi, $
  $ theta(0)=0.7, quad theta(2pi)=0.7, $
  use two interior grid points and perform one Newton iteration from
  $theta^((0))=mat(0.7;0.7)$.

  _The grid and iteration count are adapted for hand calculation. Use radians._
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Grid*
  $ h=frac(2pi,3), quad
    t_0=0, quad t_1=frac(2pi,3), quad
    t_2=frac(4pi,3), quad t_3=2pi. $
  $ theta_0=theta_3=0.7, quad q=h^2=frac(4pi^2,9)
    approx 4.3864908449. $

  *Residual equations*
  $ frac(theta_(i-1)-2theta_i+theta_(i+1),h^2)
    +sin(theta_i)=0. $
  Multiplying each equation by $h^2$ gives
  $ F(theta)=mat(
      0.7-2theta_1+theta_2+q sin(theta_1);
      theta_1-2theta_2+0.7+q sin(theta_2)
    )=0. $

  *Jacobian*
  $ J_F(theta)=mat(
      -2+q cos(theta_1), 1;
      1, -2+q cos(theta_2)
    ). $

  *Evaluate at $(0.7,0.7)$*
  $ F_1(0.7,0.7)=F_2(0.7,0.7)
      &=0.7-2(0.7)+0.7+4.3864908449 sin(0.7) \
      &approx 2.8258549872. $
  $ -2+4.3864908449 cos(0.7) approx 1.3549732523. $

  *Solve for the correction*
  $ mat(1.3549732523,1;1,1.3549732523)
      mat(Delta theta_1;Delta theta_2)
    approx mat(-2.8258549872;-2.8258549872). $
  Subtracting the two rows gives
  $ 0.3549732523(Delta theta_1-Delta theta_2)=0
    ==> Delta theta_1=Delta theta_2. $
  Hence
  $ (1.3549732523+1)Delta theta_1&=-2.8258549872, \
    Delta theta_1=Delta theta_2
      &approx frac(-2.8258549872,2.3549732523)
      approx -1.19995205. $

  *Answer*
  $ theta^((1))=mat(0.7;0.7)+mat(-1.19995205;-1.19995205)
      approx mat(-0.49995205;-0.49995205). $
]

#pagebreak()  

#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Nonlinear Finite-Difference BVP*
  #line(length: 100%)
  *Reference:* 
  Adapted from #cite(<burden2010numerical>) @burden2010numerical[Sec. 11.4, Exercise 1, p. 696].
  \ *Problem Statement:* \
  With $h=0.5$, perform one Newton iteration from the linear boundary
  interpolant for
  $ y''=-(y')^2-y+ln(x), quad 1 <= x <= 2, $
  $ y(1)=0, quad y(2)=ln(2). $
]

=== Solution


#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Grid and initial guess*
  $ x_0=1, quad x_1=1.5, quad x_2=2, $
  $ w_0=0, quad w_2=ln(2), quad w_1 approx y(1.5). $
  $ w_1^((0))
    =0+(ln(2)-0)frac(1.5-1,2-1)
    =frac(1,2)ln(2) approx 0.34657359. $

  *Finite-difference equation*
  $ y''+(y')^2+y-ln(x)=0. $
  $ F_1(w_1)
    &=frac(w_2-2w_1+w_0,h^2)
      +lr((frac(w_2-w_0,2h)))^2+w_1-ln(1.5) \
    &=frac(ln(2)-2w_1+0,0.25)
      +lr((frac(ln(2)-0,1)))^2+w_1-ln(1.5) \
    &=4ln(2)-8w_1+(ln(2))^2+w_1-ln(1.5) \
    &=4ln(2)-7w_1+(ln(2))^2-ln(1.5)=0. $
  $ F_1'(w_1)=-7. $

  #block(breakable: false)[
  *Newton correction*
  $ F_1(w_1^((0)))
    &=4ln(2)-7lr((frac(1,2)ln(2)))+(ln(2))^2-ln(1.5) \
    &=frac(1,2)ln(2)+(ln(2) )^2-ln(1.5) \
    &approx 0.4215614961. $
  ]
  $ -7 Delta w_1^((0))&=-0.4215614961, \
    Delta w_1^((0))&=frac(-0.4215614961,-7)
      approx 0.0602230709.   $

  *Update*
  $ w_1^((1))
    =w_1^((0))+Delta w_1^((0))
    approx 0.3465735903+0.0602230709
    =0.4067966611. $
  *Answer and Checking Error $y(x)=ln(x)$*
  $ w_1^((1)) approx 0.0602230709 $
  $ y(1.5)=ln(1.5) approx 0.4054651081, $
  $ |w_1^((1))-y(1.5)|
    approx |0.4067966611-0.4054651081|
    =1.331553 times 10^(-3). $


]



#pagebreak() 
#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix: Unequal Boundary Angles*
  #line(length: 100%)
  *Based on the pendulum problem above.*

  *Problem Statement:* \
  Keep $theta''=-sin(theta)$ and $h=2pi/3$, but change the boundaries to
  $theta(0)=0.3$ and $theta(2pi)=0.9$.
  Perform one Newton iteration from the linear boundary interpolant.
]

=== Solution

#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Initial guess*
  $ theta_i^((0))=0.3+(0.9-0.3)frac(t_i,2pi). $
  $ theta_1^((0))=0.3+0.6frac(1,3)=0.5, quad
    theta_2^((0))=0.3+0.6frac(2,3)=0.7. $

  *Residual and Jacobian*
  With $q=4pi^2/9$,
  $ F(theta)=mat(
      0.3-2theta_1+theta_2+q sin(theta_1);
      theta_1-2theta_2+0.9+q sin(theta_2)
    ), $
  $ J_F(theta)=mat(
      -2+q cos(theta_1),1;
      1,-2+q cos(theta_2)
    ). $

  *Evaluate at $(0.5,0.7)$*
  $ F_1(0.5,0.7)
      &=0.3-2(0.5)+0.7+4.3864908449 sin(0.5) \
      &approx 2.1029957359, \
    F_2(0.5,0.7)
      &=0.5-2(0.7)+0.9+4.3864908449 sin(0.7) \
      &approx 2.8258549872. $
  $ J_F(0.5,0.7)
      &=mat(
        -2+4.3864908449 cos(0.5),1;
        1,-2+4.3864908449 cos(0.7)
      ) \
      &approx mat(1.8495078734,1;1,1.3549732523). $

  *Solve for the correction*
  $ mat(1.8495078734,1;1,1.3549732523)
      mat(Delta theta_1;Delta theta_2)
    approx mat(-2.1029957359;-2.8258549872). $
  From the first row,
  $ Delta theta_2=-2.1029957359-1.8495078734 Delta theta_1. $
  Substitute into the second row:
  $ Delta theta_1
      +1.3549732523(-2.1029957359-1.8495078734 Delta theta_1)
      &=-2.8258549872, \
    -1.5060336984 Delta theta_1&=0.0236479847, \
    Delta theta_1&approx -0.01570216, \
    Delta theta_2
      &approx -2.1029957359-1.8495078734(-0.01570216) \
      &approx -2.07395446. $

  *Answer*
  $ theta^((1))=mat(0.5;0.7)+mat(-0.01570216;-2.07395446)
    approx mat(0.48429784;-1.37395446). $
]



#block(fill: rgb("f9f9f9"), inset: 12pt, radius: 4pt, stroke: 0.5pt + luma(150))[
  *Remix 2: Replacing a Boundary Value with a Flux*
  #line(length: 100%)
  *Based on Book Problem 2.*
\   *Problem Statement:* \
  (Problem)
  Use $h=0.5$ and a fictitious point for
  $ y''=-(y')^2-y+ln(x), quad 1 <= x <= 2, $
  $ y(1)=0, quad y'(2)=frac(1,2). $
  Form the equations for $w_1,w_2$ and perform one Newton iteration from
  $w^((0))=mat(0.25;0.50)$.
]

=== Solution
#pad(left: 2em)[
  #set par(spacing: 0.5em)
  *Fictitious point*
  $ x_0=1, quad x_1=1.5, quad x_2=2, quad x_3=2.5. $
  $ frac(w_3-w_1,2h)=frac(1,2)
    ==> w_3-w_1=0.5
    ==> w_3=w_1+0.5. $

  *Residual equations*
  $ F_1
    &=frac(w_2-2w_1+0,0.25)
      +lr((frac(w_2-0,1)))^2+w_1-ln(1.5) \
    &=4w_2-8w_1+w_2^2+w_1-ln(1.5) \
    &=4w_2-7w_1+w_2^2-ln(1.5)=0. $

  $ F_2
    &=frac(w_3-2w_2+w_1,0.25)
      +lr((frac(w_3-w_1,1)))^2+w_2-ln(2) \
    &=4((w_1+0.5)-2w_2+w_1)+(0.5)^2+w_2-ln(2) \
    &=8w_1-8w_2+2+0.25+w_2-ln(2) \
    &=8w_1-7w_2+2.25-ln(2)=0. $

  *Jacobian and residual at the initial guess*
  $ J_F(w)=mat(-7,4+2w_2;8,-7), quad
    J_F(0.25,0.50)=mat(-7,5;8,-7). $
  $ F_1(0.25,0.50)
    &=4(0.50)-7(0.25)+(0.50)^2-ln(1.5) \
    &=0.50-ln(1.5) approx 0.0945348919, \
    F_2(0.25,0.50)
    &=8(0.25)-7(0.50)+2.25-ln(2) \
    &=0.75-ln(2) approx 0.0568528194. $

  *Solve for the correction*
  $ mat(-7,5;8,-7)mat(Delta w_1;Delta w_2)
    approx mat(-0.0945348919;-0.0568528194). $

  Eliminate $Delta w_2$ using $7R_1+5R_2$:
  $ Delta w_1
      &=frac(7(-0.0945348919)+5(-0.0568528194),-9)
      approx 0.10511204, \
    Delta w_2
      &=frac(-0.0945348919+7(0.10511204),5)
      approx 0.12824987. $

  *Answer*
  $ w^((1))=mat(0.25;0.50)+mat(0.10511204;0.12824987)
    approx mat(0.35511204;0.62824987). $
] 


#bibliography("nonlinearbvp.bib", style: "apa", full: true)

