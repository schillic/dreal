CMD="-m mymodel1.xml --config myconfig1.cfg --output-file plots/mymodel1-plot.txt -v D7"
#CMD="-m timer-abstract.xml --config timer.cfg --output-file=out.txt -v=D7"
#CMD="--m timer.xml --config timer.cfg --output-file=out.txt"
# output projection on x,t
# eval memtime sspaceex $CMD -f GEN -o out.txt -a x[-1,8],t[2,3]
sspaceex $CMD  > mymodel1-screen.txt		

graph -TX -BC -q 0.5 plots/mymodel1-plot.txt
graph -T "ps" -BC -q 0.5 plots/mymodel1-plot.txt > plots/mymodel1-plot.ps
ps2eps -l -B -s b0 -c -n -f plots/mymodel1-plot.ps
ps2pdf -dEPSCrop plots/mymodel1-plot.ps


# output jvx
# eval memtime sspaceex $CMD -f JVX -o out.jvx
