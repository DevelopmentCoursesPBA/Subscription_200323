pageextension 50104 "CSD Item List" extends "Item List"
{
    layout
    {
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
                RunObject = page "CSD Customer Subscriptions";
                RunPageLink = "Item No." = field("No.");
                ApplicationArea = All;
                Image = InsuranceRegisters;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}