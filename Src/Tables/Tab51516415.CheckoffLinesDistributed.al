#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516415 "Checkoff Lines-Distributed"
{

    fields
    {
        field(1;"Staff/Payroll No";Code[20])
        {
        }
        field(2;Amount;Decimal)
        {
        }
        field(3;"No Repayment";Boolean)
        {
        }
        field(4;"Staff Not Found";Boolean)
        {
        }
        field(5;"Date Filter";Date)
        {
            FieldClass = FlowFilter;
        }
        field(6;"Transaction Date";Date)
        {
        }
        field(7;"Entry No";Integer)
        {
        }
        field(8;Generated;Boolean)
        {
        }
        field(9;"Payment No";Integer)
        {
        }
        field(10;Posted;Boolean)
        {
        }
        field(11;"Multiple Receipts";Boolean)
        {
        }
        field(12;Name;Text[200])
        {
        }
        field(13;"Early Remitances";Boolean)
        {
        }
        field(14;"Early Remitance Amount";Decimal)
        {
        }
        field(15;"Loan No.";Code[20])
        {
            TableRelation = "Loans Register"."Loan  No." where ("Client Name"=field(Name),
                                                                "Outstanding Balance"=filter(<>0));
        }
        field(16;"Member No.";Code[20])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.","Member No.");
                if Cust.Find('-') then begin
                Name:=Cust.Name;
                end;
            end;
        }
        field(17;Interest;Decimal)
        {
        }
        field(18;"Loan Type";Code[20])
        {
        }
        field(19;DEPT;Code[10])
        {
        }
        field(20;"Expected Amount";Decimal)
        {
        }
        field(21;"FOSA Account";Code[20])
        {
        }
        field(22;"Utility Type";Code[20])
        {
        }
        field(23;"Transaction Type";Option)
        {
            OptionMembers = "Deposits Contribution","Insurance contribution";
        }
        field(24;Reference;Code[50])
        {
        }
        field(25;"Account type";Code[10])
        {
        }
        field(26;Variance;Decimal)
        {
        }
        field(27;"Employer Code";Code[10])
        {
        }
        field(28;GPersonalNo;Code[10])
        {
        }
        field(29;Gnames;Text[80])
        {
        }
        field(30;Gnumber;Code[10])
        {
        }
        field(31;Userid1;Code[25])
        {
        }
        field(32;"Loans Not found";Boolean)
        {
        }
        field(33;"Receipt Header No";Code[20])
        {
            TableRelation = "Checkoff Header-Distributed".No;
        }
        field(34;"Unallocated Fund";Boolean)
        {
        }
        field(35;"Posting Date";Date)
        {
        }
        field(36;"Document No";Code[20])
        {
        }
        field(37;"Ledger Found";Boolean)
        {
        }
        field(38;"Deposit contribution";Decimal)
        {
        }
        field(39;"Share Capital";Decimal)
        {
        }
        field(40;"By Laws";Decimal)
        {
        }
        field(41;"Insurance Contribution";Decimal)
        {
        }
        field(42;"Entrance Fees";Decimal)
        {
        }
        field(43;Stocks;Decimal)
        {
        }
        field(44;Demand;Decimal)
        {
        }
        field(45;"Normal Loan";Decimal)
        {
        }
        field(46;"Int normal loan";Decimal)
        {
        }
        field(47;"Emergency Loan";Decimal)
        {
        }
        field(48;"Int Emergency Loan";Decimal)
        {
        }
        field(49;"School Fees Loan";Decimal)
        {
        }
        field(50;"Int SFees Loan";Decimal)
        {
        }
        field(51;"Premium Loan";Decimal)
        {
        }
        field(52;"Int Premium Loan";Decimal)
        {
        }
        field(53;"NLoan No";Code[10])
        {
        }
        field(54;"ELoan No.";Code[10])
        {
        }
        field(55;SLoanNo;Code[10])
        {
        }
        field(56;"PLoan No";Code[10])
        {
        }
        field(57;"House Loan";Decimal)
        {
        }
        field(58;"Int House Loan";Decimal)
        {
        }
        field(59;"HLoan No";Code[10])
        {
        }
        field(60;"Instant Loan";Decimal)
        {
        }
        field(61;"Int Instant Loan";Decimal)
        {
        }
        field(62;"ILoan No";Code[10])
        {
        }
        field(63;"SS Loan";Decimal)
        {
        }
        field(64;"Int SS Loan";Decimal)
        {
        }
        field(65;"SSLoan No";Code[10])
        {
        }
        field(66;SALoan;Decimal)
        {
        }
        field(67;"Int SA Loan";Decimal)
        {
        }
        field(68;"H/A Loan";Decimal)
        {
        }
        field(69;"Int H/A Loan";Decimal)
        {
        }
        field(70;"H/A Loan No";Code[10])
        {
        }
        field(71;"SA Loan No";Code[10])
        {
        }
        field(72;"Guarantor Loan";Decimal)
        {
        }
        field(73;"Int Guarantor Loan";Decimal)
        {
        }
        field(74;"Guarantor Loan No";Code[10])
        {
        }
        field(75;"BB Loan";Decimal)
        {
        }
        field(76;"Int BB Loan";Decimal)
        {
        }
        field(77;"BB Loan No";Code[10])
        {
        }
        field(78;"Nse Loan";Decimal)
        {
        }
        field(79;"Int Nse Loan";Decimal)
        {
        }
        field(80;"NSe Loan No";Code[10])
        {
        }
        field(81;"Member Name";Text[100])
        {
        }
        field(82;"Refinance Loan";Decimal)
        {
        }
        field(83;"Int Refinance Loan";Decimal)
        {
        }
        field(84;"Refinance Loan No";Code[10])
        {
        }
    }

    keys
    {
        key(Key1;"Receipt Header No","Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "Member Register";
}

