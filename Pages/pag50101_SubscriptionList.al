page 50101 "CSD Subscription List"
{
    Caption='Subscription list';
    PageType = List;
    SourceTable = "CSD Subscription";
    Editable=false;
    ApplicationArea=all;
    UsageCategory=Lists;
    CardPageId="CSD Subscription Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Caption='General';
                field(Code;Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name;Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Item No.";Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Invoicing Schedule";Rec."Invoicing Schedule")
                {
                    ApplicationArea = All;
                }
                field("Invoicing Frequency";Rec."Invoicing Frequency")
                {
                    ApplicationArea = All;
                }
                field("Invoicing Price";Rec."Invoicing Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}