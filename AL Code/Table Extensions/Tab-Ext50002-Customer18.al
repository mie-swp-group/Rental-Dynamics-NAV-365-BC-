tableextension 50002 "Customer (SWP)" extends "Customer"
{
    fields
    {
        field(50000; "SWP Passport No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Passport No.';
        }

        field(50001; "SWP Orders amounts"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Orders amounts';
        }
    }
}