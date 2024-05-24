USE classicmodels;

DROP TEMPORARY TABLE IF EXISTS ordersarchive;
DROP TEMPORARY TABLE IF EXISTS orderdetailsarchive;
DROP PROCEDURE IF EXISTS transferOrdersToOrdersArchive;
DROP EVENT IF EXISTS archiveOrders;

CREATE TEMPORARY TABLE ordersarchive(
	SELECT * FROM orders LIMIT 0
);

CREATE TEMPORARY TABLE orderdetailsarchive(
	SELECT * FROM orderdetails LIMIT 0
);

DELIMITER //  
CREATE PROCEDURE transferOrdersToOrdersArchive(IN theDate DATE)
BEGIN
	START TRANSACTION;
		SET @validArchiveDate = DATE_SUB(theDate, INTERVAL 7 MONTH);
        
        INSERT INTO ordersarchive(
			SELECT * 
			FROM orders
			WHERE orderNumber IN(
				SELECT o.orderNumber
				FROM orders o
				WHERE (o.shippedDate <= @validArchiveDate OR o.shippedDate IS NULL) AND o.status NOT IN ('In Process', 'On Hold')
            )
		);
        
        INSERT INTO orderdetailsarchive(
			SELECT * 
			FROM orderdetails
			WHERE orderNumber IN(
				SELECT o.orderNumber
				FROM orders o
				WHERE (o.shippedDate <= @validArchiveDate OR o.shippedDate IS NULL) AND o.status NOT IN ('In Process', 'On Hold')
            )
		);
            
		DELETE FROM orderdetails
		WHERE orderNumber IN(
			SELECT oa.orderNumber
			FROM ordersarchive oa
        );
            
		# NOTE TO SELF: made mistake here as did not first delete corresponding records in the orderdetails table
		# so ended up with a "cannot delete or update a parent row" due to foreign key constraint
		DELETE FROM orders
		WHERE orderNumber IN(
			SELECT oa.orderNumber
			FROM ordersarchive oa
        );
            
		SELECT * FROM orders;
        SELECT * FROM ordersarchive;
        SELECT * FROM orderdetails;
 		SELECT * FROM orderdetailsarchive;
	ROLLBACK;
END //
DELIMITER ;

# Turns on event scheduling for current session
SET GLOBAL event_scheduler = ON;

CREATE EVENT archiveOrders
ON SCHEDULE EVERY 2 MINUTE STARTS NOW() ENDS DATE_ADD(CURRENT_DATE(), INTERVAL 7 DAY)
DO
	SET @date = DATE_SUB(CURRENT_DATE(), INTERVAL 19 YEAR);
	CALL transferOrdersToOrdersArchive(@date);

-- SHOW VARIABLES LIKE 'event_scheduler';
SELECT * FROM information_schema.events;