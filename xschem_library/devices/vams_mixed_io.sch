v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 90 0 110 0 {lab=IO}
N 20 0 30 0 {lab=AIN}
N 80 50 110 50 {lab=DOUT}
N 20 0 20 50 {lab=AIN}
N 0 0 20 0 {lab=AIN}
C {iopin.sym} 110 0 0 0 {name=p1 lab=IO}
C {ipin.sym} 0 0 0 0 {name=p2 lab=AIN}
C {opin.sym} 110 50 0 0 {name=p3 lab=DOUT}
C {res.sym} 60 0 1 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {adc_bridge.sym} 50 50 0 0 {name=A1 adc_bridge_model= adc_buff}
