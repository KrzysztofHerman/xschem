# Verilog-AMS netlisting smoke test.

set xschem_cmd [file normalize ../src/xschem]
set log_fn "verilog_ams.log"
set fd [open $log_fn w]
set failures 0

proc run_vams_test {name fixture netlist_name options needles} {
  global xschem_cmd fd failures
  set output_dir [file join [pwd] verilog_ams $name]
  file mkdir $output_dir
  set cmd [list $xschem_cmd -q -x -r --verilog-ams]
  lappend cmd {*}$options
  lappend cmd -o $output_dir -n $fixture
  lappend cmd 2>@1
  if {[catch {exec {*}$cmd} message result]} {
    set error_code [dict get $result -errorcode]
    if {[regexp {^CHILDSTATUS.* 10$} $error_code]} {
      set message {}
    } else {
      puts $fd "$name: FATAL: $message"
      incr failures
      return
    }
  }
  set netlist [file join $output_dir $netlist_name]
  if {![file exists $netlist]} {
    puts $fd "$name: FATAL: missing $netlist"
    incr failures
    return
  }
  set net_fd [open $netlist r]
  set contents [read $net_fd]
  close $net_fd
  foreach needle $needles {
    if {[string first $needle $contents] < 0} {
      puts $fd "$name: FAIL: missing {$needle}"
      incr failures
    }
  }
  if {$failures == 0} { puts $fd "$name: PASS" }
}

proc run_vams_filter_test {} {
  global xschem_cmd fd failures
  set output_dir [file join [pwd] verilog_ams filter]
  file mkdir $output_dir
  set cmd [list $xschem_cmd -q -x -r --verilog-ams -o $output_dir -n ../xschem_library/devices/vams_filter.sch]
  lappend cmd 2>@1
  if {[catch {exec {*}$cmd} message result]} {
    set error_code [dict get $result -errorcode]
    if {![regexp {^CHILDSTATUS.* 10$} $error_code]} {
      puts $fd "filter: FATAL: $message"
      incr failures
      return
    }
  }
  set netlist [file join $output_dir vams_filter.vams]
  if {![file exists $netlist]} {
    puts $fd "filter: FATAL: missing $netlist"
    incr failures
    return
  }
  set net_fd [open $netlist r]
  set contents [read $net_fd]
  close $net_fd
  foreach needle {"ams_resistor" "vams_mixed_io  U1"} {
    if {[string first $needle $contents] < 0} {
      puts $fd "filter: FAIL: missing {$needle}"
      incr failures
    }
  }
  foreach omitted {"nmos4" "title"} {
    if {[string first $omitted $contents] >= 0} {
      puts $fd "filter: FAIL: unexpected {$omitted}"
      incr failures
    }
  }
  if {$failures == 0} { puts $fd "filter: PASS" }
}

run_vams_test flat ../xschem_library/examples/vams_resistor.sch vams_resistor.vams {} {
  {`include "disciplines.vams"}
  {electrical vout ;}
  {ams_resistor #(.r( 1M ))}
}
run_vams_test split ../xschem_library/examples/vams_resistor.sch vams_resistor.vams [list --tcl {set split_files 1}] {
  {electrical vout ;}
  {ams_resistor #(.r( 1M ))}
}

run_vams_test mixed_io ../xschem_library/devices/ams_test1.sch ams_test1.vams {} {
  {electrical net1 ;}
  {logic net2 ;}
  {electrical net3 ;}
  {module vams_mixed_io (}
  {input AIN ;}
  {electrical AIN ;}
  {output DOUT ;}
  {logic DOUT ;}
  {inout IO ;}
  {electrical IO ;}
  {ams_resistor #(.r( 1k ))}
}

run_vams_test mixed_local_net ../xschem_library/devices/vams_mixed_net.sch vams_mixed_net.vams {} {
  {wire mixed ;}
  {logic typed ;}
  {vams_mixed_io  U1}
  {vams_mixed_io  U2}
}
run_vams_test schematic_ports ../sal/b-switch.sch b-switch.vams [list --tcl {source ../sal/xschemrc}] {
  {electrical out ;}
  {electrical vdd ;}
  {electrical vss ;}
  {logic nCK ;}
  {logic CK ;}
  {electrical in ;}
  {M1 (}
  {M4 (}
  {Ma (}
}
run_vams_test text_defined ../sal/b_switch_text_test.sch b_switch_text_test.vams [list --tcl {source ../sal/xschemrc}] {
  {b_switch_text  U1}
  {.out( net_out )}
  {.vss( net1 )}
  {.CK( net_ck )}
  {.vdd( net_vdd )}
  {.in( net_in )}
  {.nCK( net_nck )}
  {b_switch_text.vams}
}
run_vams_filter_test

close $fd
file delete -force [file join [pwd] verilog_ams]
if {$failures} { exit 1 }
