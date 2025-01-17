-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2025 at 07:43 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `final_year_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `Admin_ID` int(2) NOT NULL,
  `Admin_Username` text NOT NULL,
  `Admin_Password` varchar(255) NOT NULL,
  `Admin_Email` text NOT NULL,
  `Admin_Profile_Image` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`Admin_ID`, `Admin_Username`, `Admin_Password`, `Admin_Email`, `Admin_Profile_Image`) VALUES
(1, 'TCY24', '289dff07669d7a23de0ef88d2f7129e7', 'admin@gmail.com', 0x696d672f3331393536303439335f3730353636353834343231313738365f373330313838343638393131333736343939365f6e2e6a7067),
(2, 'TEE CHIN UEAN', '202cb962ac59075b964b07152d234b70', 'larkpq@gmail.com', ''),
(3, 'testing', '827ccb0eea8a706c4c34a16891f84e7b', '756@student.mmu.edu.my', ''),
(4, 'admin', '81dc9bdb52d04dc20036dbd8313ed055', '12345@gmail.com', 0x696d672f32303233303131355f3231343131362e6a7067),
(5, 'testing', '202cb962ac59075b964b07152d234b70', '121@gmail.com', '');

-- --------------------------------------------------------

--
-- Table structure for table `bill_master`
--

CREATE TABLE `bill_master` (
  `Invoice_ID` int(6) NOT NULL,
  `Customer_ID` int(5) NOT NULL,
  `Invoice_Date` date NOT NULL DEFAULT current_timestamp(),
  `Total_Amount` decimal(7,2) NOT NULL,
  `Delivery_Address` text DEFAULT NULL,
  `Invoice_Status` varchar(10) NOT NULL,
  `Remark` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill_master`
--

INSERT INTO `bill_master` (`Invoice_ID`, `Customer_ID`, `Invoice_Date`, `Total_Amount`, `Delivery_Address`, `Invoice_Status`, `Remark`) VALUES
(1, 1, '2023-07-01', 1797.00, 'NO 72,JALAN JERAM 4', 'Delivered', ''),
(2, 2, '2024-07-01', 289.00, '123 123 123 123', 'Delivered', ''),
(3, 3, '2024-07-02', 499.00, '123 123 123 123', 'Preparing', ''),
(4, 8, '2024-07-03', 5391.00, '123 123 123 123', 'In transit', ''),
(5, 8, '2024-07-03', 372.00, '123 123 123 123', 'Pending', '');

-- --------------------------------------------------------

--
-- Table structure for table `bill_master_transaction`
--

CREATE TABLE `bill_master_transaction` (
  `Item_ID` int(10) NOT NULL,
  `Invoice_ID` int(6) NOT NULL,
  `Product_ID` int(4) NOT NULL,
  `Quantity` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill_master_transaction`
--

INSERT INTO `bill_master_transaction` (`Item_ID`, `Invoice_ID`, `Product_ID`, `Quantity`) VALUES
(1, 1, 7, 3),
(2, 2, 3, 1),
(3, 3, 11, 1),
(4, 4, 5, 9),
(5, 5, 27, 3);

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `Cart_ID` int(6) NOT NULL,
  `Customer_ID` int(5) NOT NULL,
  `Total_Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`Cart_ID`, `Customer_ID`, `Total_Price`) VALUES
(2, 1, 3231.00),
(5, 3, 0.00),
(6, 2, 867.00),
(7, 4, NULL),
(8, 5, NULL),
(11, 8, 289.00);

-- --------------------------------------------------------

--
-- Table structure for table `cart_item`
--

