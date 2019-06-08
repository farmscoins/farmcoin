#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

FARMCOIND=${FARMCOIND:-$BINDIR/farmcoind}
FARMCOINCLI=${FARMCOINCLI:-$BINDIR/farmcoin-cli}
FARMCOINTX=${FARMCOINTX:-$BINDIR/farmcoin-tx}
FARMCOINQT=${FARMCOINQT:-$BINDIR/qt/farmcoin-qt}

[ ! -x $FARMCOIND ] && echo "$FARMCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
FMCVER=($($FARMCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for farmcoind if --version-string is not set,
# but has different outcomes for farmcoin-qt and farmcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$FARMCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $FARMCOIND $FARMCOINCLI $FARMCOINTX $FARMCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${FMCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${FMCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
