---CREATE DATABASE------------
CREATE DATABASE GlobalProduct
----VIEW DATA-------------------------
SELECT * FROM products
----Which Product Category is Leading with how much stock------
Select Product_Category,sum(Stock_Quantity) Stock from products group by Product_Category order by 2 DESC
----What is the average price with respect to Product Category-------
Select Product_Category,avg(Price) AveragePrice from products  group by Product_Category order by 2 DESC
----Which Product Category is close to expiry date with how much stock and its product tag ------
Select Product_ID,Product_Category,Product_Tags,Expiration_Date,Stock_Quantity from products where Expiration_Date<CONVERT(date, getdate()) order by Expiration_Date DESC
----Find out how much waranty period leads to rating of Product Tags------------------------------------------
Select Product_Tags,Product_Ratings,Warranty_Period from products order by Product_Ratings desc
-----Which Color Size variation has the most ratings-----------------------------------------------------------
Select Color_Size_Variations,avg(Product_Ratings) Ratings from products group by Color_Size_Variations order by Ratings desc
----In Which month most products are manufactured-----------------------------------------------------------------------
Select MAX(MONTH(Manufacturing_Date)) from products
----------Find out every detail of the product with the maximum and minimum price----------------------------------------------------------
Select * FROM products where price = (SELECT MAX(price) FROM products) OR price = (SELECT MIN(price) FROM products);
----------Find out the Product ID,Product Name and product dimension starting from closest expiration date-------------------------------------------------------------------------
Select Product_ID,Product_Name,Product_Dimensions from products where Expiration_Date<Convert(date,getdate())
----------------Find out Product Description,Warranty Period,SKU,Product,Tags,Color,Size Variation-------------------------------------------------------------
Select Product_Description,Warranty_Period,SKU,Product_Name,Product_Tags,
case CHARINDEX('/', Color_Size_Variations) when 0 then Color_Size_Variations
        else SUBSTRING(Color_Size_Variations, 1, CHARINDEX('/', Color_Size_Variations) - 1) end Color,
 case CHARINDEX('/', Color_Size_Variations) when 0 then Color_Size_Variations
        else SUBSTRING(Color_Size_Variations, CHARINDEX('/', Color_Size_Variations) + 1, LEN(Color_Size_Variations)) end Size 
from products
----------Find out the Product ID,Name and Price with warranty less than 2 year and rating greater than 3-------------------------------------------------------------------------
Select Product_ID,Product_Name,Price from products where Warranty_Period<2 and Product_Ratings>3