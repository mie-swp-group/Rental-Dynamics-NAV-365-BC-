page 50002 "SWP Discounts Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SWP Discounts";
    Caption = 'Lines';

    layout
    {
        area(Content)

        {

            repeater(Group1)
            {
                field("SWP Entry No."; "SWP Entry No.")
                {
                    ApplicationArea = All;
                }
                field("SWP Entry Type"; "SWP Entry Type")
                {
                    ApplicationArea = All;
                }
                field("SWP Price Factor"; "SWP Price Factor")
                {
                    ApplicationArea = All;
                    CaptionClass = '1,5,,' + PriceFactorCaption;
                }
                field("SWP Price Value"; "SWP Price Value")
                {
                    ApplicationArea = All;
                    CaptionClass = '1,5,,' + PriceValueCaption;
                }
            }
        }

    }


    trigger OnNewRecord(BelowXrec: Boolean)
    begin
        "SWP Entry Type" := EntryTypeFilter;
    end;

    procedure SetParam(EntryTypeFilterParam: Option; PriceFactorCaptionParam: Text[30]; PriceValueCaptionParam: Text[30])
    begin
        EntryTypeFilter := EntryTypeFilterParam;
        PriceFactorCaption := PriceFactorCaptionParam;
        PriceValueCaption := PriceValueCaptionParam;
        FilterGroup(2);
        SetRange("SWP Entry Type", EntryTypeFilter);
        FilterGroup(0);
        CurrPage.UPDATE(FALSE);
    end;

    var
        PriceFactorCaption: Text[30];
        PriceValueCaption: Text[30];
        EntryTypeFilter: Option;
}