<?php
//dataconnection
include 'dataconnection.php';

// Start session if not already started
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

if (isset($_GET['Invoice_ID'])) {
    $Invoice_ID = $_GET['Invoice_ID'];
} else {
    die("Invoice ID is missing.");
}

$Customer_ID = $_SESSION["Customer_ID"];

$query = "SELECT bill_master.*, bill_master_transaction.*, product.*, customer.*
          FROM bill_master
          JOIN bill_master_transaction ON bill_master.Invoice_ID = bill_master_transaction.Invoice_ID
          JOIN product ON bill_master_transaction.Product_ID = product.Product_ID
          JOIN customer ON bill_master.Customer_ID = customer.Customer_ID
          WHERE bill_master.Customer_ID = $Customer_ID AND bill_master.Invoice_ID = $Invoice_ID
          ORDER BY bill_master.Invoice_ID DESC"; // Order by Invoice_ID in descending order

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $invoice_data = $result->fetch_all(MYSQLI_ASSOC);
}
else {
    die("No data found for the specified invoice.");
}

require 'fpdf186/fpdf.php';

//A4 width : 219mm
//default mmargin : 10mm each side
//writable horizontal : 219-(10*3)=189mm

$pdf = new FPDF('P', 'mm', 'A4');
$pdf -> AddPage();

//set font to Arial, bold, 14pt for the title
$pdf -> SetFont('Arial', 'B', 14);

//setting cell(width, height, text, border, newline, [align])
//0: no border  1: border
//0: continue line 1: new line
//L or empty string: left align(default)    C: center    R: right align
$pdf -> Cell(131, 15, 'TKT Sport Shoes Sdn.Bhd', 0, 0);
$pdf -> Cell(58, 15, 'INVOICE', 0, 1, 'R');

//set font to Arial, regular, 12pt for information
$pdf -> SetFont('Arial', '', 12);

$pdf -> Cell(120, 5, 'B-16-03A, Jalan D1', 0, 0);
$pdf -> Cell(69, 5, '', 0, 1);

$pdf -> Cell(120, 5, 'Melaka, Malaysia', 0, 0);
$pdf -> Cell(34, 5, 'Date', 0, 0);
$pdf -> Cell(35, 5, date('d/m/y', strtotime($invoice_data[0]['Invoice_Date'])), 0, 1);

$pdf -> Cell(120, 5, 'Phone +6017-7833558', 0, 0);
$pdf -> Cell(34, 5, 'Receipt #', 0, 0);
$pdf -> Cell(35, 5, sprintf('%06d', $invoice_data[0]['Invoice_ID']), 0, 1);

$pdf -> Cell(120, 5, 'Fax +607-9933100', 0, 0);
$pdf -> Cell(34, 5, 'Customer Name', 0, 0);
$pdf -> Cell(35, 5, $invoice_data[0]['Customer_Username'], 0, 1);

//make a dummy empty cell as vertical spacer
$pdf -> Cell(189, 10, '', 0, 1);

$pdf->SetFont('Arial', 'B', 12);
// billing address
$pdf->Cell(70, 15, 'Bill to : ', 0, 0);
$pdf->Cell(119, 15, 'Delivery to : ', 0, 1);

$pdf->SetFont('Arial', '', 12);
$pdf->Cell(10, 5, '', 0, 0);
$pdf->MultiCell(60, 5, $invoice_data[0]['Billing_Address_Line1'] . "\n" . $invoice_data[0]['Billing_Address_Line2'] . "\n" . $invoice_data[0]['Billing_Address_Line3'] . "\n" . $invoice_data[0]['Billing_Address_Line4'] . "\n" . $invoice_data[0]['Customer_Phone_Number'], 0, 'L');
$pdf->SetXY($pdf->GetX() + 10 + 60 + 10, $pdf->GetY() - 25); // Adjust X and Y for Delivery to cell
$pdf->MultiCell(70, 5, $invoice_data[0]['Delivery_Address'], 0, 'L');

$pdf->Cell(189, 20, '', 0, 1);

//invoice content
$pdf -> SetFont('Arial', 'B', 12);

$pdf -> Cell(130, 10, 'Description', 0, 0);
$pdf -> Cell(25, 10, 'Quantity', 0, 0, 'C');
$pdf -> Cell(34, 10, 'Amount (RM)', 0, 1, 'R');

//calculate Y-coordinate where the last row ends
$y = $pdf -> GetY();

//Draw the dividing line
//set line width
$pdf -> SetLineWidth(0.5);
//x start from 10(left margin) end at 199
$pdf -> Line(10, $y-2, 199, $y-2);

//invoice information
$pdf -> SetFont('Arial', '', 12);
$total = 0;
$totalqty = 0;

foreach ($invoice_data as $item) {
    // Access Quantity from bill_master_transaction and Price from product
    $quantity = $item['Quantity'];
    $price = $item['Product_Price'];
    
    // Calculate amount
    $totalqty += $quantity;
    $amount = $quantity * $price;
    $total += $amount;
    
    // Output product name, quantity, and amount
    $pdf->Cell(130, 5, $item['Product_Name'], 0, 0);
    $pdf->Cell(25, 5, $quantity, 0, 0, 'C');
    $pdf->Cell(34, 5, number_format($amount, 2), 0, 1, 'R');
}

$pdf -> SetFont('Arial', 'B', 12);
$tax = $total * 0.06;
$pdf -> Cell(130, 15, 'SST [6%]', 0, 0);
$pdf -> Cell(25, 15, '-', 0, 0, 'C');
$pdf -> Cell(34, 15, number_format($tax, 2), 0, 1, 'R');

$pdf -> SetFont('Arial', '', 12);
$pdf -> Cell(130, 15, '', 0, 0);
$pdf -> Cell(25, 15, $totalqty, 0, 0, 'C');
$pdf -> Cell(34, 15, number_format($total + $tax, 2), 0, 1, 'R');

$pdf -> Cell(189, 10, '', 0, 1);

$pdf -> Cell(35, 5, 'Product Status :', 0, 0);
$pdf -> Cell(35, 5, $invoice_data[0]['Invoice_Status'], 0, 1);

$pdf -> Cell(189, 10, '', 0, 1);

//generate pdf file and send to client
$pdf -> Output();
