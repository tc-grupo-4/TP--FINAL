# coding=utf-8

import phase_margin

for i in range(1,7):
    pm1 = phase_margin.compute_margin("margins/etapa"+str(i)+".txt")
    print("pha margin:", pm1["pm"], "deg ,mag margin:", pm1["mm"], "db")

