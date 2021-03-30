//===-- XtensaMCTargetDesc.cpp - Xtebsa target descriptions ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
#include "XtensaMCTargetDesc.h"
#include "XtensaInstPrinter.h"
#include "XtensaMCAsmInfo.h"
#include "llvm/MC/MCDwarf.h"
#include "XtensaTargetStreamer.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

#define GET_INSTRINFO_MC_DESC
#include "XtensaGenInstrInfo.inc"

#define GET_REGINFO_MC_DESC
#include "XtensaGenRegisterInfo.inc"

#define GET_SUBTARGETINFO_MC_DESC
#include "XtensaGenSubtargetInfo.inc"

using namespace llvm;

static MCAsmInfo *createXtensaMCAsmInfo(const MCRegisterInfo &MRI,
                                        const Triple &TT,
                                        const MCTargetOptions &Options) {
  MCAsmInfo *MAI = new XtensaMCAsmInfo(TT);
  MCCFIInstruction Inst = MCCFIInstruction::cfiDefCfa(
      nullptr, MRI.getDwarfRegNum(Xtensa::SP, true), 0);
  MAI->addInitialFrameState(Inst);
  return MAI;
}

static MCInstrInfo *createXtensaMCInstrInfo() {
  MCInstrInfo *X = new MCInstrInfo();
  InitXtensaMCInstrInfo(X);
  return X;
}

static MCInstPrinter *createXtensaMCInstPrinter(const Triple &TT,
                                                unsigned SyntaxVariant,
                                                const MCAsmInfo &MAI,
                                                const MCInstrInfo &MII,
                                                const MCRegisterInfo &MRI) {
  return new XtensaInstPrinter(MAI, MII, MRI);
}

static MCRegisterInfo *createXtensaMCRegisterInfo(const Triple &TT) {
  MCRegisterInfo *X = new MCRegisterInfo();
  InitXtensaMCRegisterInfo(X, Xtensa::SP);
  return X;
}

static MCSubtargetInfo *
createXtensaMCSubtargetInfo(const Triple &TT, StringRef CPU, StringRef FS) {
  return createXtensaMCSubtargetInfoImpl(TT, CPU, FS);
}

static MCTargetStreamer *
createXtensaAsmTargetStreamer(MCStreamer &S, formatted_raw_ostream &OS,
                              MCInstPrinter *InstPrint, bool isVerboseAsm) {
  return new XtensaTargetAsmStreamer(S, OS);
}

static MCTargetStreamer *
createXtensaObjectTargetStreamer(MCStreamer &S, const MCSubtargetInfo &STI) {
  return new XtensaTargetELFStreamer(S);
}

extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeXtensaTargetMC() {
  // Register the MCAsmInfo.
  TargetRegistry::RegisterMCAsmInfo(TheXtensaTarget, createXtensaMCAsmInfo);

  // Register the MCCodeEmitter.
  TargetRegistry::RegisterMCCodeEmitter(TheXtensaTarget,
                                        createXtensaMCCodeEmitter);

  // Register the MCInstrInfo.
  TargetRegistry::RegisterMCInstrInfo(TheXtensaTarget, createXtensaMCInstrInfo);

  // Register the MCInstPrinter.
  TargetRegistry::RegisterMCInstPrinter(TheXtensaTarget,
                                        createXtensaMCInstPrinter);

  // Register the MCRegisterInfo.
  TargetRegistry::RegisterMCRegInfo(TheXtensaTarget,
                                    createXtensaMCRegisterInfo);

  // Register the MCSubtargetInfo.
  TargetRegistry::RegisterMCSubtargetInfo(TheXtensaTarget,
                                          createXtensaMCSubtargetInfo);

  // Register the MCAsmBackend.
  TargetRegistry::RegisterMCAsmBackend(TheXtensaTarget,
                                       createXtensaMCAsmBackend);

  // Register the asm target streamer.
  TargetRegistry::RegisterAsmTargetStreamer(TheXtensaTarget,
                                            createXtensaAsmTargetStreamer);

  // Register the ELF target streamer.
  TargetRegistry::RegisterObjectTargetStreamer(
      TheXtensaTarget, createXtensaObjectTargetStreamer);
}
