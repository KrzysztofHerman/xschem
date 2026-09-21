v {xschem version=3.4.8 file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 0 -120 0 -80 {lab=net_vdd}
N 0 80 0 120 {lab=net1}
N -170 -25 -120 -25 {lab=net_nck}
N -170 25 -120 25 {lab=net_ck}
N 120 -25 170 -25 {lab=net_in}
N 120 25 170 25 {lab=net_out}
C {b_switch_text.sym} 0 0 0 0 {name=U1}
C {iopin.sym} 0 -120 1 0 {name=p1 lab=net_vdd sig_type=electrical}
C {iopin.sym} 0 120 3 0 {name=p2 lab=net1 sig_type=electrical}
C {ipin.sym} -170 -25 0 1 {name=p3 lab=net_nck sig_type=logic}
C {ipin.sym} -170 25 0 1 {name=p4 lab=net_ck sig_type=logic}
C {ipin.sym} 170 -25 0 0 {name=p5 lab=net_in sig_type=electrical}
C {opin.sym} 170 25 0 0 {name=p6 lab=net_out sig_type=electrical}
