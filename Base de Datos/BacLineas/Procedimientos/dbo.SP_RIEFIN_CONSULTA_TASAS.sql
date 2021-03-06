USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_TASAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_TASAS]  
     (   @Fecha DATETIME  
       , @Producto VARCHAR(31)  
       , @Numero_Simulaciones int )   
  
AS  
BEGIN  
  
-- SP_RIEFIN_CONSULTA_TASAS '20110311', 'swap', 400  
-- SP_RIEFIN_CONSULTA_TASAS '20110311', 'forward', 400  
  
 -- SET NOCOUNT ON added to prevent extra result sets from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON;  
 Set @Numero_Simulaciones = @Numero_Simulaciones + 1  
 Select top (@Numero_Simulaciones) --SELECT TOP 301, migrar el resto de los datos de apoco   
  Fecha = acfecproc  
 INTO #TEMP_FECHA  
    from  
  BactraderSuda.dbo.fechas_proceso   -- select * from BactraderSuda.dbo.fechas_proceso order by acfecproc  
    where  
  fecha <= @Fecha  
    ORDER BY  
  acfecproc  
 DESC  
   
 SELECT  
  Fecha = CURVAS.FechaGeneracion  
 , Codigo_Curva = PARAMETRIZACION.codigo  
 , Plazo = CURVAS.Dias  
 , Tasa = ValorBid  
 FROM  
  BacParamSuda..CURVAS -- ParametrosDboCURVAS CURVAS -- BAC: BacParamSuda..CURVAS CURVAS          -- Evaluar qué modelo se va a tomar  
 , ParametrosdboParametrizacion_Curvas PARAMETRIZACION -- delete ParametrosdboParametrizacion_Curvas  
 , #TEMP_FECHA TEMP_FECHA  
 WHERE  
  CURVAS.FechaGeneracion = TEMP_FECHA.Fecha  
 AND Curvas.codigocurva = PARAMETRIZACION.curva  
 AND PARAMETRIZACION.Producto = @Producto  
    AND ( @Producto = 'swap' and  Tipo = 'CERO'  -- Se debe aplicar para rescate BAC
          OR  
          @Producto <> 'swap' )
 ORDER BY  
  CURVAS.FechaGeneracion DESC   
 , PARAMETRIZACION.codigo  
 , CURVAS.dias  
   
  
END  
  
-- use baclineas  
-- select * from sysobjects where name like '%parametrosDbo%'  
-- select * from ParametrosDboParametrizacion_Curvas  -- CurvaFwEUR  
-- select * from ParametrosDboCURVAS where codigoCurva like '%fw%'  
-- select  distinct CodigoCurva from BacParamSuda..Curvas where CodigoCurva like '%EUR%'  
-- select * from ParametrosdboParametrizacion_Curvas where moneda = 'USD'  
-- CurvaFwEUR  
-- CurvaSwapEUR  
-- CurvaSwapEURLocal  
-- CurvaSwapEURUSD  
/*  
select * from ParametrosdboParametrizacion_Curvas where moneda = 'USD'  
ParametrosdboParametrizacion_Curvas  
Select * from ParametrosdboParametrizacion_Fwd  
select * from ParametrosdboParametrizacion_swap  
select * from ParametrosdboParametrizacion_Curvas   
  
select distinct CodigoCurva from BacParamSuda..CURVAS where CodigoCurva like '%fw%'  
  
select * from bacparamsuda..definicion_curvas  
*/  
GO
