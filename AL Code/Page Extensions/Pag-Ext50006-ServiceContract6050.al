pageextension 50006 "SWP Service Contract" extends "Service Contract"
{
    layout
    {
        addafter("Contact No.")
        {
            field("SWP Order Undiscounted Amount"; "SWP Order Undiscounted Amount") { }
            field("SWP Order Amount Discount %"; "SWP Order Amount Discount %") { }
            field("SWP Customer Discount %"; "SWP Customer Discount %") { }
            field("SWP Common Car Discount %"; "SWP Common Car Discount %") { }
            field("SWP Total Discount %"; "SWP Total Discount %") { }
        }
    }

    actions
    {
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
    }


}