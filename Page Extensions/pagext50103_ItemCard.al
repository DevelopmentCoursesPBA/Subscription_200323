pageextension 50103 "CSD Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("CSD Subscription Item"; Rec."CSD Subscription Item")
            {
                ApplicationArea = All;
            }
        }
        addfirst(factboxes)
        {
            part("Subscription"; "CSD Subscription Factbox")
            {
                SubPageLink = "Item No." = field("No.");
            }
        }
    }

    actions
    {
        addlast(navigation)
        {
            action(Subscriptions)
            {
                Caption = 'Subscription';
                RunObject = page "CSD Subscription Factbox";
                RunPageLink = "Item No." = field("No.");
                ApplicationArea = All;
                Image = InsuranceRegisters;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}