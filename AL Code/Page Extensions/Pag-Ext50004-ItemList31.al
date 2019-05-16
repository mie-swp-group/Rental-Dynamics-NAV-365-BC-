pageextension 50004 "SWP Item List" extends "Item List"
{
    layout
    {
        modify(Inventory)
        {
            Visible = false;
        }
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        addafter("Description")
        {
            field("SWP RegNo"; "SWP RegNo")
            {

            }
            field("SWP Manufacturer"; "SWP Manufacturer")
            {

            }
            field("SWP Model"; "SWP Model")
            {

            }
            field("SWP Color"; "SWP Color")
            {

            }
            field("SWP Maintenance cost"; "SWP Maintenance cost")
            {

            }
            field("SWP Warranty Multiplier"; "SWP Warranty Multiplier")
            {

            }
            field("SWP Mileage"; "SWP Mileage")
            {

            }
            field("SWP Garage"; "SWP Garage")
            {

            }
            field("SWP Days in orders"; "SWP Days in orders")
            {

            }
            field("SWP Obtained on"; "SWP Obtained on")
            {

            }
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