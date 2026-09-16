# Verilog-AMS netlisting smoke test.

set xschem_cmd [file normalize ../src/xschem]
set log_fn "verilog_ams.log"
set fd [open $log_fn w]
set failures 0
set fixture "../xschem_library/examples/vams_resistor.sch"

proc run_vams_test {name options needles} {
  global xschem_cmd fd failures fixture
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
  set netlist [file join $output_dir vams_resistor.vams]
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

run_vams_test flat {} {
  {`include "disciplines.vams"}
  {electrical vout ;}
  {ams_resistor #(.r( 1M ))}
}
run_vams_test split [list --tcl {set split_files 1}] {
  {electrical vout ;}
  {ams_resistor #(.r( 1M ))}
}

close $fd
file delete -force [file join [pwd] verilog_ams]
if {$failures} { exit 1 }
