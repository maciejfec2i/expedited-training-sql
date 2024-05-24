USE classicmodels;

DROP PROCEDURE IF EXISTS purchase;

DELIMITER //

CREATE PROCEDURE purchase()
BEGIN

	START TRANSACTION;

	SET @customerNumber = 103;
	# orderNumber does not have AUTO_INCREMENT set
	# using the below to mimic similar behaviour
	SET @orderNum = NULL;
	SELECT MAX(orderNumber) + 1 INTO @orderNum FROM orders;

	INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, comments, customerNumber) VALUES
	(@orderNum, CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 10 DAY), NULL, "In Process", NULL, @customerNumber);

	SET @orderLineNum = NULL;
	SELECT MAX(orderLineNumber) + 1 INTO @orderLineNum FROM orderdetails;

	INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber) VALUES
	(@orderNum, "S10_1678", 100, 95.70, @orderLineNum);

	IF (SELECT quantityOrdered * priceEach FROM orderdetails WHERE orderLineNumber = @orderLineNum) > (SELECT creditLimit FROM customers WHERE customerNumber = @customerNumber) THEN
		ROLLBACK;
        SIGNAL SQLSTATE "45000"
			SET MESSAGE_TEXT = "order price exceeds credit limit";
    ELSE
		ROLLBACK;
	END IF;
END //

DELIMITER ;

CALL purchase();