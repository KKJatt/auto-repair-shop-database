# Auto Repair Shop Database

A fully normalized relational database system I built for managing auto repair shop operations. 
Handles customers, vehicles, employees, repair orders, parts inventory, invoicing, and payments.

![ERD](https://github.com/user-attachments/assets/f2175c16-dae8-4bb6-b3d7-a2cbad249a3c)

## Built With
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

## Features
- 13 normalized tables with primary and foreign key relationships
- 2 views for common data lookups without repeated joins
- 1 trigger that automatically recalculates the invoice total when a new part is added to a repair line item, keeping billing accurate without manual updates
- 9 business-use queries for real shop operations

## Business Rules
- Each repair order must be linked to one vehicle
- Each vehicle must belong to one customer
- A repair order must be assigned to one employee
- An invoice can only exist if a repair order is linked to it
- Each part used on a repair line item must be recorded in `partUsed` and reference the `part` table

## Queries
- Open repair orders by assigned mechanic
- Full repair history lookup by VIN
- Monthly revenue reporting
- Top 10 customers by total spend
- Most performed services
- Employee labor revenue by technician
- Parts usage and inventory tracking
- Unpaid invoice tracking

## Schema Overview
| Table | Description |
|---|---|
| `customer` | Customer contact information |
| `vehicle` | Vehicles linked to customers |
| `make` | Vehicle manufacturer |
| `model` | Vehicle model linked to make |
| `employee` | Employee details and job role |
| `job` | Job titles for employees |
| `serviceType` | Types of services the shop performs |
| `repairOrder` | Repair orders linked to vehicles and employees |
| `repairLineItem` | Individual service lines within a repair order |
| `part` | Parts inventory |
| `partUsed` | Parts used on specific repair line items |
| `invoice` | Invoices linked to repair orders |
| `payment` | Payment records linked to invoices |



## How to Run
1. Open MySQL Workbench or any MySQL client
2. Run `schema_and_data.sql` first to create and populate the database
3. Run `views_triggers_queries.sql` to create the views, trigger, and queries

## Sample Data

**customer**
| customerID | custFirstName | custLastName | phone | email |
|---|---|---|---|---|
| 1 | Alex | Rivera | 317-555-0101 | alex.rivera@email.com |
| 2 | Maya | Patel | 317-555-0102 | maya.patel@email.com |
| 3 | Jordan | Lee | 317-555-0103 | jordan.lee@email.com |

**vehicle**
| vehicleID | customerID | modelID | vin | year |
|---|---|---|---|---|
| 1 | 1 | 1 | 1HGCM82633A004111 | 2018 |
| 2 | 1 | 3 | 1FTFW1E50JFB12345 | 2020 |
| 3 | 2 | 2 | 2T1BURHE0JC123456 | 2016 |
| 4 | 3 | 4 | 3GCUKREC0JG123789 | 2019 |

**make**
| makeID | makeName |
|---|---|
| 1 | Toyota |
| 2 | Ford |
| 3 | Chevrolet |

**model**
| modelID | makeID | modelName |
|---|---|---|
| 1 | 1 | Camry |
| 2 | 1 | Corolla |
| 3 | 2 | F-150 |
| 4 | 3 | Silverado |

**employee**
| employeeID | empFirstName | empLastName | phone | email | jobID |
|---|---|---|---|---|---|
| 1 | Sidhu | Moosewala | 317-555-5911 | sidhu.moosewala@shop.com | 2 |
| 2 | Taylor | Brooks | 317-555-1244 | taylor.brooks@shop.com | 2 |
| 3 | Casey | Morgan | 317-555-1524 | casey.morgan@shop.com | 3 |

**job**
| jobID | jobTitle |
|---|---|
| 1 | Manager |
| 2 | Mechanic |
| 3 | Service Advisor |

**serviceType**
| serviceTypeID | serviceName | standardLaborHours |
|---|---|---|
| 1 | Oil Change | 1.00 |
| 2 | Brake Pad Replace | 2.50 |
| 3 | Tire Rotation | 0.75 |
| 4 | Diagnostic | 1.00 |

**part**
| partID | partName | partDescription | unitPrice |
|---|---|---|---|
| 1 | Oil Filter | Standard oil filter | 12.99 |
| 2 | Engine Oil 5W-30 | 1 quart synthetic blend | 8.49 |
| 3 | Brake Pads (Set) | Brake pad set | 79.99 |
| 4 | Brake Cleaner | Aerosol brake cleaner | 6.99 |
| 5 | Shop Supplies | Rags, gloves, small supplies fee | 5.00 |
