table 50101 "CSD Customer Subscription"
{
    Caption = 'Customer Subscription';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(2; "Subscription Code"; Code[10])
        {
            Caption = 'Subscription Code';
            DataClassification = CustomerContent;
            TableRelation = "CSD Subscription";

            trigger OnValidate()
            var
                Subscription: Record "CSD Subscription";
                Item: Record item;
            begin
                if xRec."Subscription Code" <> Rec."Subscription Code" then
                    Rec.TestField("Last Invoice Date", 0D);
                if Subscription.Get("Subscription Code") then begin
                    Subscription.TestField("Invoicing Frequency");
                    Subscription.TestField("Item No.");
                    "Item No." := Subscription."Item No.";
                    if Subscription."Invoicing Price" = 0 then begin
                        Item.Get("Item No.");
                        "Invoicing Price" := item."Unit Price";
                    end else
                        "Invoicing Price" := Subscription."Invoicing Price";
                    case Subscription."Invoicing Schedule" of
                        Subscription."Invoicing Schedule"::"Beginning of Next Period":
                            "Start Date" := CalcDate('<CM+1D>', Workdate);
                        Subscription."Invoicing Schedule"::"Beginning of Period":
                            "Start Date" := CalcDate('<-CM>', Workdate);
                        Subscription."Invoicing Schedule"::"End of Period":
                            "Start Date" := CalcDate('<CM>', Workdate);
                        Subscription."Invoicing Schedule"::"Posting Date":
                            "Start Date" := Workdate;
                    end;
                    "Next Invoice Date" := "Start Date";
                end;
            end;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(5; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
            DataClassification = CustomerContent;
        }
        field(6; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            DataClassification = CustomerContent;
        }
        field(7; "Cancelled Date"; Date)
        {
            Caption = 'Cancelled Date';
            DataClassification = CustomerContent;
        }
        field(8; "Active"; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(9; "Invoicing Price"; Decimal)
        {
            Caption = 'Invoicing Price';
            DataClassification = CustomerContent;
        }
        field(10; "Allow Line Discount"; Boolean)
        {
            Caption = 'Allow Line Discount';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Subscription Code")
        {
            Clustered = true;
        }
    }

}