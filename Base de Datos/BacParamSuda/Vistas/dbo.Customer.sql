USE [BacParamSuda]
GO
/****** Object:  View [dbo].[Customer]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Customer]
as

	SELECT 'CustomerID'                                  = cltur.customerid
		 , 'Mnemonic'                                    = ltrim(rtrim(( select top 1 Mnemotecnico
														     from clienteTuring
														    where clienteTuring.rut = cl.clrut )))
		 , 'Description'                                 = ltrim(rtrim(( select top 1 descripcion
														     from clienteTuring
														    where clienteTuring.rut = cl.clrut )))
		 , 'Rut'                                         = cl.clrut
		 , 'RutDigit'                                    = cl.cldv
		 , 'LocationID'                                  = cltur.locationid
		 , 'StatusID'                                    = cltur.statusid
		 , 'CreatorUserID'                               = cltur.creatoruserid
		 , 'CreatorDate'                                 = cltur.creatordate
	  FROM Cliente			cl
	     , ClienteTuring	cltur
	 where cl.clrut = cltur.rut
	   and cl.clcodigo = cltur.codigocliente
     group 
        by cltur.customerid
		 , cl.clrut
		 , cl.cldv
		 , cltur.locationid
		 , cltur.statusid
		 , cltur.creatoruserid
		 , cltur.creatordate

GO
