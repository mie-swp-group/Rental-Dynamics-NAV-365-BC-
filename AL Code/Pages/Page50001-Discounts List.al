page 50001 "SWP Discounts List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SWP Discounts";
    Caption = 'Discounts List';

    layout
    {
        area(Content)

        {

            repeater(Group1)
            {
                field("SWP Price Factor"; "SWP Price Factor")
                {
                    ApplicationArea = All;

                }
                field("SWP Price Value"; "SWP Price Value")
                {
                    ApplicationArea = All;

                }
            }
        }

    }

}