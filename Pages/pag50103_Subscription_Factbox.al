page 50103 "CSD Subscription Factbox"
{
    PageType = CardPart;
    SourceTable = "CSD Customer Subscription";
    Caption = 'Customer Subscription';
    Editable = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Subscription Code"; Rec."Subscription Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Visible=ShowItemField;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Visible=ShowCustomerField;
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
        ShowItemField := Rec.GetFilter("Customer No.")<>'';
        ShowCustomerField := Rec.GetFilter("Item No.")<>'';
    end;

    var
        ShowItemField: Boolean;
        ShowCustomerField: Boolean;

}