USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Clientes_Opciones]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[Sp_Clientes_Opciones]  AS BEGIN			
     SET NOCOUNT ON 			
	select * from LNKBAC.BacParamsuda.dbo.Cliente -- where     

     			
END	

GO
