page 50000 "SWP Discounts"
{
    PageType = ListPlus;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)

        {
            group(HeaderPart)
            {
                field(ShowWarrantyPrices; ShowWarrantyPrices)
                {
                    Caption = 'Show Warranty Prices';
                    trigger OnValidate()
                    begin
                        if NOT ShowWarrantyPrices then
                            EntryTypeFilter := EntryTypeFilter::"Discount by Customer Amount";
                        UpdateSubPage();
                    end;
                }
                group(EntryTypeFilterGroup)
                {
                    Visible = NOT ShowWarrantyPrices;
                    ShowCaption = false;
                    field(EntryTypeFilter; EntryTypeFilter)
                    {
                        Caption = 'Discount type:';

                        trigger OnValidate()
                        begin
                            If EntryTypeFilter = EntryTypeFilter::"Warranty Prices" then
                                ShowWarrantyPrices := True;
                            UpdateSubPage();
                        end;
                    }
                }
            }
            part(DiscountsPart; "SWP Discounts Part")
            {
                UpdatePropagation = Both;
            }
        }

    }
    local procedure UpdateSubPage()
    begin
        if ShowWarrantyPrices then begin
            EntryTypeFilter := EntryTypeFilter::"Warranty Prices";
            CurrPage.DiscountsPart.Page.SetParam(EntryTypeFilter, DaysLbl, BasePriceLbl);
        end else begin
            if EntryTypeFilter = EntryTypeFilter::"Discount by Mileage" then
                CurrPage.DiscountsPart.Page.SetParam(EntryTypeFilter, MileageLbl, DiscountPctLbl)
            else
                CurrPage.DiscountsPart.Page.SetParam(EntryTypeFilter, AmountLbl, DiscountPctLbl);
        end;

    end;

    trigger OnOpenPage()
    begin
        ShowWarrantyPrices := false;
        EntryTypeFilter := EntryTypeFilter::"Discount by Customer Amount";
        UpdateSubPage();
    end;


    var
        EntryTypeFilter: Option "Discount by Order Amount","Discount by Customer Amount","Discount by Mileage","Warranty Prices";
        ShowWarrantyPrices: Boolean;
        PriceFactorCaption: Text[30];
        PriceValueCaption: Text[30];
        DaysLbl: label 'Days';
        BasePriceLbl: label 'Base Price (UAH/day)';
        AmountLbl: label 'Amount (UAH)';
        MileageLbl: label 'Mileage (km)';
        DiscountPctLbl: label 'Discount (%)';


}