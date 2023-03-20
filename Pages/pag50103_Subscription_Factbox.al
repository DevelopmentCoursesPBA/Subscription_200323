page 50103 "CSD Subscription Factbox"
{
    PageType = ListPart;
    SourceTable = "CSD Customer Subscription";
    Caption = 'Customer Subscription';
    Editable = false;

    layout
    {
        area(Content)
        {
            Repeater(GroupName)
            {
                field("Subscription Code"; Rec."Subscription Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Enabled = ShowItemField;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Enabled = ShowCustomerField;
                }
                field("Cancelled Date"; Rec."Cancelled Date")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    trigger OnOpenPage()
    begin
        ShowItemField := Rec.GetFilter("Customer No.") <> '';
        ShowCustomerField := Rec.GetFilter("Item No.") <> '';
    end;

    var
        ShowItemField: Boolean;
        ShowCustomerField: Boolean;

}