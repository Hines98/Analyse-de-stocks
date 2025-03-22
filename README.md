# Car's model

## Project Scenario
Mint Classics company, a retailer of classic model cars and other vehicles, is looking at closing one of their storage facilities. 
To support a data-based business decision, they are looking for suggestions and recommendations for reorganizing or reducing inventory, while still maintaining timely service to their customers. For example, they would like to be able to ship a product to a customer within 24 hours of the order being placed.
As a data analyst, I have been asked to use MySQL Workbench to familiarize myself with the general business by examining the current data. The queries I will write should help to answer questions like these:
1) Where are items stored and if they were rearranged, could a warehouse be eliminated?
2) How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?
3) Are we storing items that are not moving? Are any items candidates for being dropped from the product line?

## Project Objectives
1. Explore products currently in inventory.
2. Determine important factors that may influence inventory reorganization/reduction.
3. Provide analytic insights and data-driven recommendations.

## Challenge
My challenge is to conduct an exploratory data analysis to investigate if there are any patterns or themes that may influence the reduction or reorganization of inventory in the Mint Classics storage facilities. 

## Analyse
### 1. Current Stock Distribution
Currently, the stock distribution per warehouse over the studied period (01-2003 to 05-2005) is as follows:
East Warehouse (b): 219,183 – Variety of cars
North Warehouse (a): 131,688 – Mix of motorcycles and airplanes
West Warehouse (c): 124,880 – Classic car models
South Warehouse (d): 79,380 – Trains, buses, boats, utility vehicles
A total of 110 product varieties are distributed across these four warehouses, with an average delivery time of 4 days for all locations.

### 2. Sales and Stock Analysis
The South Warehouse is the best-performing in terms of sales over the studied period. Its sales rate is 22%, indicating a faster stock turnover compared to other warehouses, which sold 14% to 16% of their stock.

Some high-selling products have relatively low stock levels compared to less popular items (see list). Their stock levels remain adequate but may require monitoring if demand continues to grow.

Conversely, some products with high stock levels are not selling proportionally or at all. For example:
- The ‘1999 Indy 500 Monte Carlo SS’ (865 units sold, 8,154 still in stock) has a low turnover.
- The ‘1985 Toyota Supra’ has 0 sales but 7,733 units in stock for the past two years.
This disproportionate stock accumulation leads to storage space immobilization, high storage costs, and liquidity issues.

Overall, 89 product varieties are in overstock, with 82% of the surplus concentrated in the North, East, and West warehouses.

### Conclusion & Recommendations
- Monitor high-demand products: Ensure stock levels are sufficient to avoid shortages.
- Reduce excess stock: Implement promotions, discounts, or resell to other distributors. Long-unsold items should be cleared or liquidated.
- Optimize storage costs: with reduced overstock and additional cost analysis (not provided here), we can identify the warehouse with the highest storage costs and determine if partial stock consolidation is feasible to close or downsize a site.
