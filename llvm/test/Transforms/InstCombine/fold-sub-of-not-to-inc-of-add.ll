; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instcombine -S < %s | FileCheck %s

; Given:
;   sub %y, (xor %x, -1)
; Transform it to:
;   add (add %x, 1), %y
; We prefer this form because that is what -reassociate would produce.

;------------------------------------------------------------------------------;
; Scalar tests
;------------------------------------------------------------------------------;

define i32 @p0_scalar(i32 %x, i32 %y) {
; CHECK-LABEL: @p0_scalar(
; CHECK-NEXT:    [[T0_NEG:%.*]] = add i32 [[X:%.*]], 1
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[T0_NEG]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = xor i32 %x, -1
  %t1 = sub i32 %y, %t0
  ret i32 %t1
}

;------------------------------------------------------------------------------;
; Vector tests
;------------------------------------------------------------------------------;

define <4 x i32> @p1_vector_splat(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @p1_vector_splat(
; CHECK-NEXT:    [[T0_NEG:%.*]] = add <4 x i32> [[X:%.*]], <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[T0_NEG]], [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = xor <4 x i32> %x, <i32 -1, i32 -1, i32 -1, i32 -1>
  %t1 = sub <4 x i32> %y, %t0
  ret <4 x i32> %t1
}

define <4 x i32> @p2_vector_undef(<4 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @p2_vector_undef(
; CHECK-NEXT:    [[T0_NEG:%.*]] = add <4 x i32> [[X:%.*]], <i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[T1:%.*]] = add <4 x i32> [[T0_NEG]], [[Y:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[T1]]
;
  %t0 = xor <4 x i32> %x, <i32 -1, i32 -1, i32 undef, i32 -1>
  %t1 = sub <4 x i32> %y, %t0
  ret <4 x i32> %t1
}

;------------------------------------------------------------------------------;
; One-use test
;------------------------------------------------------------------------------;

declare void @use32(i32)

define i32 @p3_oneuse(i32 %x, i32 %y) {
; CHECK-LABEL: @p3_oneuse(
; CHECK-NEXT:    [[T0:%.*]] = xor i32 [[X:%.*]], -1
; CHECK-NEXT:    call void @use32(i32 [[T0]])
; CHECK-NEXT:    [[T1:%.*]] = sub i32 [[Y:%.*]], [[T0]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = xor i32 %x, -1
  call void @use32(i32 %t0)
  %t1 = sub i32 %y, %t0
  ret i32 %t1
}

;------------------------------------------------------------------------------;
; Basic negative tests
;------------------------------------------------------------------------------;

; The `sub` (and the fold) is not commutative.
define i32 @n4(i32 %x, i32 %y) {
; CHECK-LABEL: @n4(
; CHECK-NEXT:    [[T0:%.*]] = xor i32 [[X:%.*]], -1
; CHECK-NEXT:    [[T1:%.*]] = sub i32 [[T0]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = xor i32 %x, -1
  %t1 = sub i32 %t0, %y ; swapped
  ret i32 %t1
}

define i32 @n5_is_not_not(i32 %x, i32 %y) {
; CHECK-LABEL: @n5_is_not_not(
; CHECK-NEXT:    [[T0_NEG:%.*]] = add i32 [[X:%.*]], -2147483647
; CHECK-NEXT:    [[T1:%.*]] = add i32 [[T0_NEG]], [[Y:%.*]]
; CHECK-NEXT:    ret i32 [[T1]]
;
  %t0 = xor i32 %x, 2147483647 ; not -1
  %t1 = sub i32 %y, %t0
  ret i32 %t1
}
