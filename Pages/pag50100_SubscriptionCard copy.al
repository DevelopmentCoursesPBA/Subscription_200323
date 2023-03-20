page 50100 "CSD Subscription Card"
{
    Caption='Subscription';
    PageType = Card;
    SourceTable = "CSD Subscription";
    
    layout
    {
        area(Content)
        {
            group(General)
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