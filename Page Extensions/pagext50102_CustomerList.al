pageextension 50102 "CSD Customer List" extends "Customer List"
{
    layout
    {
        addfirst(factboxes)
        {
            part("Subscription"; "CSD Subscription Factbox")
            {
                SubPageLink = "Customer No." = field("No.");
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
                RunPageLink = "Customer No." = field("No.");
                ApplicationArea = All;
                Image = InsuranceRegisters;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}