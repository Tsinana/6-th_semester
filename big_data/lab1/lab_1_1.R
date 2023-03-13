  q = c(1, 0, 2, 3, 6, 8, 12, 15, 0, NA, NA, 9, 4, 16, 2, 0)
  q[1]
  q[length(q)]
  q[3:5]
  q[q==2]
  q[q>4]
  q[q%%3==0]
  q[q>4 & q%%3==0]
  q[q<1 | q>5]
  which(q == 0)
  which(q>1 & q<9)