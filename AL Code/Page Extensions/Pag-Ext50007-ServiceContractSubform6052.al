pageextension 50007 "SWP Service Contract Subform" extends "Service Contract Subform"
{
    layout
    {
        addafter("Line Cost")
        {
            field("SWP Warranty Price"; "SWP Warranty Price") { }
            field("SWP Line Discount %"; "SWP Line Discount %") { }
            field("SWP Line Maintenance Cost"; "SWP Line Maintenance Cost") { }
            field("SWP Line Price"; "SWP Line Price") { }
            field("SWP CarPrice"; "SWP CarPrice") { }

        }
        modify("Item No.")
        {
            Editable = false;
        }
        modify("Response Time (Hours)")
        {
            Visible = false;
        }
        modify("Line Cost")
        {
            Visible = false;
        }
        modify("Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Serial No.")
        {
            Visible = false;
        }
        modify("Starting Date")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Profit")
        {
            Visible = false;
        }
        addafter(Profit)
        {
            field("SWP Starting Date"; "SWP Starting Date")
            {
                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                    //SaveRecord();
                end;
            }
        }
        modify("Contract Expiration Date")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update(true);
                //SaveRecord();
            end;
        }
        modify("Next Planned Service Date")
        {
            Visible = false;
        }
        modify("Service Period")
        {
            visible = false;
        }
        modify("Credit Memo Date")
        {
            Visible = false;
        }
        modify("New Line")
        {
            Visible = false;
        }
    }
    actions
    {

    }

    trigger OnModifyRecord(): Boolean
    begin
        //Rec.ValidateLinesAmountsWithDiscounts(Rec."Contract Type", Rec."Contract No.");
        //Rec.ValidateServicePeriod();
        //CurrPage.Update(true);
    end;
}