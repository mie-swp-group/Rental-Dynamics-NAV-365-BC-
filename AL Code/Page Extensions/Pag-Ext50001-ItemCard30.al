pageextension 50001 "SWP Item Card" extends "Item Card"
{
    layout
    {
        addafter("Description")
        {
            field("SWP RegNo"; "SWP RegNo") { }
            field("SWP Rental Item"; "SWP Rental Item") { }
            field("SWP Manufacturer"; "SWP Manufacturer") { }
            field("SWP Model"; "SWP Model") { }
            field("SWP Color"; "SWP Color") { }
            field(UnitCost; "Unit Cost") { }
            field(UnitPrice; "Unit Price") { }
            field("SWP Maintenance cost"; "SWP Maintenance cost") { }
            field("SWP Warranty Multiplier"; "SWP Warranty Multiplier") { }
            field("SWP Mileage"; "SWP Mileage") { }
            field("SWP Garage"; "SWP Garage") { }
            field("SWP Days in orders"; "SWP Days in orders") { }
            field("SWP Obtained on"; "SWP Obtained on") { }
        }
    }
    actions
    {
        addbefore(SendApprovalRequest)
        {
            action(adddatatemp)
            {
                Caption = '!!!adddatatemp!!';
                RunObject = Codeunit adddata;
            }
        }
    }
}