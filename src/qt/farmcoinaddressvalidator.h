// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef FARMCOIN_QT_FARMCOINADDRESSVALIDATOR_H
#define FARMCOIN_QT_FARMCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class FarmcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit FarmcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Farmcoin address widget validator, checks for a valid farmcoin address.
 */
class FarmcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit FarmcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // FARMCOIN_QT_FARMCOINADDRESSVALIDATOR_H
