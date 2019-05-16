tableextension 50004 "Service Contract Line (SWP)" extends "Service Contract Line"
{
    fields
    {
        field(50000; "SWP Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Starting Date';
            trigger OnValidate()
            begin
                CalculateLineCost();
            end;
        }

        field(50001; "SWP Warranty Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Price';
            Editable = false;
        }
        field(50002; "SWP Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Discount %';
            Editable = false;
        }
        field(50004; "SWP Line Maintenance Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'SWP Line Maintenance Cost';
            Editable = false;
        }
        field(50005; "SWP Line Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Price';
            Editable = false;
        }
        field(50006; "SWP CarPrice"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'CarPrice';
            Editable = false;
        }
        modify("Contract Expiration Date")
        {
            trigger OnBeforeValidate()
            begin
                "Credit Memo Date" := "Contract Expiration Date";
                CalculateLineCost();
            end;
        }
    }

    procedure CalculateLineCost()
    var
        Item: Record Item;
    begin
        "Starting Date" := "SWP Starting Date";
        if ValidateStartEndDates(Rec) then begin
            If Item.Get("Item No.") then;
            "SWP Warranty Price" := ValidateWarrantyPrice(Item."SWP Warranty Multiplier");
            "SWP Line Discount %" := ValidateCarMilageDiscountPct(Item."SWP Mileage");
            "SWP Line Maintenance Cost" := NumberOfDaysInLine * Item."SWP Maintenance cost";
            "SWP Line Price" := NumberOfDaysInLine * Item."Unit Price";
            modify(false);
            CalculateRentalHeader();
        end;
    end;


    // procedure ShowAllLinesNo(var ServiceContractLine: Record "Service Contract Line"): Text;
    // var
    //     ServiceContractLine2: Record "Service Contract Line";
    //     outStr: Text[240];
    // begin
    //     ServiceContractLine2.FilterGroup(10);
    //     ServiceContractLine2.CopyFilters(ServiceContractLine);
    //     ServiceContractLine2.FilterGroup(11);
    //     repeat
    //         outStr += format(ServiceContractLine2."Service Item No.") + '|';
    //     until ServiceContractLine2.next = 0;
    //     exit(outStr);
    // end;

    procedure CalculateRentalHeader()
    var
        ServiceContractHeader: Record "Service Contract Header";
        ServiceContractLine2: Record "Service Contract Line";
        OrderUndiscountedAmount: Decimal;
        MinCarDiscount: Decimal;
        OrderCarRent: Decimal;

    begin
        MinCarDiscount := "SWP Line Discount %";
        if ServiceContractHeader.Get("Contract Type", "Contract No.") then;
        with ServiceContractLine2 do begin
            SetRange("Contract Type", ServiceContractHeader."Contract Type");
            SetRange("Contract No.", ServiceContractHeader."Contract No.");
            if FindSet() then
                repeat
                    OrderUndiscountedAmount += "SWP Line Price" + "SWP Line Maintenance Cost";
                    if ("SWP Line Discount %" < MinCarDiscount) then
                        MinCarDiscount := "SWP Line Discount %";
                until next = 0;
        end;

        with ServiceContractHeader do begin
            "SWP Order Undiscounted Amount" := OrderUndiscountedAmount;
            "SWP Order Amount Discount %" := ValidateOrderDiscount("SWP Order Undiscounted Amount");
            "SWP Customer Discount %" := ValidateCustomerDiscount("Customer No.");
            "SWP Common Car Discount %" := MinCarDiscount;
            "SWP Total Discount %" := CalculateTotalDiscountPct("SWP Order Amount Discount %", "SWP Customer Discount %", "SWP Common Car Discount %");
            modify(false);
        end;

    end;

    trigger OnAfterModify()
    begin
        //ValidateLinesAmountsWithDiscounts("Contract Type", "Contract No.");
    end;

    procedure ValidateLinesAmountsWithDiscounts(ContractType: Option; ContractNo: code[20])
    var
        ServiceContractHeader: Record "Service Contract Header";
        ServiceContractLine2: Record "Service Contract Line";
        CarPrice: Decimal;
    begin
        if ServiceContractHeader.Get(ContractType, ContractNo) then;
        with ServiceContractLine2 do begin
            reset;
            SetRange("Contract Type", ContractType);
            SetRange("Contract No.", ContractNo);
            if FindSet() then begin
                repeat
                    CarPrice := "SWP Line Price" * (1 - (ServiceContractHeader."SWP Total Discount %") / 100)
                        + "SWP Line Maintenance Cost"
                        + "SWP Warranty Price";
                    "SWP CarPrice" := CarPrice;
                    "Line Value" := CarPrice;
                    validate("Line Amount", CarPrice);
                    modify(false);
                until next = 0;
                UpdateContractAnnualAmount(FALSE);
            end;
        end;
    end;

    procedure CalculateTotalDiscountPct(OrderAmountDiscount: Decimal; CustomerDiscount: Decimal; CommonCarDiscount: Decimal): Decimal;
    var
        DiscountValues: Array[3] of Decimal;
        i: Integer;
        NonZeroDiscountsQty: Integer;
        DiscountsSum: Decimal;
    begin
        DiscountValues[1] := OrderAmountDiscount;
        DiscountValues[2] := CustomerDiscount;
        DiscountValues[3] := CommonCarDiscount;

        for i := 1 to 3 do begin
            if DiscountValues[i] > 0 then
                NonZeroDiscountsQty += 1;
            DiscountsSum += DiscountValues[i];
        end;
        exit(Round(DiscountsSum / NonZeroDiscountsQty, 0.01));
    end;

    procedure ValidateCustomerDiscount(CustomerNo: Code[20]): Decimal
    var
        SWPDiscounts: Record "SWP Discounts";
        Customer: Record Customer;
    begin
        if Customer.Get(CustomerNo) then begin
            with SWPDiscounts do begin
                SetRange("SWP Entry Type", "SWP Entry Type"::"Discount by Customer Amount");
                exit(FindMinimalAppropriateDiscountValue(Customer."SWP Orders amounts", SWPDiscounts));
            end;
        end;
    end;

    procedure ValidateOrderDiscount(OrderUndiscountedAmount: Decimal): Decimal
    var
        SWPDiscounts: Record "SWP Discounts";
    begin
        with SWPDiscounts do begin
            SetRange("SWP Entry Type", "SWP Entry Type"::"Discount by Order Amount");
            exit(FindMinimalAppropriateDiscountValue(OrderUndiscountedAmount, SWPDiscounts));
        end;
    end;

    local procedure ValidateCarMilageDiscountPct(carMileage: Decimal): Decimal
    var
        SWPDiscounts: Record "SWP Discounts";
    begin
        with SWPDiscounts do begin
            SetRange("SWP Entry Type", "SWP Entry Type"::"Discount by Mileage");
            exit(FindMinimalAppropriateDiscountValue(carMileage, SWPDiscounts));
        end;
    end;

    local procedure ValidateWarrantyPrice(CarWarrantyMultiplier: Decimal): decimal;
    var
        SWPDiscounts: Record "SWP Discounts";
    begin
        with SWPDiscounts do begin
            SetRange("SWP Entry Type", "SWP Entry Type"::"Warranty Prices");
            exit(NumberOfDaysInLine * CarWarrantyMultiplier *
                FindMinimalAppropriateDiscountValue(NumberOfDaysInLine, SWPDiscounts));
        end;
    end;

    local procedure FindMinimalAppropriateDiscountValue(PriceFactor: Decimal; VAR SWPDiscounts: Record "SWP Discounts") WarrantyPrice: Decimal
    begin
        with SWPDiscounts do begin
            SetCurrentKey("SWP Price Factor");
            if FindLast() then
                WarrantyPrice := "SWP Price Value";
            SetFilter("SWP Price Factor", '>%1', PriceFactor);
            if FindFirst() then
                WarrantyPrice := "SWP Price Value";
        end;
    end;

    procedure ValidateStartEndDates(ServiceContractLine: Record "Service Contract Line"): Boolean;
    var
        ServiceContractLine2: Record "Service Contract Line";
        Item: Record Item;
        NewLineStartDate: Date;
        NewLineEndDate: Date;
        showerr: Boolean;
    begin
        NewLineStartDate := ServiceContractLine."SWP Starting Date";
        NewLineEndDate := ServiceContractLine."Contract Expiration Date";

        //message(format(ServiceContractLine."Service Item No.") + '|' + format(NewLineStartDate) + '|' + format(NewLineEndDate) + '|');
        if ServiceContractLine."Contract Expiration Date" > 0D then begin
            IF ServiceContractLine."Contract Expiration Date" < ServiceContractLine."SWP Starting Date" THEN
                ERROR(
                  Text009Lbl,
                  FIELDCAPTION("Contract Expiration Date"),
                  FIELDCAPTION("SWP Starting Date"));

            with ServiceContractLine2 do begin
                reset;
                SetFilter("Contract Status", '<>%1', "Contract Status"::Cancelled);
                SetRange("Item No.", ServiceContractLine."Item No.");
                SetFilter("SWP Starting Date", '<%1', NewLineEndDate);
                SetFilter("Contract Expiration Date", '>%1', NewLineStartDate - 2);
                if findset then begin
                    if NOT (("Contract No." = ServiceContractLine."Contract No.") and ("Line No." = ServiceContractLine."Line No.")) then
                        showerr := true
                    else
                        if (count > 1) then begin
                            next();
                            showerr := true;
                        end;
                    if showerr then begin
                        if Item.Get(ServiceContractLine."Item No.") then;
                        ERROR(AlreadyBookedErrLbl, Item.Description, "Contract No.", "Service Item No.", "SWP Starting Date", "Contract Expiration Date");
                    end;
                end;
                NumberOfDaysInLine := (NewLineEndDate - NewLineStartDate) + 1;
                exit(true);
            end;
        end;
    end;

    var
        NumberOfDaysInLine: Integer;
        Text009Lbl: Label 'The %1 cannot be less than the %2.';
        AlreadyBookedErrLbl: Label 'Car %1 is already ordered in %2 order line %3 on dates: from %4 till %5. ';
}