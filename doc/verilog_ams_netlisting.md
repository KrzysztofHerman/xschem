# Verilog-AMS schematic netlisting

## Codebase analysis and design

Reference: Accellera **VAMS-2023**, dated February 14, 2024, in
`VAMS-LRM-2023.pdf`. Section numbers below refer to the LRM; its printed
page numbers start 13 pages after the PDF page numbers.

Xschem's netlisting architecture has four relevant layers:

| Layer | Implementation | Role |
| --- | --- | --- |
| Selection and dispatch | `src/options.c`, `src/scheduler.c`, `src/xinit.c`, `src/callback.c`, `src/xschem.tcl` | CLI, Tcl, GUI, netlist file names |
| Connectivity | `src/netlist.c`, `src/node_hash.c` | Wire/pin connectivity, labels, unnamed nets, port directions, net types, ERC |
| Hierarchy and emission | `src/verilog_netlist.c`, `src/token.c` | Module definitions, symbol parameters, named port maps, format templates, hierarchy traversal |
| Postprocessing | `src/verilog.awk`, Tcl `netlist` | Instance expansion, bus declarations and connections, final output |

The existing Verilog backend is the appropriate foundation. It already supports
hierarchy, instance arrays, parameters, embedded definitions (`verilog_sym_def`),
external modules (`verilog_primitive`), and behavioral text. However, its AWK
postprocessor recognizes a fixed set of digital types and converts parameter
tokens using SPICE numeric conventions. In particular, that conversion can lose
expressions and based literals and does not implement AMS's case-sensitive scale
factors. Merely renaming a `.v` output to `.vams` is insufficient.

### LRM requirements relevant to a schematic netlister

| LRM reference | Consequence for generated source |
| --- | --- |
| 2.8, Annex B | Escape punctuation, numeric identifiers, and AMS keywords; terminate escaped names with whitespace. |
| 2.6.2 | Preserve AMS numbers: `M` is mega, `m` is milli. SPICE `meg`, unit suffixes, and leading-dot reals require explicit conversion by the library author. |
| 3.4, 6.3 | Preserve constant expressions, named parameter overrides, and string parameter types. |
| 3.6.2–3.6.3, 6.5.2 | Support user-defined disciplines and matching ranges on port direction and discipline declarations. |
| 3.6.4 | Ground is a declared continuous net, not a digital constant. |
| 3.7, 6.5.3 | `wreal` is a discrete real-valued net; `real` is a variable and is not a substitute for an electrical node. |
| 6.2, 6.5 | Emit separate module definitions, named connections, and correctly sized bus expressions. |
| 6.9, 7.4–7.8, Annex F | Preserve hierarchy and explicit net disciplines. The simulator resolves neutral interconnect and inserts connect modules after elaboration. |
| 5.2, 5.6 | Behavioral models supply analog contributions; structural wiring alone does not describe device equations. |
| 10.2 | `default_discipline` selects a **discrete** discipline, not a default electrical discipline. |
| Annex D | Include simulator-provided `disciplines.vams`; include `constants.vams` when models need it. |
| Annex E | SPICE primitive/model binding is simulator-dependent. Use explicit AMS templates or supplied HDL models. |

### Implementation approach

Add a `verilogams` mode using the existing Verilog connectivity and hierarchy
engine, with an AMS-aware postprocessing path and `.vams` output. Select
`verilogams_format` before `verilog_format`. Reuse `verilog_type` for explicit
net/port declarations, and retain `wire` for neutral interconnect. Reuse the
Verilog schematic property (`V`), ignore/short flags, hierarchy controls, and
parameter metadata so existing digital symbols can participate in AMS designs.

The first implementation targets structural mixed-signal netlists with supplied
behavioral models. Native simulator SPICE primitives can be instantiated through
templates following Annex E, but arbitrary SPICE device syntax and model cards
are not automatically translated. In particular, the existing resistor's digital
`tran` template needs an AMS override to represent resistance.

The simulator owns discipline compatibility/resolution, connect-rule selection,
analog equations, and scheduling. Xschem supplies explicit declarations and
includes for the selected models/connect rules. Full HDL parsing, simulator
elaboration, and automatic SPICE-to-HDL behavioral synthesis are outside this
netlisting feature.

The library example `xschem_library/examples/vams_resistor.sch` demonstrates the
contract. Its `res.sym` instance uses `verilogams_format` to instantiate the
external `ams_resistor` model, and its top-level pins use
`verilog_type=electrical`. The model is intentionally a separate `.vams` file;
the generated schematic netlist does not silently embed or invent analog device
equations.

The reusable `xschem_library/devices/vams_mixed_io.sym` symbol demonstrates a
mixed interface: `AIN` is an electrical input, `DOUT` is a logic output, and
`IO` is an electrical inout. Its `verilogams_format` emits an external module
instance while the pin `verilog_type` attributes document and propagate the
interface types when the symbol is reused as a hierarchical interface. For a
net connected to an instance, put `verilog_type` on the attached top-level pin
or `lab_pin.sym` as well; that is what controls the parent net declaration.

### Verification strategy

Exercise real schematic netlisting in batch mode, covering mixed electrical and
digital ports, `wreal`, custom disciplines, buses, hierarchy, split files,
parameters, template overrides, numeric ground, and raw behavioral text. Compare
ordinary Verilog output against the pre-change executable. AMS simulation requires
a simulator supporting the constructs used by the design; a digital-only Verilog
compiler is not an AMS conformance check.
