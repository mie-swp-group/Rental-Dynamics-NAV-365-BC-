tableextension 50000 "Item (SWP)" extends "Item"
{
    fields
    {
        field(50000; "SWP RegNo"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Registration Number';
        }
        field(50001; "SWP Manufacturer"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Manufacturer';
        }
        field(50002; "SWP Model"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Model';
        }
        field(50003; "SWP Color"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Color';
        }
        // field(50004; "SWP Cost"; Text)
        ////////////////"Unit Cost"
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Cost (UAH)';
        // }
        // field(50005; "SWP Price"; Text)
        ////////////////"Unit Price"
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Price (UAH/day)';
        // }        
        field(50004; "SWP Maintenance cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Maintenance cost (UAH/day)';
        }
        field(50005; "SWP Warranty Multiplier"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Multiplier';
        }
        field(50006; "SWP Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mileage (km)';
        }
        field(50007; "SWP Garage"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Garage';
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                Location: Record Location;
                Item2: Record Item;
            begin
                if Location.get("SWP Garage") then begin
                    Item2.SetRange("SWP Garage", "SWP Garage");
                    if NOT (Item2.COUNT() < Location."SWP Max Capacity") then
                        error(FullGarageLbl);
                end;

            end;
        }
        field(50008; "SWP Days in orders"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Days in orders';
        }
        field(50009; "SWP Obtained on"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Obtained on';
        }
        field(50010; "SWP Rental Item"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rental Item';
        }
    }

    trigger OnBeforeModify();
    begin
        if "SWP Rental Item" then
            testfield("SWP RegNo");
    end;

    var
        FullGarageLbl: label 'Selected garage is full';
}