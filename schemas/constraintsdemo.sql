USE classicmodels;

DROP TABLE IF EXISTS productsrestock;
DROP EVENT IF EXISTS CheckStockLevelsEvent;

CREATE TABLE productsrestock(
	id INT NOT NULL AUTO_INCREMENT,
    productCode VARCHAR(15) NOT NULL,
    quantityRequired INT NOT NULL CHECK(quantityRequired >= 1000),
    vendor VARCHAR(50) NOT NULL,
    ordered BOOL DEFAULT false,
    orderedDate DATE DEFAULT null,
    arrived BOOL DEFAULT false,
    estimatedArrivalDate DATE DEFAULT null,
    
    PRIMARY KEY (id),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
) AUTO_INCREMENT = 100000;


INSERT INTO productsrestock (productCode, quantityRequired, vendor)
SELECT 
	p.productCode, 1000 AS quantityRequired, p.productVendor AS vendor
FROM products p
WHERE p.quantityInStock < 1000
AND p.productCode NOT IN (
	SELECT productCode
	FROM productsrestock
);