CREATE TABLE `cart_item` (
  `CI_ID` int(7) NOT NULL,
  `Cart_ID` int(6) NOT NULL,
  `Product_ID` int(4) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `CI_Status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cart_item`
--

INSERT INTO `cart_item` (`CI_ID`, `Cart_ID`, `Product_ID`, `Quantity`, `CI_Status`) VALUES
(3, 2, 1, 9, 0),
(9, 6, 3, 3, 0),
(13, 11, 3, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Customer_ID` int(5) NOT NULL,
  `Customer_Username` text DEFAULT NULL,
  `Customer_Email` text NOT NULL,
  `Customer_Password` varchar(50) NOT NULL,
  `Customer_Phone_Number` varchar(15) NOT NULL,
  `Billing_Address_Line1` text DEFAULT NULL,
  `Billing_Address_Line2` text DEFAULT NULL,
  `Billing_Address_Line3` text DEFAULT NULL,
  `Billing_Address_Line4` text DEFAULT NULL,
  `Customer_Register_Time` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `Customer_Delivery_Address_1` text DEFAULT NULL,
  `Customer_Delivery_Address_2` text DEFAULT NULL,
  `Customer_Delivery_Address_3` text DEFAULT NULL,
  `Customer_Profile_Image` longblob DEFAULT NULL,
  `Customer_Status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Customer_ID`, `Customer_Username`, `Customer_Email`, `Customer_Password`, `Customer_Phone_Number`, `Billing_Address_Line1`, `Billing_Address_Line2`, `Billing_Address_Line3`, `Billing_Address_Line4`, `Customer_Register_Time`, `Customer_Delivery_Address_1`, `Customer_Delivery_Address_2`, `Customer_Delivery_Address_3`, `Customer_Profile_Image`, `Customer_Status`) VALUES
(1, 'Kho wei Cong', 'khoweicong100@gmail.com', '321022fddb9224d7d705a7cb1707b2f6', '017-7833 558', 'No 5, Taman Jasa', 'Jalan Jasa 4', '82000, Pontian', 'Johor', '2024-07-01 14:13:39.722484', '', '', '', NULL, 0),
(2, '213', '231@gmail.com', '803f2bef49d6413ebcb5d57fcce8fcd8', '123-4213 4342', '123', '123', '123', '123', '2024-07-01 22:12:13.570965', NULL, NULL, NULL, NULL, 0),
(3, '123', '1234@gmail.com', '803f2bef49d6413ebcb5d57fcce8fcd8', '123-5464 5454', '123', '123', '123', '123', '2024-07-02 11:35:33.722240', NULL, NULL, NULL, NULL, 0),
(4, '1234', 'larkpq@gmail.com', '090437b39df42598bd9713b6d284f6ee', '012-3456 7812', NULL, NULL, NULL, NULL, '2024-07-02 23:42:29.153819', NULL, NULL, NULL, NULL, 0),
(5, 'Kho wei Cong', '1211211485@student.mmu.edu.my', '6a836669ee1d6b5e26818720214d8027', '012-3456 7812', NULL, NULL, NULL, NULL, '2024-07-03 10:51:18.770809', NULL, NULL, NULL, NULL, 0),
(6, '123', '124@gmail.com', '321022fddb9224d7d705a7cb1707b2f6', '017-7833 558', NULL, NULL, NULL, NULL, '2024-07-03 11:49:34.736061', NULL, NULL, NULL, NULL, 0),
(7, '123', '123@gmail.com', '321022fddb9224d7d705a7cb1707b2f6', '017-7833 558', NULL, NULL, NULL, NULL, '2024-07-03 13:24:50.310401', NULL, NULL, NULL, NULL, 0),
(8, 'TCY', '1211208756@student.mmu.edu.my', '803f2bef49d6413ebcb5d57fcce8fcd8', '012-3456 7891', '123', '123', '123', '123', '2024-07-03 14:07:14.700001', 'NO 72,JALAN JERAM 4', '', '', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `Product_ID` int(4) NOT NULL,
  `Size_ID` int(2) NOT NULL,
  `Product_Name` text NOT NULL,
  `Product_Description` text NOT NULL,
  `Product_quantity_available` int(4) NOT NULL,
  `sale_quantity` int(4) NOT NULL,
  `Product_Price` decimal(7,2) NOT NULL,
  `Product_Cost` decimal(7,2) NOT NULL,
  `New_arrive` int(1) NOT NULL,
  `Product_Status` int(1) NOT NULL,
  `PC_ID` int(25) NOT NULL,
  `Product_Image` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`Product_ID`, `Size_ID`, `Product_Name`, `Product_Description`, `Product_quantity_available`, `sale_quantity`, `Product_Price`, `Product_Cost`, `New_arrive`, `Product_Status`, `PC_ID`, `Product_Image`) VALUES
(1, 9, 'MENS SPORTS LATHER', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor. Ipsum metus feugiat sem, quis fermentum turpis eros eget velit. Donec ac tempus ante. Fusce ultricies massa massa. Fusce aliquam, purus eget sagittis vulputate, sapien libero hendrerit est, sed commodo augue nisi non neque.Cras neque metus, consequat et blandit et, luctus a nunc. Etiam gravida vehicula tellus, in imperdiet ligula euismod eget. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam erat mi, rutrum at sollicitudin rhoncus', 20, 0, 359.00, 300.00, 1, 1, 1, 'product-details-img4.jpg'),
(2, 1, 'MENS SPORTS LATHER', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam fringilla augue nec est tristique auctor. Ipsum metus feugiat sem, quis fermentum turpis eros eget velit. Donec ac tempus ante. Fusce ultricies massa massa. Fusce aliquam, purus eget sagittis vulputate, sapien libero hendrerit est, sed commodo augue nisi non neque.Cras neque metus, consequat et blandit et, luctus a nunc. Etiam gravida vehicula tellus, in imperdiet ligula euismod eget. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam erat mi, rutrum at sollicitudin rhoncus', 15, 0, 359.00, 300.00, 0, 0, 1, 'product-details-img4.jpg'),
(3, 1, 'QUICKIIN MENS SHOES', 'qwe', 28, 2, 289.00, 200.00, 1, 1, 2, 'product-1.jpg'),
(4, 6, 'QUICKIIN MENS SHOES', 'qwe', 10, 0, 289.00, 200.00, 0, 0, 2, 'product-1.jpg'),
(5, 21, 'WOMENS HIGH HILLS', 'women shoes with good quality', 34, 11, 599.00, 400.00, 0, 1, 1, 'product-2.jpg'),
(6, 22, 'WOMENS HIGH HILLS', 'women shoes with good quality', 16, 0, 599.00, 400.00, 1, 1, 1, 'product-2.jpg'),
(7, 20, 'WOMENS HIGH HILLS', 'women shoes with good quality', 17, 3, 599.00, 400.00, 0, 1, 1, 'product-2.jpg'),
(8, 10, 'LEATHER MENS SLIPPERS', 'Most of the men like to wear', 50, 0, 699.00, 550.00, 0, 0, 3, 'product-3.jpg'),
(9, 11, 'LEATHER MENS SLIPPERS', 'Most of the men like to wear', 15, 0, 699.00, 550.00, 0, 1, 3, 'product-3.jpg'),
(10, 22, 'REXPO WOMENS SHOES', 'Sport shoes just for women when playing basketball', 29, 0, 499.00, 400.00, 0, 1, 3, 'product-4.jpg'),
(11, 20, 'REXPO WOMENS SHOES', 'Sport shoes just for women when playing basketball', 9, 1, 499.00, 400.00, 1, 1, 3, 'product-4.jpg'),
(12, 7, 'PRIMITIVE MENS SHOES', 'let\'s go', 15, 0, 799.00, 650.00, 0, 1, 4, 'product-5.jpg'),
(13, 1, 'PRIMITIVE MENS SHOES', 'let\'s go', 20, 0, 799.00, 650.00, 1, 1, 4, 'product-5.jpg'),
(14, 4, 'Nike MENS SHOES', 'Just good for walking', 25, 0, 499.00, 300.00, 0, 0, 1, 'product-6.jpg'),
(15, 9, 'Nike MENS SHOES', 'Just good for walking', 10, 0, 499.00, 300.00, 0, 1, 1, 'product-6.jpg'),
(16, 26, 'Run Faster Women', 'Can let women run quickly', 35, 0, 759.00, 650.00, 1, 1, 2, 'product-7.jpg'),
(17, 27, 'Run Faster Women', 'Can let women run quickly', 28, 0, 759.00, 650.00, 0, 1, 2, 'product-7.jpg'),
(18, 5, 'Sport Men Kick', 'Just can kick very power', 20, 0, 589.00, 500.00, 0, 0, 4, 'product-8.jpg'),
(19, 9, 'Sport Men Kick', 'Just can kick very power', 21, 0, 589.00, 500.00, 0, 1, 4, 'product-8.jpg'),
(20, 25, 'Just Kick And Goal', 'Let women kick powerful', 24, 0, 599.00, 510.00, 0, 0, 4, 'product-9.jpg'),
(21, 1, 'Just Kick And Goal', 'Let women kick powerful', 15, 0, 599.00, 510.00, 1, 1, 4, 'product-9.jpg'),
(22, 8, 'Just Believe Can Fly', 'Let men can jump high that like to be fly', 50, 0, 699.00, 590.00, 0, 0, 3, 'product-10.jpg'),
(23, 13, 'Just Believe Can', 'Let men can jump high that like to be flyasdadasdasd', 27, 0, 899.00, 490.00, 1, 0, 2, 'product-10.jpg'),
(24, 6, 'Women Flash Shoes', 'Let the women running become a flash', 12, 0, 599.00, 500.00, 0, 0, 2, 'product-details-img3.jpg'),
(25, 1, 'Women Flash Shoes', 'Let the women running become a flash', 20, 0, 99999.99, 1000.00, 0, 0, 2, 'product-details-img3.jpg'),
(26, 23, 'Product 1', 'product demo', 50, 0, 12.00, 5.00, 0, 0, 8, '319560493_705665844211786_7301884689113764996_n.jpg'),
(27, 9, 'ABC', 'test', 5, 3, 124.00, 242.00, 0, 0, 5, '319560493_705665844211786_7301884689113764996_n.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `PC_ID` int(2) NOT NULL,
  `Category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`PC_ID`, `Category`) VALUES
(1, 'lifestyle'),
(2, 'Running'),
(3, 'Basketball'),
(4, 'Football'),
(5, 'Kids');

-- --------------------------------------------------------

--
-- Table structure for table `product_delete`
--

CREATE TABLE `product_delete` (
  `Pd_Id` int(25) NOT NULL,
  `Product_ID` int(25) NOT NULL,
  `Description` text NOT NULL,
  `Date_of_delete` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_delete`
--

INSERT INTO `product_delete` (`Pd_Id`, `Product_ID`, `Description`, `Date_of_delete`) VALUES
(1, 26, 'demo', '2024-07-01'),
(2, 27, 'Demo ', '2024-07-03');

-- --------------------------------------------------------

--
-- Table structure for table `product_quantity_change`
--

CREATE TABLE `product_quantity_change` (
  `id` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Quantity_Change` int(11) DEFAULT NULL,
  `Change_Type` char(1) DEFAULT NULL,
  `Change_Date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_quantity_change`
--

INSERT INTO `product_quantity_change` (`id`, `Product_ID`, `Description`, `Quantity_Change`, `Change_Type`, `Change_Date`) VALUES
(1, 26, 'aqwe', 4, '+', '2024-07-01 06:07:49'),
(2, 27, 'Reload the  shoes', 5, '+', '2024-07-03 06:41:05');

-- --------------------------------------------------------

--
-- Table structure for table `record_time`
--

CREATE TABLE `record_time` (
  `ID` int(4) NOT NULL,
  `Product_ID` int(4) NOT NULL,
  `record_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `record_time`
--

INSERT INTO `record_time` (`ID`, `Product_ID`, `record_time`) VALUES
(1, 1, '2024-06-18 20:36:05'),
(2, 2, '2024-06-18 20:36:38'),
(3, 3, '2024-06-18 20:39:35'),
(4, 4, '2024-06-18 20:40:24'),
(5, 5, '2024-06-18 20:41:41'),
(6, 6, '2024-06-18 20:42:09'),
(7, 7, '2024-06-18 20:42:42'),
(8, 8, '2024-06-18 20:43:37'),
(9, 9, '2024-06-18 20:44:16'),
(10, 10, '2024-06-18 20:45:39'),
(11, 11, '2024-06-18 20:46:19'),
(12, 12, '2024-06-18 20:48:20'),
(13, 13, '2024-06-18 20:52:33'),
(14, 14, '2024-06-18 21:03:43'),
(15, 15, '2024-06-18 21:04:27'),
(16, 16, '2024-06-18 21:05:50'),
(17, 17, '2024-06-18 21:06:29'),
(18, 18, '2024-06-18 21:12:57'),
(19, 19, '2024-06-18 21:13:51'),
(20, 20, '2024-06-18 21:16:26'),
(21, 21, '2024-06-18 21:17:11'),
(22, 22, '2024-06-18 21:18:31'),
(23, 23, '2024-06-18 21:19:10'),
(24, 24, '2024-06-29 15:02:22'),
(25, 25, '2024-06-29 15:03:06'),
(26, 26, '2024-07-01 14:07:22'),
(27, 27, '2024-07-03 14:38:48');

-- --------------------------------------------------------

--
-- Table structure for table `size`
--

CREATE TABLE `size` (
  `Size_ID` int(2) NOT NULL,
  `gender` int(1) NOT NULL,
  `Size` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `size`
--

INSERT INTO `size` (`Size_ID`, `gender`, `Size`) VALUES
(1, 0, 5.5),
(2, 0, 6),
(3, 0, 6.5),
(4, 0, 7),
(5, 0, 7.5),
(6, 0, 8),
(7, 0, 8.5),
(8, 0, 9),
(9, 0, 9.5),
(10, 0, 10),
(11, 0, 10.5),
(12, 0, 11),
(13, 0, 11.5),
(14, 0, 12.5),
(15, 0, 13.5),
(16, 0, 14.5),
(17, 0, 15.5),
(18, 1, 2),
(19, 1, 2.5),
(20, 1, 3),
(21, 1, 3.5),
(22, 1, 4),
(23, 1, 4.5),
(24, 1, 5),
(25, 1, 5.5),
(26, 1, 6),
(27, 1, 6.5),
(28, 1, 7),
(29, 1, 7.5),
(30, 1, 8),
(31, 1, 8.5),
(32, 1, 9),
(33, 1, 9.5),
(34, 1, 10);

-- --------------------------------------------------------

--
-- Table structure for table `time_record`
--

CREATE TABLE `time_record` (
  `Record_ID` int(3) NOT NULL,
  `Admin_ID` int(2) NOT NULL,
  `Login_Time` datetime NOT NULL,
  `Logout_TIme` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_record`
--

INSERT INTO `time_record` (`Record_ID`, `Admin_ID`, `Login_Time`, `Logout_TIme`) VALUES
(1, 1, '2024-06-18 20:32:34', '2024-06-18 21:26:15'),
(2, 1, '2024-06-18 21:26:34', '2024-06-18 21:27:38'),
(3, 1, '2024-06-18 21:27:41', '2024-06-18 21:27:53'),
(4, 1, '2024-06-18 22:28:35', '2024-06-18 22:39:29'),
(5, 1, '2024-06-29 14:57:52', '2024-06-29 15:13:50'),
(6, 1, '2024-06-29 15:13:59', '2024-06-29 15:14:05'),
(7, 1, '2024-07-01 14:00:43', '2024-07-01 14:10:01'),
(8, 2, '2024-07-01 14:10:11', '2024-07-01 14:10:27'),
(9, 1, '2024-07-01 15:23:49', '2024-07-02 11:31:09'),
(10, 1, '2024-07-02 11:31:14', '2024-07-02 11:34:44'),
(11, 1, '2024-07-02 11:38:28', '2024-07-02 22:15:42'),
(12, 1, '2024-07-03 10:49:42', '2024-07-03 10:50:07'),
(13, 1, '2024-07-03 11:55:16', '2024-07-03 11:55:50'),
(14, 1, '2024-07-03 13:22:14', '2024-07-03 13:22:18'),
(15, 1, '2024-07-03 14:17:49', '2024-07-03 14:20:17'),
(16, 1, '2024-07-03 14:22:02', '2024-07-03 14:22:40'),
(17, 4, '2024-07-03 14:22:53', '2024-07-03 14:35:19'),
(18, 1, '2024-07-03 14:35:21', '2024-07-03 14:36:10'),
(19, 1, '2024-07-03 14:37:17', '2024-07-03 14:37:48'),
(20, 1, '2024-07-03 14:38:09', '2024-07-03 14:49:39'),
(21, 1, '2024-07-11 14:33:11', '2024-07-11 14:35:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`Admin_ID`);

--
-- Indexes for table `bill_master`
--
ALTER TABLE `bill_master`
  ADD PRIMARY KEY (`Invoice_ID`);

--
-- Indexes for table `bill_master_transaction`
--
ALTER TABLE `bill_master_transaction`
  ADD PRIMARY KEY (`Item_ID`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`Cart_ID`);

--
-- Indexes for table `cart_item`
--
ALTER TABLE `cart_item`
  ADD PRIMARY KEY (`CI_ID`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_ID`),
  ADD UNIQUE KEY `unique_customer_email` (`Customer_Email`) USING HASH;

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`PC_ID`);

--
-- Indexes for table `product_delete`
--
ALTER TABLE `product_delete`
  ADD PRIMARY KEY (`Pd_Id`);

--
-- Indexes for table `product_quantity_change`
--
ALTER TABLE `product_quantity_change`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Product_ID` (`Product_ID`);

--
-- Indexes for table `record_time`
--
ALTER TABLE `record_time`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `size`
--
ALTER TABLE `size`
  ADD PRIMARY KEY (`Size_ID`);

--
-- Indexes for table `time_record`
--
ALTER TABLE `time_record`
  ADD PRIMARY KEY (`Record_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `Admin_ID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bill_master`
--
ALTER TABLE `bill_master`
  MODIFY `Invoice_ID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `bill_master_transaction`
--
ALTER TABLE `bill_master_transaction`
  MODIFY `Item_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `Cart_ID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `cart_item`
--
ALTER TABLE `cart_item`
  MODIFY `CI_ID` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `Customer_ID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `Product_ID` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `PC_ID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_delete`
--
ALTER TABLE `product_delete`
  MODIFY `Pd_Id` int(25) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_quantity_change`
--
ALTER TABLE `product_quantity_change`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `record_time`
--
ALTER TABLE `record_time`
  MODIFY `ID` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `size`
--
ALTER TABLE `size`
  MODIFY `Size_ID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `time_record`
--
ALTER TABLE `time_record`
  MODIFY `Record_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
