; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s 2>%t | FileCheck %s
; RUN: FileCheck --check-prefix=WARN --allow-empty %s <%t

; If this check fails please read test/CodeGen/AArch64/README for instructions on how to resolve it.
; WARN-NOT: warning

define i8 @test_lane0_16xi8(<vscale x 16 x i8> %a) {
; CHECK-LABEL: test_lane0_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, b0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 16 x i8> %a, i32 0
  ret i8 %b
}

define i16 @test_lane0_8xi16(<vscale x 8 x i16> %a) {
; CHECK-LABEL: test_lane0_8xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 8 x i16> %a, i32 0
  ret i16 %b
}

define i32 @test_lane0_4xi32(<vscale x 4 x i32> %a) {
; CHECK-LABEL: test_lane0_4xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 4 x i32> %a, i32 0
  ret i32 %b
}

define i64 @test_lane0_2xi64(<vscale x 2 x i64> %a) {
; CHECK-LABEL: test_lane0_2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 2 x i64> %a, i32 0
  ret i64 %b
}

define double @test_lane0_2xf64(<vscale x 2 x double> %a) {
; CHECK-LABEL: test_lane0_2xf64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 2 x double> %a, i32 0
  ret double %b
}

define float @test_lane0_4xf32(<vscale x 4 x float> %a) {
; CHECK-LABEL: test_lane0_4xf32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 killed $z0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 4 x float> %a, i32 0
  ret float %b
}

define half @test_lane0_8xf16(<vscale x 8 x half> %a) {
; CHECK-LABEL: test_lane0_8xf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 killed $z0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 8 x half> %a, i32 0
  ret half %b
}

define i8 @test_lanex_16xi8(<vscale x 16 x i8> %a, i32 %x) {
; CHECK-LABEL: test_lanex_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.b, xzr, x8
; CHECK-NEXT:    lastb w0, p0, z0.b
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 16 x i8> %a, i32 %x
  ret i8 %b
}

define i16 @test_lanex_8xi16(<vscale x 8 x i16> %a, i32 %x) {
; CHECK-LABEL: test_lanex_8xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.h, xzr, x8
; CHECK-NEXT:    lastb w0, p0, z0.h
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 8 x i16> %a, i32 %x
  ret i16 %b
}

define i32 @test_lanex_4xi32(<vscale x 4 x i32> %a, i32 %x) {
; CHECK-LABEL: test_lanex_4xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.s, xzr, x8
; CHECK-NEXT:    lastb w0, p0, z0.s
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 4 x i32> %a, i32 %x
  ret i32 %b
}

define i64 @test_lanex_2xi64(<vscale x 2 x i64> %a, i32 %x) {
; CHECK-LABEL: test_lanex_2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.d, xzr, x8
; CHECK-NEXT:    lastb x0, p0, z0.d
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 2 x i64> %a, i32 %x
  ret i64 %b
}

define double @test_lanex_2xf64(<vscale x 2 x double> %a, i32 %x) {
; CHECK-LABEL: test_lanex_2xf64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.d, xzr, x8
; CHECK-NEXT:    lastb d0, p0, z0.d
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 2 x double> %a, i32 %x
  ret double %b
}

define float @test_lanex_4xf32(<vscale x 4 x float> %a, i32 %x) {
; CHECK-LABEL: test_lanex_4xf32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.s, xzr, x8
; CHECK-NEXT:    lastb s0, p0, z0.s
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 4 x float> %a, i32 %x
  ret float %b
}

define half @test_lanex_8xf16(<vscale x 8 x half> %a, i32 %x) {
; CHECK-LABEL: test_lanex_8xf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sxtw x8, w0
; CHECK-NEXT:    whilels p0.h, xzr, x8
; CHECK-NEXT:    lastb h0, p0, z0.h
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 8 x half> %a, i32 %x
  ret half %b
}

; Deliberately choose an index that is out-of-bounds
define i8 @test_lane64_16xi8(<vscale x 16 x i8> %a) {
; CHECK-LABEL: test_lane64_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #64
; CHECK-NEXT:    whilels p0.b, xzr, x8
; CHECK-NEXT:    lastb w0, p0, z0.b
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 16 x i8> %a, i32 64
  ret i8 %b
}

define double @test_lane9_2xf64(<vscale x 2 x double> %a) {
; CHECK-LABEL: test_lane9_2xf64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #9
; CHECK-NEXT:    whilels p0.d, xzr, x8
; CHECK-NEXT:    lastb d0, p0, z0.d
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 2 x double> %a, i32 9
  ret double %b
}

; Deliberately choose an index that is undefined
define i32 @test_lane64_4xi32(<vscale x 4 x i32> %a) {
; CHECK-LABEL: test_lane64_4xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 4 x i32> %a, i32 undef
  ret i32 %b
}

define i8 @extract_of_insert_undef_16xi8(i8 %a) {
; CHECK-LABEL: extract_of_insert_undef_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = insertelement <vscale x 16 x i8> undef, i8 %a, i32 0
  %c = extractelement <vscale x 16 x i8> %b, i32 0
  ret i8 %c
}

define i8 @extract0_of_insert0_16xi8(<vscale x 16 x i8> %a, i8 %b) {
; CHECK-LABEL: extract0_of_insert0_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %c = insertelement <vscale x 16 x i8> %a, i8 %b, i32 0
  %d = extractelement <vscale x 16 x i8> %c, i32 0
  ret i8 %d
}

define i8 @extract64_of_insert64_16xi8(<vscale x 16 x i8> %a, i8 %b) {
; CHECK-LABEL: extract64_of_insert64_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %c = insertelement <vscale x 16 x i8> %a, i8 %b, i32 64
  %d = extractelement <vscale x 16 x i8> %c, i32 64
  ret i8 %d
}

define i8 @extract_of_insert_diff_lanes_16xi8(<vscale x 16 x i8> %a, i8 %b) {
; CHECK-LABEL: extract_of_insert_diff_lanes_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, z0.b[3]
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %c = insertelement <vscale x 16 x i8> %a, i8 %b, i32 0
  %d = extractelement <vscale x 16 x i8> %c, i32 3
  ret i8 %d
}

define i8 @test_lane0_zero_16xi8(<vscale x 16 x i8> %a) {
; CHECK-LABEL: test_lane0_zero_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %b = extractelement <vscale x 16 x i8> zeroinitializer, i32 0
  ret i8 %b
}

; The DAG combiner should fold the extract of a splat to give element zero
; of the splat, i.e. %x. If the index is beyond the end of the scalable
; vector the result is undefined anyway.
define i64 @test_lanex_splat_2xi64(i64 %x, i32 %y) {
; CHECK-LABEL: test_lanex_splat_2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %a = insertelement <vscale x 2 x i64> undef, i64 %x, i32 0
  %b = shufflevector <vscale x 2 x i64> %a, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
  %c = extractelement <vscale x 2 x i64> %b, i32 %y
  ret i64 %c
}
