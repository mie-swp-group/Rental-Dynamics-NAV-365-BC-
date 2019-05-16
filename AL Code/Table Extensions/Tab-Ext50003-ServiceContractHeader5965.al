tableextension 50003 "Service Contract Header (SWP)" extends "Service Contract Header"
{
    fields
    {
        field(50000; "SWP Order Undiscounted Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Undiscounted Amount';
        }
        field(50001; "SWP Order Amount Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Order Amount Discount %';
        }
        field(50002; "SWP Customer Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Discount %';
        }
        field(50003; "SWP Common Car Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Common Car Discount %';
        }
        field(50004; "SWP Total Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Total Discount %';
        }
        field(50005; "SWP Rental Type Document"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rental Type Document';
            Editable = false;
        }
    }
}