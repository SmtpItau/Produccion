USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEE_COSTO]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LEE_COSTO]
AS BEGIN
 DECLARE @CostoCompra NUMERIC(19,4)
               ,@CostoVenta  NUMERIC(19,4)    
        
         SELECT @CostoCompra = accoscomp
               ,@CostoVenta  = accosvent
           FROM meac
 
 SELECT @CostoCompra,@CostoVenta
END

GO
