# auto-repair-shop-database

<img width="3497" height="1362" alt="ERD" src="https://github.com/user-attachments/assets/f2175c16-dae8-4bb6-b3d7-a2cbad249a3c" />

This is a fully normalized relational database system I built for managing auto repair shop operations. Designed to handle customers, vehicles, employees, repair orders, parts inventory, invoicing, and payments.

This database includes: 10+ tables, views and triggers, and 9 example business-use queries.


Schema Overview:
customer, vehicle, make, model, employee, job, serviceType, repairOrder, repairLineItem, part, partUsed, invoice, payment

Includes a trigger that automatically recalculates the invoice total when a new part is added to a repair line item, this is to keep the billing accurate without manual updates.

Queries cover the following:
• Open repair orders by assigned mechanic
• Looking up a vehicle's full repair history by VIN
• Monthly revenue reporting
• Top 10 customers by total spend
• Most performed services
• Most performed services
• Employee labor revenue
• Parts usage and inventory tracking
• Unpaid invoice tracking


