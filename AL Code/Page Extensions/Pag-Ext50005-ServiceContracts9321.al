pageextension 50005 "SWP Service Contracts" extends "Service Contracts"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Reporting)
        {
            action(CarProfitPrognosisReport)
            {
                ApplicationArea = All;
                Caption = 'Car Profit Prognosis report';
                RunObject = report "SWP Car Profit Prognosis";
                Promoted = true;
                PromotedCategory = Process;
                Image = Report;
            }
        }
        addafter("&Gain/Loss Entries")
        {
            action(SWPDiscounts)
            {
                ApplicationArea = All;
                Caption = 'Rental Discounts';
                RunObject = page "SWP Discounts";
                Promoted = true;
                PromotedCategory = Process;
                Image = Price;
            }
        }
    }


}