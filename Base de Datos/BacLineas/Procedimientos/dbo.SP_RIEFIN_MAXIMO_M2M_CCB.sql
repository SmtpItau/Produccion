USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_MAXIMO_M2M_CCB]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_MAXIMO_M2M_CCB] 
AS
BEGIN
-- SP_RIEFIN_MAXIMO_M2M_CCB    


	SET NOCOUNT ON;

    declare @fecha datetime

    SELECT @Fecha = acFecProc
      FROM bactradersuda..mdac   -- select * from bactradersuda..mdac

 	
		-- La Tabla THreshold cumple indicando los clientes
		-- a los cuales se aplica la metodogía Threshold y Netting
		-- Por ahora se simulara los mismo con el valor threshol 
		-- mayor que 1 en linea_general
		-- No perder de vista que esto debe quedar recibiendo un rut 
		-- como parámetro.

		-- =============================================
		-- Importante:	
		-- Duplicación de código y cambio a modelo 
		-- cartera vigente. Orientado a la imputación
		-- de cliente On-Line
		-- =============================================

		
		-- Flujos Forwards

		SELECT
			[Rut]               = convert( numeric(13), substring( ltrim(rtrim(CARTERA.RutCliente)), 1, charindex( '-', ltrim(rtrim(CARTERA.RutCliente))) - 1 ) )
		,   [Codigo]            = 1
		,	[Fecha Liquidacion] = CARTERA.FechaVencimiento 
		,	[Flujo Neto]        = SUM(CARTERA.MtoVRNeto)
		INTO #TEMPORAL
		FROM LNKBACBDC72.BDC72.Dbo.FMCarteraForward CARTERA
            --select mtoVRActivo, mtoVRPasivo, MtoVRNeto, MtVrNetoCal =  mtoVRActivo - mtoVRPasivo  from 
		WHERE
             Estado = 'V' and FechaVencimiento >= @Fecha
		GROUP BY
			CARTERA.FechaVencimiento
		,	convert( numeric(13), substring( ltrim(rtrim(CARTERA.RutCliente)), 1, charindex( '-', ltrim(rtrim(CARTERA.RutCliente))) - 1 ) )


		-- Suma los flujos acumulados a cada fecha de vencimiento
		SELECT
			X.Rut
		,   X.Codigo
		,	Y.[Fecha Liquidacion]
		,	Y.[Flujo Neto]
		,	[ACUMULADO] = SUM(X.[Flujo Neto])
		INTO #TEMPORAL_2
		FROM
			#TEMPORAL AS X
			INNER JOIN #TEMPORAL AS Y
			  ON X.RUT = Y.RUT
		WHERE
			X.[Fecha Liquidacion] >= Y.[Fecha Liquidacion]
		GROUP BY
			Y.[Fecha Liquidacion]
		,	X.Rut , X.Codigo
		,	Y.[Flujo Neto]
		
		-- Esta operacion se hace para no permitir que se dupliquen valores
		DELETE
			TBL_RieFinTabla_Max_Exp  -- select * from TBL_RieFinTabla_Max_Exp
		WHERE
			Fecha = @Fecha
		
		
		INSERT INTO TBL_RieFinTabla_Max_Exp  -- select * from TBL_RieFinTabla_Max_Exp
		SELECT
			@Fecha
		,	RESUMEN.Rut, RESUMEN.Codigo
		,	SUM(RESUMEN.[Flujo Neto])
		,	MAX(RESUMEN.ACUMULADO)
        ,   'CCB'
		FROM
			#TEMPORAL_2 RESUMEN
		GROUP BY
			RESUMEN.Rut, RESUMEN.Codigo
		ORDER BY
			RESUMEN.Rut, RESUMEN.Codigo

END

GO
