<?php
    include("config.php");
    session_start();

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // 检查是否登录
        if (!isset($_SESSION['Customer_ID'])) {
            header("Location: login.php");
            exit();
        }

        $customer_id = $_POST['customer_id'];
        $product_name = $_POST['product_name'];
        $size = $_POST['size'];
        $quantity = $_POST['quantity'];

        // 如果 $quantity 大于或等于9，则将其设置为9
        if ($quantity >= 9) {
            $quantity = 9;
        }
        
        // 获取 size_id
        $size_sql = "SELECT Size_ID FROM size WHERE Size = ?";
        $size_stmt = $conn->prepare($size_sql);
        $size_stmt->bind_param("s", $size);
        $size_stmt->execute();
        $size_result = $size_stmt->get_result();
        if ($size_result->num_rows > 0) {
            $size_row = $size_result->fetch_assoc();
            $size_id = $size_row['Size_ID'];
        } else {
            echo "Size not found";
            exit();
        }

        // 获取 product_id 和当前库存数量
        $product_sql = "SELECT Product_ID, Product_quantity_available FROM product WHERE Product_Name = ? AND Size_ID = ?";
        $product_stmt = $conn->prepare($product_sql);
        $product_stmt->bind_param("si", $product_name, $size_id);
        $product_stmt->execute();
        $product_result = $product_stmt->get_result();
        if ($product_result->num_rows > 0) {
            $product_row = $product_result->fetch_assoc();
            $product_id = $product_row['Product_ID'];
            $current_quantity = $product_row['Product_quantity_available'];
        } else {
            echo "Product not found";
            exit();
        }

        // 检查库存是否足够
        if ($current_quantity < $quantity) {
            echo "Not enough quantity available in stock";
            exit();
        }

        // 更新产品库存数量
        $updated_quantity = $current_quantity - $quantity;
        $update_product_sql = "UPDATE product SET Product_quantity_available = ? WHERE Product_ID = ?";
        $update_product_stmt = $conn->prepare($update_product_sql);
        $update_product_stmt->bind_param("ii", $updated_quantity, $product_id);
        $update_product_stmt->execute();

        // 获取 Cart ID
        $cart_sql = "SELECT Cart_ID FROM cart WHERE Customer_ID = ?";
        $cart_stmt = $conn->prepare($cart_sql);
        $cart_stmt->bind_param("i", $customer_id);
        $cart_stmt->execute();
        $cart_result = $cart_stmt->get_result();
        
        // 如果不存在购物车记录，插入新的 Customer_ID 到 cart 表
        if ($cart_result->num_rows === 0) {
            $insert_cart_sql = $conn->prepare("INSERT INTO cart (Customer_ID) VALUES (?)");
            $insert_cart_sql->bind_param("i", $_SESSION['Customer_ID']);
            $insert_cart_sql->execute();
            // 再次获取 Cart ID
            $cart_stmt->execute();
            $cart_result = $cart_stmt->get_result();
        }
        
        if ($cart_result->num_rows > 0) {
            $cart_row = $cart_result->fetch_assoc();
            $cart_id = $cart_row['Cart_ID'];

            // 检查是否存在相同的 cart_id 和 product_id
            $existing_item_sql = "SELECT * FROM cart_item WHERE Cart_ID = ? AND Product_ID = ?";
            $existing_item_stmt = $conn->prepare($existing_item_sql);
            $existing_item_stmt->bind_param("ii", $cart_id, $product_id);
            $existing_item_stmt->execute();
            $existing_item_result = $existing_item_stmt->get_result();

            if ($existing_item_result->num_rows > 0) {
                // 如果已经存在相同的记录，更新现有记录的数量
                $existing_item_row = $existing_item_result->fetch_assoc();
                $existing_quantity = $existing_item_row['Quantity'];
                $new_quantity = $existing_quantity + $quantity;

                $update_item_sql = "UPDATE cart_item SET Quantity = ? WHERE Cart_ID = ? AND Product_ID = ? AND CI_Status = 0";
                $update_item_stmt = $conn->prepare($update_item_sql);
                $update_item_stmt->bind_param("iii", $new_quantity, $cart_id, $product_id);
                $update_item_stmt->execute();

                header("Location: update_total_price.php");
                header("Location: cart.php");
                exit();
            }
        }

        // 如果不存在相同的记录，插入新的记录
        $insert_item_sql = "INSERT INTO cart_item (Cart_ID, Product_ID, Quantity, CI_Status) VALUES (?, ?, ?, 0)";
        $insert_item_stmt = $conn->prepare($insert_item_sql);
        $insert_item_stmt->bind_param("iii", $cart_id, $product_id, $quantity);
        if ($insert_item_stmt->execute()) {
            header("Location: update_total_price.php");
            header("Location: cart.php");
            exit();
        } else {
            echo "Failed to add to cart";
        }
    } else {
        header("Location: home.php");
        exit();
    }
?>
