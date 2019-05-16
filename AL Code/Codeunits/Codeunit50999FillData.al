codeunit 50111 adddata
{
    trigger OnRun()
    begin
        With Item DO begin
            init;
            "No." := '70080';
            Description := 'Rent car1';
            "SWP RegNo" := 'AM 1250 AA';
            "SWP Manufacturer" := 'Audi';
            "SWP Model" := 'RS7';
            "SWP Color" := 'Blue';
            "Unit Cost" := 2500000;
            "Unit Price" := 12500;
            "SWP Maintenance cost" := 250;
            "SWP Warranty Multiplier" := 0.95;
            "SWP Mileage" := 12345;
            "SWP Garage" := 'GARAGE1';
            "SWP Days in orders" := 4;
            "SWP Rental Item" := true;
            Evaluate("SWP Obtained on", '7/7/2017D');
            if not insert() then modify();

            init;
            "No." := '70081';
            Description := 'Rent car2';
            "SWP RegNo" := 'AM 0505 AM';
            "SWP Manufacturer" := 'BMW';
            "SWP Model" := 'X5';
            "SWP Color" := 'Black';
            "Unit Cost" := 1600000;
            "Unit Price" := 8000;
            "SWP Maintenance cost" := 160;
            "SWP Warranty Multiplier" := 1;
            "SWP Mileage" := 53456;
            "SWP Garage" := 'GARAGE1';
            "SWP Days in orders" := 20;
            "SWP Rental Item" := true;
            Evaluate("SWP Obtained on", '6/6/2016D');
            if not insert() then modify();

            init;
            "No." := '70082';
            Description := 'Rent car3';
            "SWP RegNo" := 'AM 5050 AI';
            "SWP Manufacturer" := 'Porche';
            "SWP Model" := '911';
            "SWP Color" := 'Red';
            "Unit Cost" := 2700000;
            "Unit Price" := 13500;
            "SWP Maintenance cost" := 270;
            "SWP Warranty Multiplier" := 1.05;
            "SWP Mileage" := 134567;
            "SWP Garage" := 'GARAGE2';
            "SWP Days in orders" := 21;
            "SWP Rental Item" := true;
            Evaluate("SWP Obtained on", '05/05/2015D');
            if not insert() then modify();
        end;
        With Location DO begin
            init;
            "Code" := 'GARAGE1';
            Name := 'Rental 1st Garage';
            "SWP No." := 1;
            "SWP Maintenance price" := 1500;
            "SWP Max Capacity" := 3;
            Address := 'Zhytomyr, Myru ave., 21';
            if not insert() then modify();

            init;
            "Code" := 'GARAGE2';
            Name := 'Rental 2nd Garage';
            "SWP No." := 2;
            "SWP Maintenance price" := 1750;
            "SWP Max Capacity" := 3;
            Address := 'Zhytomyr, Peremogy sqr., 10';
            if not insert() then modify();
        end;



        With discounts DO begin
            DeleteAll();

            init;
            "SWP Entry No." := 1;
            "SWP Entry Type" := 0;
            "SWP Price Factor" := 5000;
            "SWP Price Value" := 3;
            if not insert() then modify();

            init;
            "SWP Entry No." := 2;
            "SWP Entry Type" := 0;
            "SWP Price Factor" := 10000;
            "SWP Price Value" := 5;
            if not insert() then modify();
            init;
            "SWP Entry No." := 3;
            "SWP Entry Type" := 0;
            "SWP Price Factor" := 20000;
            "SWP Price Value" := 6;
            if not insert() then modify();
            init;
            "SWP Entry No." := 4;
            "SWP Entry Type" := 0;
            "SWP Price Factor" := 50000;
            "SWP Price Value" := 10;
            if not insert() then modify();

            init;
            "SWP Entry No." := 5;
            "SWP Entry Type" := 1;
            "SWP Price Factor" := 250000;
            "SWP Price Value" := 3;
            if not insert() then modify();
            init;
            "SWP Entry No." := 6;
            "SWP Entry Type" := 1;
            "SWP Price Factor" := 700000;
            "SWP Price Value" := 5;
            if not insert() then modify();
            init;
            "SWP Entry No." := 7;
            "SWP Entry Type" := 1;
            "SWP Price Factor" := 1000000;
            "SWP Price Value" := 7;
            if not insert() then modify();
            init;
            "SWP Entry No." := 8;
            "SWP Entry Type" := 1;
            "SWP Price Factor" := 2500000;
            "SWP Price Value" := 10;
            if not insert() then modify();

            init;
            "SWP Entry No." := 9;
            "SWP Entry Type" := 2;
            "SWP Price Factor" := 50000;
            "SWP Price Value" := 2;
            if not insert() then modify();
            init;
            "SWP Entry No." := 10;
            "SWP Entry Type" := 2;
            "SWP Price Factor" := 100000;
            "SWP Price Value" := 3;
            if not insert() then modify();
            init;
            "SWP Entry No." := 11;
            "SWP Entry Type" := 2;
            "SWP Price Factor" := 200000;
            "SWP Price Value" := 5;
            if not insert() then modify();
            init;
            "SWP Entry No." := 12;
            "SWP Entry Type" := 2;
            "SWP Price Factor" := 500000;
            "SWP Price Value" := 7;
            if not insert() then modify();
            init;
            "SWP Entry No." := 13;
            "SWP Entry Type" := 2;
            "SWP Price Factor" := 1000000;
            "SWP Price Value" := 10;
            if not insert() then modify();

            init;
            "SWP Entry No." := 14;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 10;
            "SWP Price Value" := 1000;
            if not insert() then modify();
            init;
            "SWP Entry No." := 15;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 30;
            "SWP Price Value" := 950;
            if not insert() then modify();
            init;
            "SWP Entry No." := 16;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 60;
            "SWP Price Value" := 900;
            if not insert() then modify();
            init;
            "SWP Entry No." := 17;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 90;
            "SWP Price Value" := 850;
            if not insert() then modify();
            init;
            "SWP Entry No." := 18;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 180;
            "SWP Price Value" := 800;
            if not insert() then modify();
            init;
            "SWP Entry No." := 19;
            "SWP Entry Type" := 3;
            "SWP Price Factor" := 360;
            "SWP Price Value" := 750;
            if not insert() then modify();
        end;
    end;


    var
        Customer: Record Customer;
        Location: Record Location;
        Item: Record Item;
        discounts: Record "SWP Discounts";
}