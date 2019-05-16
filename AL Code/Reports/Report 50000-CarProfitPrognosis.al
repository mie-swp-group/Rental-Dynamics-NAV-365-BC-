report 50000 "SWP Car Profit Prognosis"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Car Profit Prognosis';
    //RDLCLayout = '../Reports/SWP Car Profit Prognosis.rdl';
    RDLCLayout = 'SWP Car Profit Prognosis.rdl';

    dataset
    {
        dataitem(DataItemName; Item)
        {
            column(No; "No.")
            {

            }
            column(CarRegNo; "SWP RegNo")
            { }
            column(Manufacturer; "SWP Manufacturer")
            { }
            column(Model; "SWP Model")
            { }
            column(Mileage; "SWP Mileage")
            { }
            column(UnitPrice; "Unit Price")
            { }
            column(UnitCost; "Unit Cost")
            { }
        }
    }


    var
        myInt: Integer;
}