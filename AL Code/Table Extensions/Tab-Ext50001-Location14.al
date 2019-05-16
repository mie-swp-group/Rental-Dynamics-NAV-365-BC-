tableextension 50001 "Location (SWP)" extends "Location"
{
    fields
    {
        field(50000; "SWP Max Capacity"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Max Capacity';
        }
        field(50001; "SWP Maintenance price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Maintenance price, UAH/day';
        }
        field(50002; "SWP No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
    }
}