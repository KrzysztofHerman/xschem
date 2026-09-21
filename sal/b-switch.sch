v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1130 -790 1230 -790 {lab=xxx}
N 970 -930 970 -910 {lab=#net1}
N 970 -850 970 -790 {lab=xxx}
N 850 -790 970 -790 {lab=xxx}
N 1130 -850 1130 -790 {lab=xxx}
N 970 -790 1130 -790 {lab=xxx}
N 970 -930 1130 -930 {lab=#net1}
N 970 -950 970 -930 {lab=#net1}
N 1130 -930 1130 -910 {lab=#net1}
N 1170 -880 1260 -880 {lab=#net2}
N 1260 -880 1260 -830 {lab=#net2}
N 1130 -930 1260 -930 {lab=#net1}
N 1260 -1040 1260 -930 {lab=#net1}
N 1200 -1080 1230 -1080 {lab=#net3}
N 1330 -710 1400 -710 {lab=in}
N 1290 -790 1330 -790 {lab=in}
N 1330 -790 1330 -710 {lab=in}
N 1170 -710 1330 -710 {lab=in}
N 1260 -880 1430 -880 {lab=#net2}
N 1430 -880 1430 -750 {lab=#net2}
N 1430 -1080 1500 -1080 {lab=#net2}
N 1430 -1080 1430 -880 {lab=#net2}
N 1290 -1080 1430 -1080 {lab=#net2}
N 670 -1160 670 -1120 {lab=#net2}
N 670 -1160 1430 -1160 {lab=#net2}
N 1430 -1160 1430 -1080 {lab=#net2}
N 1560 -1080 1620 -1080 {lab=#net4}
N 1680 -1080 1710 -1080 {lab=vss}
N 1530 -1190 1530 -1120 {lab=vdd}
N 970 -1190 1530 -1190 {lab=vdd}
N 620 -1080 640 -1080 {lab=vdd}
N 620 -1190 620 -1080 {lab=vdd}
N 590 -1190 620 -1190 {lab=vdd}
N 970 -1040 970 -1010 {lab=vdd}
N 620 -1190 970 -1190 {lab=vdd}
N 920 -880 930 -880 {lab=nCK}
N 920 -980 920 -880 {lab=nCK}
N 920 -980 930 -980 {lab=nCK}
N 780 -1080 780 -960 {lab=#net3}
N 720 -1080 780 -1080 {lab=#net3}
N 780 -900 780 -790 {lab=xxx}
N 700 -790 780 -790 {lab=xxx}
N 670 -850 670 -830 {lab=CK}
N 590 -850 670 -850 {lab=CK}
N 610 -790 640 -790 {lab=vss}
N 590 -880 920 -880 {lab=nCK}
N 1460 -710 1580 -710 {lab=out}
N 670 -1080 670 -1040 {lab=#net3}
N 670 -1040 720 -1040 {lab=#net3}
N 720 -1080 720 -1040 {lab=#net3}
N 700 -1080 720 -1080 {lab=#net3}
N 1260 -1130 1260 -1080 {lab=#net3}
N 1200 -1130 1260 -1130 {lab=#net3}
N 1200 -1130 1200 -1080 {lab=#net3}
N 780 -1080 1200 -1080 {lab=#net3}
N 970 -980 1020 -980 {lab=vdd}
N 1020 -1040 1020 -980 {lab=vdd}
N 970 -1040 1020 -1040 {lab=vdd}
N 970 -1190 970 -1040 {lab=vdd}
N 1050 -880 1130 -880 {lab=vss}
N 1050 -880 1050 -650 {lab=vss}
N 970 -880 1050 -880 {lab=vss}
N 610 -790 610 -650 {lab=vss}
N 590 -790 610 -790 {lab=vss}
N 1430 -710 1430 -650 {lab=vss}
N 670 -650 1050 -650 {lab=vss}
N 1260 -790 1260 -650 {lab=vss}
N 1050 -650 1260 -650 {lab=vss}
N 670 -790 670 -650 {lab=vss}
N 610 -650 670 -650 {lab=vss}
N 1650 -1150 1650 -1120 {lab=CK}
N 1710 -1020 1710 -650 {lab=vss}
N 1430 -650 1710 -650 {lab=vss}
N 1260 -650 1430 -650 {lab=vss}
N 1650 -1080 1650 -1020 {lab=vss}
N 1650 -1020 1710 -1020 {lab=vss}
N 1710 -1080 1710 -1020 {lab=vss}
N 1530 -1080 1530 -1020 {lab=vss}
N 1530 -1020 1650 -1020 {lab=vss}
N 850 -790 850 -760 {lab=xxx}
N 780 -790 850 -790 {lab=xxx}
C {sg13g2_pr/sg13_hv_nmos.sym} 1430 -730 1 0 {name=M1
l=0.45u
w=20u
ng=10
m=1
mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 1260 -1060 3 0 {name=M2
l=0.4u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 1260 -810 1 0 {name=M3
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 1650 -1100 3 1 {name=M4
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 670 -1100 3 1 {name=M5
l=0.4u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 670 -810 1 0 {name=M6
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 950 -880 0 0 {name=Ma
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 950 -980 0 0 {name=Mb
l=0.4u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 1150 -880 0 1 {name=Ma1
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 1530 -1100 3 1 {name=M8
l=0.45u
w=0.3u
 ng=1
 m=1
  mm_ok=1
 model=sg13_hv_nmos
spiceprefix=X
}
C {title-3.sym} 0 0 0 0 {name=l1 author="IHP Open PDK Authors 2026" rev=1.0 lock=true title="Bootstrapped Switch"}
C {iopin.sym} 590 -1190 0 1 {name=p1 lab=vdd sig_type=electrical}
C {ipin.sym} 590 -880 0 0 {name=p2 lab=nCK sig_type=logic}
C {opin.sym} 1580 -710 0 0 {name=p3 lab=out sig_type=electrical}
C {sg13g2_pr/cap_cmim.sym} 780 -930 0 0 {name=C1
model=cap_cmim
 w=7.0e-6
 l=7.0e-6
 m=1
  mm_ok=1
 spiceprefix=X}
C {iopin.sym} 590 -790 0 1 {name=p4 lab=vss sig_type=electrical}
C {ipin.sym} 590 -850 0 0 {name=p5 lab=CK sig_type=logic}
C {ipin.sym} 1170 -710 0 0 {name=p6 lab=in sig_type=electrical}
C {lab_pin.sym} 1650 -1150 0 0 {name=p7 sig_type=logic lab=CK}
C {lab_pin.sym} 850 -760 0 0 {name=p8 sig_type=electrical lab=net4}
