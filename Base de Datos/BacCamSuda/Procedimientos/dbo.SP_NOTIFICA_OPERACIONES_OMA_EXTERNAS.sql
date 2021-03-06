USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NOTIFICA_OPERACIONES_OMA_EXTERNAS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- ======================================================================  
-- Author:  ASVG  
-- Create date: 20111013  
-- Description: Muestra reporte de operaciones a notificar.  
--    Si se invoca con parámetro, marca la operación como notificada.  
-- Test Case :  
--  
--insert into TBL_OPERACIONES_OMA_EXTERNAS (Fecha,FolioContrato,TipoTransaccion,MtoDolares,TipoCambio,MtoPesos,CodigoOMA,Estado,RutCliente,NombreCliente,Notificada)  
--VALUES ('20111012',129,'C',10000,480.00,4800000,333,'',14118681,'Alan','')  
--  
-- exec SP_NOTIFICA_OPERACIONES_OMA_EXTERNAS  
-- exec SP_NOTIFICA_OPERACIONES_OMA_EXTERNAS 123  
--  
-- update TBL_OPERACIONES_OMA_EXTERNAS set Notificada = ''  
-- select Notificada,* from TBL_OPERACIONES_OMA_EXTERNAS  
-- ======================================================================  
  
CREATE PROCEDURE [dbo].[SP_NOTIFICA_OPERACIONES_OMA_EXTERNAS]  
 (  
  @FolioContrato numeric(9,0) = 0,
  @minimo  numeric(18,0) = 0,
  @maximo  numeric(18,0) = 0
 )  
AS  
BEGIN  
SET NOCOUNT ON  
  
 IF @FolioContrato = 0  
 BEGIN  

 SELECT Fecha,  
   FolioContrato as Folio,    
   CASE TipoTransaccion WHEN 'C' THEN 'Compra' ELSE 'Venta' END AS [Operación],  
   CONVERT(VARCHAR,CONVERT(MONEY,MtoDolares),1) as [Dólares],  
   CONVERT(VARCHAR,CONVERT(MONEY,(TipoCambio - SpreadComercial )),1) as [Precio],  
   CONVERT(VARCHAR,CONVERT(MONEY,MtoPesos),1) as [Pesos],     
   RutCliente as Rut,  
   NombreCliente as Cliente  
  FROM TBL_OPERACIONES_OMA_EXTERNAS  
  WHERE Notificada = ''  
  AND MTODOLARES BETWEEN @MINIMO AND @MAXIMO
 END  
  
 IF @FolioContrato != 0  
 BEGIN  
  UPDATE TBL_OPERACIONES_OMA_EXTERNAS set Notificada = 1 where FolioContrato = @FolioContrato  
  --return 1  
 END  
  
END
GO
