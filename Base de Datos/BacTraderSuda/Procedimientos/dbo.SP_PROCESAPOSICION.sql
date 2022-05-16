USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PROCESAPOSICION]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_PROCESAPOSICION]
AS
BEGIN
   PRINT 'A'
     /* 
 ==================================================================
 Fixed Income
  1.- Compras propias     -> Valor Mcdo.
  2.- Col.Inter. / Compras c/n Pacto    -> Valor Presente
  3.- Cap.Inter. / Ventas  c/n Pacto  -> valor Presente
 Forward 
  1.- Seguros de Cambios   
      (Compras us$ - Ventas us$)  +/- (Long / Short)
      (Compras $$/UF - Ventas $$/UF)  
 ================================================================== */
END

GO
