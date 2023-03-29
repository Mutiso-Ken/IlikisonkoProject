#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516415 "Loan Products Setup Card"
{
    // `

    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Products Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code";Code)
                {
                    ApplicationArea = Basic;
                }
                field("Product Description";"Product Description")
                {
                    ApplicationArea = Basic;
                }
                field("Type Of Loan";"Type Of Loan")
                {
                    ApplicationArea = Basic;
                }
                field(Source;Source)
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                }
                field("Interest rate 2";"Interest rate 2")
                {
                    ApplicationArea = Basic;
                }
                field("Charge Interest Upfront";"Charge Interest Upfront")
                {
                    ApplicationArea = Basic;
                }
                field("Graduated Interest";"Graduated Interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repayment Method";"Repayment Method")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period";"Grace Period")
                {
                    ApplicationArea = Basic;
                }
                field("Instalment Period";"Instalment Period")
                {
                    ApplicationArea = Basic;
                }
                field("No of Installment";"No of Installment")
                {
                    ApplicationArea = Basic;
                }
                field("Default Installements";"Default Installements")
                {
                    ApplicationArea = Basic;
                }
                field("Min Installments Period";"Min Installments Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Penalty Calculation Days";"Penalty Calculation Days")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Percentage";"Penalty Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Recovery Priority";"Recovery Priority")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Min No. Of Guarantors";"Min No. Of Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Min Re-application Period";"Min Re-application Period")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposits Multiplier";"Deposits Multiplier")
                {
                    ApplicationArea = Basic;
                }
                field("Shares Multiplier";"Shares Multiplier")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Deposit Multiplier 1st Loan";"Deposit Multiplier 1st Loan")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Penalty Calculation Method";"Penalty Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Self guaranteed Multiplier";"Self guaranteed Multiplier")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Loan Product Expiry Date";"Loan Product Expiry Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Min. Loan Amount";"Min. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Max. Loan Amount";"Max. Loan Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Check Off Recovery";"Check Off Recovery")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Allowable Loan Offset(%)";"Allowable Loan Offset(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Top Up Commision";"Top Up Commision")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest';
                }
                field("Loan PayOff Fee(%)";"Loan PayOff Fee(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Repayment Frequency";"Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
                field("Dont Recover Repayment";"Dont Recover Repayment")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Special Code Principle";"Special Code Principle")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Special Code Balance";"Special Code Balance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Special Code Interest";"Special Code Interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Is Staff Loan";"Is Staff Loan")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Recovery Method";"Recovery Method")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Deductible;Deductible)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Qualification for Saver(%)";"Qualification for Saver(%)")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Amortization Interest Rate(SI)";"Amortization Interest Rate(SI)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amortization Interest Rate(Sacco Interest)';
                    Visible = false;
                }
                field("Accrue Total Insurance";"Accrue Total Insurance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Minimum Deposit For Loan Appl";"Minimum Deposit For Loan Appl")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Accrue Loan Interest";"Accrue Loan Interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Allow Loan Advance";"Allow Loan Advance")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Salary Appraisal Percentage";"Salary Appraisal Percentage")
                {
                    ApplicationArea = Basic;
                }
                field("Allow Self Guarantee";"Allow Self Guarantee")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Auto Offset Period";"Auto Offset Period")
                {
                    ApplicationArea = Basic;
                }
                field("Is Disabled";"Is Disabled")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Allow class B";"Allow class B")
                {
                    ApplicationArea = Basic;
                }
                field("Check Residence";"Check Residence")
                {
                    ApplicationArea = Basic;
                }
                field("Use Free Deposits";"Use Free Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Percentage of Rent Income";"Percentage of Rent Income")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Qualification Criteria")
            {
                Caption = 'Qualification Criteria';
                field("Appraise Deposits";"Appraise Deposits")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposits';
                }
                field("Appraise Shares";"Appraise Shares")
                {
                    ApplicationArea = Basic;
                    Caption = 'Shares';
                    Visible = false;
                }
                field("Appraise Salary";"Appraise Salary")
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary';
                }
                field("Appraise Guarantors";"Appraise Guarantors")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Income";"Appraise Income")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Savings";"Appraise Savings")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Collateral";"Appraise Collateral")
                {
                    ApplicationArea = Basic;
                }
                field("Appraise Securities";"Appraise Securities")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Fees & Comissions Accounts")
            {
                Caption = 'Fees & Comissions Accounts';
                field("Penalty Paid Account";"Penalty Paid Account")
                {
                    ApplicationArea = Basic;
                }
                field("Penalty Charged Account";"Penalty Charged Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Account";"Loan Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Interest Account";"Loan Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Interest Account";"Receivable Interest Account")
                {
                    ApplicationArea = Basic;
                }
                field("Top Up Commision Account";"Top Up Commision Account")
                {
                    ApplicationArea = Basic;
                    Caption = 'Top Up Interest Account';
                }
                field("Interest In Arrears Account";"Interest In Arrears Account")
                {
                    ApplicationArea = Basic;
                }
                field("Loan PayOff Fee Account";"Loan PayOff Fee Account")
                {
                    ApplicationArea = Basic;
                }
                field("Receivable Insurance Accounts";"Receivable Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Insurance Accounts";"Loan Insurance Accounts")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Product)
            {
                Caption = 'Product';
                action("Product Charges")
                {
                    ApplicationArea = Basic;
                    Caption = 'Product Charges';
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Product Charges";
                    RunPageLink = "Product Code"=field(Code);
                }
                action("Loan to Share Ratio Analysis")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Product Deposit>Loan Analysis";
                    RunPageLink = "Product Code"=field(Code);
                    Visible = false;
                }
                action("Graduated Loan Interest")
                {
                    ApplicationArea = Basic;
                    Image = Setup;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Graduated Loan Interest";
                    RunPageLink = "Loan Code"=field(Code);
                    Visible = false;
                }
            }
        }
    }
}

