
syms del(Hr)
del(Hr) = sqrt((H+Hr)^2 + D^2) - sqrt((H-Hr)^2 +D^2);
df = diff(del, Hr);
