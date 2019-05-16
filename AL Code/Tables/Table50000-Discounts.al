table 50000 "SWP Discounts"
{
    DataClassification = ToBeClassified;
    LookupPageId = "SWP Discounts List";
    Caption = 'Discounts';
    fields
    {
        field(1; "SWP Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "SWP Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Discount by Order Amount","Discount by Customer Amount","Discount by Mileage","Warranty Prices";
            OptionCaption = 'Discount by Order Amount,Discount by Customer Amount,Discount by Mileage,Warranty Prices';
            Caption = 'Entry Type';
        }
        field(3; "SWP Price Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount (UAH)';
        }
        field(4; "SWP Price Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Discount (%)';
        }
    }

    keys
    {
        key(Key1; "SWP Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "SWP Price Factor") { }
    }
}