

import sys

num_colums= 20
file_address= "C:/Users/sa2236/Desktop/temp_text.txt"

file_address2= "C:/Users/sa2236/Desktop/lb_modelsim/collidem10k.v"
fd = open(file_address2, "r")
fw= open(file_address,"w")
#td= int(sys.argv[1])
#print(num_colums)
v=" y_collide_write"
#td= int(sys.argv[1])
#print(num_colums)
pp=" (({0})<<7) + (({0})<<3) "
#fw.write(g.format(c[x],z[1]))
print(pp.format(v))
#for u in range(0,12512):
   # dd=" #10 start_init=1'b1;"
   ##### d4=" #100;"
    #print(d0.format(u))
    #print(d5.format(u))
    #print(d1.format(u))
    #print(dd.format(u))
    #print(d2.format(u))
    #print(d3.format(u))
    #print(d4.format(u))
        
    
y=11
jj=9
#   0               1                   2           3        4     5        6         7             8           9           10          11      12
z=["read_address","write_address","read_data","write_data","we","temp","temp_out","k_stream1","k_stream2","k_stream3","k_stream4","init_data","in_speed"]
op=["thisux","thisuy","this_rho","one9thrho","one36thrho","ux3","uy3","m45ux2","m45uy2","uxuy2","u215","nnetemp3","nnwtemp3","nsetemp3","nswtemp3"]
c=["n0","nN","nS","nW","nE","nNW","nNE","nSW","nSE","ux","uy"]
kj=["n0","nn","ns","nw","ne","nnw","nne","nsw","nse","ux","uy"]
for x in range (0,jj):
    if(1):
        g=" reg signed [26:0] {0}_temp3;"
        #fw.write(g.format(c[x]))
        #print(g.format(c[x]))
    

        
fd.close()
fw.close()
