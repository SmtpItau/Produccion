USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_OMA_EXTERNAS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- ======================================================================  
-- Author:  ASVG  
-- Create date: 20111013  
-- Description: Genera la "consulta traders" equivalente a eIBS.  
--    Entrega detalle de todas las operaciones C/V USD.  
--    Entrega cuadro resumen.  
-- Test Case :  
--  
-- insert into TBL_OPERACIONES_OMA_EXTERNAS (Fecha,FolioContrato,TipoTransaccion,MtoDolares,TipoCambio,MtoPesos,CodigoOMA,Estado,RutCliente,NombreCliente,Notificada)  
-- VALUES ('20111012',1,'C',10000,480.00,4800000,333,'',14118681,'Alan','')  
--  
-- insert into TBL_OPERACIONES_OMA_EXTERNAS (Fecha,FolioContrato,TipoTransaccion,MtoDolares,TipoCambio,MtoPesos,CodigoOMA,Estado,RutCliente,NombreCliente,Notificada)  
-- VALUES ('20111012',7,'C',1000,400.00,400000,333,'',16490291,'Jorge','')  
--  
-- insert into TBL_OPERACIONES_OMA_EXTERNAS (Fecha,FolioContrato,TipoTransaccion,MtoDolares,TipoCambio,MtoPesos,CodigoOMA,Estado,RutCliente,NombreCliente,Notificada)  
-- VALUES ('20111012',8,'V',5000,500.00,2500000,333,'',14118681,'Alan','')  
--  
-- exec SP_CONSULTA_OPERACIONES_OMA_EXTERNAS '20110101','20111212'  
-- select * from costos_comex  
-- exec SP_CONSULTA_OPERACIONES_OMA_EXTERNAS '20110101','20110101'  
--  
-- update TBL_OPERACIONES_OMA_EXTERNAS set Notificada = ''  
-- select Notificada,* from TBL_OPERACIONES_OMA_EXTERNAS  
-- ======================================================================  

CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_OMA_EXTERNAS]
 (  
  @FechaDesde datetime,  
  @FechaHasta datetime  
 )  
AS  
BEGIN  
SET NOCOUNT ON  
  
-- SET @FechaDesde = CONVERT(CHAR(8), @FechaDesde, 112)  
-- SET @FechaHasta = CONVERT(CHAR(8), @FechaHasta, 112)  
--(SELECT acfecpro FROM dbo.MEAC)  
 DECLARE @TotalCompras AS numeric(18,4);  
 SET @TotalCompras = 0;  
 DECLARE @TotalVentas AS numeric(18,4);  
 SET @TotalVentas = 0;  
  
 DECLARE @AcumuladoCompras AS numeric(18,4);  
 SET @AcumuladoCompras = 0;  
 DECLARE @AcumuladoVentas AS numeric(18,4);  
 SET @AcumuladoVentas = 0;  
  
 BEGIN TRANSACTION  
  --primer datatable  
  select	TipoTransaccion as [TT],
			TipoCambio as [TC],
			MtoDolares,
			Fecha,
			RutCliente as Rut,
			NombreCliente as Nombre,
			FolioContrato as Folio  
  from		TBL_OPERACIONES_OMA_EXTERNAS 
  where		Fecha between @FechaDesde AND @FechaHasta  
  
  select	@TotalCompras = SUM(MtoDolares)
			, @AcumuladoCompras = SUM(MtoDolares * TipoCambio)
 from TBL_OPERACIONES_OMA_EXTERNAS
 where Fecha between @FechaDesde AND @FechaHasta  
  AND TipoTransaccion = 'C'  


  SET @TotalCompras = ISNULL( @TotalCompras,0);  
  SET @AcumuladoCompras = ISNULL( @AcumuladoCompras,0);  
  
  select @TotalVentas = SUM(MtoDolares)
  , @AcumuladoVentas = SUM(MtoDolares * TipoCambio)
  from TBL_OPERACIONES_OMA_EXTERNAS
  where Fecha between @FechaDesde AND @FechaHasta  
  AND TipoTransaccion = 'V'  
  
  
  SET @TotalVentas = ISNULL( @TotalVentas,0);  
  SET @AcumuladoVentas = ISNULL( @AcumuladoVentas,0);  
  
  --segundo datatable  
  select  @TotalCompras      AS [Total Compras]  
    ,CASE @TotalCompras WHEN 0 THEN 0 ELSE @AcumuladoCompras/@TotalCompras END AS [Precio Compras]  
    ,@TotalVentas      AS [Total Ventas]  
    ,CASE @TotalVentas WHEN 0 THEN 0 ELSE @AcumuladoVentas/@TotalVentas END AS [Precio Ventas]  
    ,( @TotalCompras - @TotalVentas )   AS [Saldo Neto]  
    ,CASE ( @TotalCompras + @TotalVentas ) WHEN 0 THEN 0 ELSE ( @AcumuladoCompras + @AcumuladoVentas ) / ( @TotalCompras + @TotalVentas ) END AS [Precio Neto]  
  
 COMMIT TRANSACTION  
END

GO
