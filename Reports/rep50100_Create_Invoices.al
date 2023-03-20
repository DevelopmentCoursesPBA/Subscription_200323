report 50100 "CSD Create Invoices"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Create Subscription Invoices';
    ProcessingOnly = true;

    dataset
    {
        dataitem("CustSubscription"; "CSD Customer Subscription")
        {
            RequestFilterFields = "Customer No.", "Subscription Code";
            DataItemTableView = where(Active = const(true));

            trigger OnPreDataItem()
            var
                CreateWarningTxt: Label 'Create Invoices for all active subscriptions';

            begin
                if not Confirm(CreateWarningTxt) then
                    CurrReport.Quit();
                CustSubscription.SetFilter("Next Invoice Date", '<=%1', WorkDate());
            end;

            trigger OnAfterGetRecord()
            var
                OldCustomerNo: Code[20];
                OldInvoicingDate: Date;
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
                NextLineNo: Integer;
                StartingDate: Date;
                EndingDate: date;
                Subscription: Record "CSD Subscription";
                CoverPeriodTxt: Label 'Subscription covering the period %1 to %2';
            begin
                //Test if the invoice has already been made
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", SalesLine."Document Type"::Invoice);
                SalesLine.SetRange("Sell-to Customer No.", CustSubscription."Customer No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("No.", CustSubscription."Item No.");
                SalesLine.SetRange("Posting Date", CustSubscription."Next Invoice Date");
                if not SalesLine.IsEmpty() then
                    CurrReport.Skip();

                //Create the invoice
                if (OldCustomerNo <> CustSubscription."Customer No.") or (OldInvoicingDate <> "Next Invoice Date") then begin
                    //Create Incoice Header 
                    OldInvoicingDate := CustSubscription."Next Invoice Date";
                    OldCustomerNo := CustSubscription."Customer No.";
                    SalesHeader.Init();
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                    SalesHeader.Insert(true);
                    SalesHeader.Validate("Sell-to Customer No.", CustSubscription."Customer No.");
                    SalesHeader.Validate("Location Code", '');
                    SalesHeader.Validate("Document Date", CustSubscription."Next Invoice Date");
                    SalesHeader.Validate("Posting Date", CustSubscription."Next Invoice Date");
                    SalesHeader.Modify(true);
                    NextLineNo := 0;
                    InvoiceCounter += 1;
                end;
                //Create Invoice Lines
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                NextLineNo += 10000;
                SalesLine."Line No." := NextLineNo;
                SalesLine.Validate("Sell-to Customer No.", CustSubscription."Customer No.");
                SalesLine.Insert(true);
                SalesLine.Type := SalesLine.Type::Item;
                SalesLine.Validate("No.", CustSubscription."Item No.");
                SalesLine.Validate(Quantity, 1);
                SalesLine.Validate("Allow Line Disc.", CustSubscription."Allow Line Discount");
                SalesLine.Validate("Unit Price", CustSubscription."Invoicing Price");
                SalesLine.Modify();
                SalesLine.Init();
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                NextLineNo += 10000;
                SalesLine."Line No." := NextLineNo;
                SalesLine.Validate("Sell-to Customer No.", CustSubscription."Customer No.");
                SalesLine.Insert(true);
                SalesLine.Type := SalesLine.Type::" ";
                Subscription.Get(CustSubscription."Subscription Code");
                StartingDate := CalcDate('<+1D>', CustSubscription."Next Invoice Date");
                EndingDate := CalcDate(Subscription."Invoicing Frequency", "Next Invoice Date") - 1;
                SalesLine.Description := StrSubstNo(CoverPeriodTxt, StartingDate, EndingDate);
                SalesLine.Modify();
            end;

            trigger OnPostDataItem()
            var
                InvCounterTxt: label 'Total No. of Invoices created %1', comment = '%1 is No. of invoices';
            begin
                Message(InvCounterTxt, InvoiceCounter);
            end;
        }
    }

    var
        InvoiceCounter: Integer;
}