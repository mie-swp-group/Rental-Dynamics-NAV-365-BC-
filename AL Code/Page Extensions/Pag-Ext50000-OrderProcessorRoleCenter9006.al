pageextension 50000 "SWP Order Processor" extends "Order Processor Role Center"
{
    actions
    {
        addbefore("SalesOrders")
        {

            action(RentalCustomer)
            {
                Caption = 'Rental Customers';
                RunObject = page "Customer List";
                RunPageLink = "SWP Passport No." = filter (> '');
            }
            action(RentalItems)
            {
                Caption = 'Rental Items';
                RunObject = page "Item List";
                RunPageLink = "SWP Rental Item" = const (true);
            }
            action(RentalLocations)
            {
                Caption = 'Rental Locations';
                RunObject = page "Location List";
                RunPageLink = "SWP Max Capacity" = filter (> 0);
            }
            action(RentalContracts)
            {
                Caption = 'Rental Contracts';
                RunObject = page "Service Contracts";
                RunPageLink = "SWP Rental Type Document" = const (true);
            }
            action(RentalInvoices)
            {
                Caption = 'Rental Invoices';
                RunObject = page "Service Invoices";
            }
            action(PostedRentalInvoices)
            {
                Caption = 'Posted Rental Invoices';
                RunObject = page "Posted Service Invoices";
            }
        }
    }
}