USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMDER_ConsumoLinea]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_COMDER_ConsumoLinea](@rutCliente INT, @sistema VARCHAR(10),@Metodologia INT)
AS
BEGIN
-- =============================================
-- Author:		Sandra Vásquez
-- Create date: 25-05-2015
-- Description: Obtiene los totales ocupados en la Linea de las 
--              operaciones ComDer y Bilaterales
-- =============================================

 DECLARE @rutComDer INT
 DECLARE @dvComDer INT

	-- RUT COMDER
	SELECT   @rutComDer = rut_comder
		   , @dvComDer  = dv_comder 
	FROM  BDBOMESA..ComDer_Parametros

	CREATE TABLE #tmp_LINEA_SISTEMA
	(
		linea VARCHAR(20) NOT NULL,
		TotalAsignado [numeric](19, 4) NOT NULL,
		TotalOcupado [numeric](19, 4) NOT NULL,
		TotalDisponible [numeric](19, 4) NOT NULL,
		TotalExceso [numeric](19, 4) NOT NULL,
		Moneda [char](3) NOT NULL,
	    Bloqueado [char](1) NOT NULL,
		Metodologia VARCHAR(50) NOT NULL
	) 

	-- CONSUMO DE LINEA COMDER
	INSERT INTO #tmp_LINEA_SISTEMA
	SELECT 'linea'		     = 'COMDER'
		  ,'TotalAsignado'   =  ISNULL(ls.TotalAsignado,0)
	      ,'TotalOcupado'    =  ISNULL(ls.TotalOcupado,0)
	      ,'TotalDisponible' =  ISNULL(ls.TotalDisponible,0)
	      ,'TotalExceso'	 =  ISNULL(ls.TotalExceso,0)
	      ,'Moneda'			 =  ls.Moneda 
	      ,'Bloqueado'		 =  ls.Bloqueado
		  ,'Metodologia'	 =  m.RecMtdDsc
	FROM  BacLineas.dbo.LINEA_SISTEMA AS ls WITH (NOLOCK) INNER JOIN
          BacParamSuda.dbo.CLIENTE AS c WITH (NOLOCK)  ON ls.Rut_Cliente = c.Clrut INNER JOIN
          BacLineas.dbo.TBL_METODOLOGIAREC AS m WITH (NOLOCK) ON c.ClRecMtdCod = m.RecMtdCod
	WHERE Rut_Cliente = @rutComDer 
	  AND Codigo_Cliente = 1 
	  AND Id_Sistema = 'DRV'

--*************************************************

	IF(@Metodologia IN(1,4))
	BEGIN
		-- CONSUMO LINEA BILATERAL
		INSERT INTO #tmp_LINEA_SISTEMA
		SELECT 'linea'		     =  'BILATERAL'
			  ,'TotalAsignado'   =   ISNULL(ls.TotalAsignado,0)
			  ,'TotalOcupado'    =   ISNULL(ls.TotalOcupado,0)
			  ,'TotalDisponible' =   ISNULL(ls.TotalDisponible,0)
			  ,'TotalExceso'	 =   ISNULL(ls.TotalExceso,0)
			  ,'Moneda'			 =   ls.Moneda 
			  ,'Bloqueado'		 =   ls.Bloqueado
		      ,'Metodologia'	 =   m.RecMtdDsc
		FROM  BacLineas.dbo.LINEA_SISTEMA AS ls WITH (NOLOCK) INNER JOIN
              BacParamSuda.dbo.CLIENTE AS c WITH (NOLOCK)  ON ls.Rut_Cliente = c.Clrut INNER JOIN
              BacLineas.dbo.TBL_METODOLOGIAREC AS m WITH (NOLOCK) ON c.ClRecMtdCod = m.RecMtdCod
		WHERE   Rut_Cliente =  @rutCliente 
			AND Codigo_Cliente = 1 
			AND Id_Sistema = 'BFW' 
	END
	
	IF @METODOLOGIA IN(2,3,5)
	BEGIN
		-- CONSUMO LINEA BILATERAL -- CONSULTA LINEA SISTEMAS PARA PRODUCTOS DERIVADOS
		INSERT INTO #tmp_LINEA_SISTEMA
		SELECT 'linea'		     =  'BILATERAL'
			  ,'TotalAsignado'   =   ISNULL(ls.TotalAsignado,0)
			  ,'TotalOcupado'    =   ISNULL(ls.TotalOcupado,0)
			  ,'TotalDisponible' =   ISNULL(ls.TotalDisponible,0)
			  ,'TotalExceso'	 =   ISNULL(ls.TotalExceso,0)
			  ,'Moneda'			 =   ls.Moneda 
			  ,'Bloqueado'		 =   ls.Bloqueado
			  ,'Metodologia'	 =    m.RecMtdDsc
		FROM  BacLineas.dbo.LINEA_SISTEMA AS ls WITH (NOLOCK) INNER JOIN
              BacParamSuda.dbo.CLIENTE AS c WITH (NOLOCK)  ON ls.Rut_Cliente = c.Clrut INNER JOIN
              BacLineas.dbo.TBL_METODOLOGIAREC AS m WITH (NOLOCK) ON c.ClRecMtdCod = m.RecMtdCod
		WHERE   Rut_Cliente = @rutCliente 
			AND Codigo_Cliente = 1 
			AND Id_Sistema = 'DRV' 
	END
 --************************************************************************
 --************************************************************************
	SELECT  'linea'		      = linea
		   ,'TotalAsignado'   = TotalAsignado
		   ,'TotalOcupado'    = TotalOcupado
		   ,'TotalDisponible' = TotalDisponible
		   ,'TotalExceso'	  = TotalExceso
		   ,'Moneda'	      = Moneda
		   ,'Bloqueado'		  = Bloqueado
		   ,'Metodologia'	  = Metodologia
	FROM #tmp_LINEA_SISTEMA

END







GO
