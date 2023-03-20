pageextension 50100 "CSD Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("CSD Subscription Customer"; Rec."CSD Subscription Customer")
            {
                ApplicationArea = All;
            }
        }
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
                RunObject = page "CSD Customer Subscriptions";
                RunPageLink = "Customer No." = field("No.");
                ApplicationArea = All;
                Image = InsuranceRegisters;
                Promoted = true;
                PromotedCategory = Process;
            }
        }
    }
}