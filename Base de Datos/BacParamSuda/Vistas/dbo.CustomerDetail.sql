USE [BacParamSuda]
GO
/****** Object:  View [dbo].[CustomerDetail]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[CustomerDetail]
as

	SELECT 'CustomerDetailID'                            = DetailCustomerID
		 , 'CustomerID'                                  = customerid
		 , 'CustomerSequence'                            = Secuencia
		 , 'Description'                                 = ltrim(rtrim(descripcion))
		 , 'StatusID'                                    = statusid
		 , 'CreatorUserID'                               = creatoruserid
		 , 'CreatorDate'                                 = creatordate
	  FROM ClienteTuring
GO
