//
//  InvoiceModel.swift
//  Fynoo Business
//
//  Created by IND-SEN-LP-060 on 30/11/21.
//  Copyright © 2021 Sendan. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let error: Bool
    let errorCode: Int
    let errorDescription: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case error
        case errorCode = "error_code"
        case errorDescription = "error_description"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let pageLimit, totalRecords: Int
    let txnList: [TxnList]

    enum CodingKeys: String, CodingKey {
        case pageLimit = "page_limit"
        case totalRecords = "total_records"
        case txnList = "txn_list"
    }
}

// MARK: - TxnList
struct TxnList: Codable {
    let id, txnUserID: Int
    let fynooID: String
    let txnTransID, txnOrderID: String
    let txnInvoiceFor: Int
    let txnEntryType: Int
    let txnCurrency: String
    let txnAmount, txnRemarks, txnRejectionReason, txnTransferNote: String
    let txnDate, txnRejectDate, txnTransferredDate, txnStatus: String
    let txnDRCRFlag: String
    let txnType: String

    enum CodingKeys: String, CodingKey {
        case id
        case txnUserID = "txn_user_id"
        case fynooID = "fynoo_id"
        case txnTransID = "txn_trans_id"
        case txnOrderID = "txn_order_id"
        case txnInvoiceFor = "txn_invoice_for"
        case txnEntryType = "txn_entry_type"
        case txnCurrency = "txn_currency"
        case txnAmount = "txn_amount"
        case txnRemarks = "txn_remarks"
        case txnRejectionReason = "txn_rejection_reason"
        case txnTransferNote = "txn_transfer_note"
        case txnDate = "txn_date"
        case txnRejectDate = "txn_reject_date"
        case txnTransferredDate = "txn_transferred_date"
        case txnStatus = "txn_status"
        case txnDRCRFlag = "txn_dr_cr_flag"
        case txnType = "txn_type"
    }
}

//enum FynooID: String, Codable {
//    case fybo1614060471 = "FYBO1614060471"
//}
//
//enum TxnCurrency: String, Codable {
//    case sar = "SAR"
//}
//
//enum TxnDRCRFlag: String, Codable {
//    case c = "C"
//    case d = "D"
//}
//
