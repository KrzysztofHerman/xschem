v {xschem version=3.4.8 file_version=1.2
* Verilog-AMS structural netlisting example.
}
G {}
V {}
S {}
E {}
C {verilog_preprocessor.sym} 100 220 0 0 {name=s1 string="`include \\\"disciplines.vams\\\""}
C {ipin.sym} 300 -100 1 0 {name=p1 lab=vin verilog_type=electrical}
C {res.sym} 300 0 0 0 {name=R1 value=1M}
C {opin.sym} 300 100 3 0 {name=p2 lab=vout verilog_type=electrical}
N 300 -100 300 -30 {}
N 300 30 300 100 {}
T {The ams_resistor model is supplied in vams_resistor.vams} 120 260 0 0 0.4 0.4 {}
