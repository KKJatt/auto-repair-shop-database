-- Auto Repair Shop Database

-- Karanjot Singh Kailay




-- Two Views

-- View 1 Repair Order Information
-- This view combines customer, vehicle, and assigned employee details
-- so the information does not need to be joined repeatedly

CREATE VIEW viewRepairOrderInfo AS
SELECT
  ro.repairOrderID,
  ro.dateIn,
  ro.status,
  c.custFirstName,
  c.custLastName,
  v.vin,
  v.year,
  e.empFirstName,
  e.empLastName
FROM repairOrder ro
JOIN vehicle v ON ro.vehicleID = v.vehicleID
JOIN customer c ON v.customerID = c.customerID
JOIN employee e ON ro.employeeID = e.employeeID;



-- View 2
-- Invoice payment status
-- This view shows invoices and the payment information linked to the invoice if there is one
-- Useful to quickly see if a invoice has been paid and the method and date of the payment

CREATE VIEW viewInvoicePaymentStatus AS
SELECT
  i.invoiceID,
  i.invoiceDate,
  i.totalAmount,

  p.paymentDate,
  p.amount,
  p.paymentMethod
FROM invoice i
LEFT JOIN payment p ON i.invoiceID = p.invoiceID;




-- Trigger
-- invoice part calculation
-- This trigger is useful because now it cna recalculate any new line add ons to the repair
-- when a partUsed is inserted so meaning a repairLine had a part used on it, then it will update the invoice total with the labor rate and new part costs



DELIMITER $$

CREATE TRIGGER partUsed_after_insert
AFTER INSERT ON partUsed
FOR EACH ROW
BEGIN
  UPDATE invoice
  SET totalAmount =
    (
      SELECT SUM(rl.laborHours * rl.laborRate)
      FROM repairLineItem rl
      WHERE rl.repairOrderID =
        (SELECT repairOrderID
         FROM repairLineItem
         WHERE repairLineItemID = NEW.repairLineItemID)
    )
    +
    (
      SELECT SUM(pu.quantityUsed * pu.unitPriceAtUse)
      FROM partUsed pu
      JOIN repairLineItem rl2 ON pu.repairLineItemID = rl2.repairLineItemID
      WHERE rl2.repairOrderID =
        (SELECT repairOrderID
         FROM repairLineItem
         WHERE repairLineItemID = NEW.repairLineItemID)
    )
  WHERE repairOrderID =
    (SELECT repairOrderID
     FROM repairLineItem
     WHERE repairLineItemID = NEW.repairLineItemID);
END $$

DELIMITER ;




-- Queries 


-- Query 1
-- Manager can easily see what's getting worked on in the shop and which employee is working on it

SELECT ro.repairOrderID, ro.dateIn, ro.status, e.empFirstName, e.empLastName, mk.makeName, m.modelName, v.year, v.vin
FROM repairOrder ro
JOIN employee e ON ro.employeeID = e.employeeID
JOIN vehicle v ON ro.vehicleID = v.vehicleID
JOIN model m ON v.modelID = m.modelID
JOIN make mk ON m.makeID = mk.makeID
WHERE NOT ro.status = 'Closed'
ORDER BY ro.dateIn;


-- Query 2
-- Lets you select a specific car from the vin 


SELECT ro.repairOrderID, ro.dateIn, ro.status, st.serviceName, rli.laborHours, rli.laborRate
FROM vehicle v
JOIN repairOrder ro ON v.vehicleID = ro.vehicleID
JOIN repairLineItem rli ON ro.repairOrderID = rli.repairOrderID
JOIN serviceType st ON rli.serviceTypeID = st.serviceTypeID
WHERE v.vin = '1HGCM82633A004111' -- THIS is where u can change the vin to whatever car you wanna see
ORDER BY ro.dateIn DESC;



-- Query 3
-- Gives you revenue information based on the year and month

SELECT YEAR(i.invoiceDate) AS yr, MONTH(i.invoiceDate) AS mo, SUM(i.totalAmount) AS totalRevenue
FROM invoice i
GROUP BY YEAR(i.invoiceDate), MONTH(i.invoiceDate)
ORDER BY yr, mo;


-- Query 4
-- This gives you your top spending customers up to the top 10, good for giving gifts back to top customers

SELECT c.customerID, c.custFirstName, c.custLastName, SUM(i.totalAmount) AS totalSpent
FROM customer c
JOIN vehicle v ON c.customerID = v.customerID
JOIN repairOrder ro ON v.vehicleID = ro.vehicleID
JOIN invoice i ON ro.repairOrderID = i.repairOrderID
GROUP BY c.customerID, c.custFirstName, c.custLastName
ORDER BY totalSpent DESC
LIMIT 10;


-- Query 5
-- This shows you what service the shop performs the most

SELECT st.serviceName, COUNT(*) AS timesPerformed
FROM repairLineItem rli
JOIN serviceType st ON rli.serviceTypeID = st.serviceTypeID
GROUP BY st.serviceName
ORDER BY timesPerformed DESC;



-- Query 6
-- This shows you how much employees have made for the shop from labor revenue to see top performing employees 

SELECT e.employeeID, e.empFirstName, e.empLastName, SUM(rli.laborHours * rli.laborRate) AS laborRevenue
FROM employee e
JOIN repairOrder ro ON e.employeeID = ro.employeeID
JOIN repairLineItem rli ON ro.repairOrderID = rli.repairOrderID
GROUP BY e.employeeID, e.empFirstName, e.empLastName
ORDER BY laborRevenue DESC;


-- Query 7
-- This is to see how much of each part is being used, helpful to see what the shop needs to order more of

SELECT p.partName, SUM(pu.quantityUsed) AS totalQuantityUsed
FROM partUsed pu
JOIN part p ON pu.partID = p.partID
GROUP BY p.partName
ORDER BY totalQuantityUsed DESC;


-- Query 8
-- This shows repair orders with no parts, this can see all diagnostic jobs only nad make it easier to spot jobs that forgot to put a part used into the repair line item

SELECT ro.repairOrderID, ro.dateIn, ro.status
FROM repairOrder ro
JOIN repairLineItem rli ON ro.repairOrderID = rli.repairOrderID
LEFT JOIN partUsed pu ON rli.repairLineItemID = pu.repairLineItemID
WHERE pu.partUsedID IS NULL;


-- Query 9
-- This shows invoices that haven't been paid yet 

SELECT i.invoiceID, i.invoiceDate, i.totalAmount, ro.repairOrderID, c.custFirstName, c.custLastName
FROM invoice i
JOIN repairOrder ro ON i.repairOrderID = ro.repairOrderID
JOIN vehicle v ON ro.vehicleID = v.vehicleID
JOIN customer c ON v.customerID = c.customerID
LEFT JOIN payment p ON i.invoiceID = p.invoiceID
WHERE p.paymentID IS NULL
ORDER BY i.invoiceDate;
