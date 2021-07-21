select * into kundeneu from Customers where Country in ('UK','Italy', 'Germany')




select * from Customers
except
select * from kundeneu


select * from Kundeneu
except
select * from Customers








use demodb




drop table Customers




USE [demodb]
GO

/****** Object:  Table [dbo].[customers]    Script Date: 21.07.2021 09:57:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customers](
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL
) ON [PRIMARY]
GO

set identity_insert dbo.customers on

insert into customers
select * from Northwind.dbo.customers

select * into customers from nwindbig.dbo.customers

select * from sys.tables