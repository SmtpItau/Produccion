USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_TABLA_FIXING]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_TABLA_FIXING] 
 ( @Fecha DATETIME
 , @Numero_Operacion INT
 , @Numero_Componente INT 
 , @CapturaCarteraVigente  NUmeric(1) = 0
  )
AS
BEGIN
-- SP_RIEFIN_CONSULTA_TABLA_FIXING '20081121' , 22, 1, 1

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF @CapturaCarteraVigente = 0 
	   SELECT	Tabla.CaFixFecha
		,		Tabla.CaPesoFij / 100
		,		Tabla.CaFijacion 
		FROM	LNKOPC.CbMdbOpc.dbo.CaResFixing Tabla 
		WHERE	Tabla.CaFixingFechaRespaldo = @Fecha
		AND		Tabla.CaNumContrato = @Numero_Operacion
		AND		Tabla.CaNumEstructura = @Numero_Componente 
		ORDER BY	Tabla.CaFixFecha
	ELSE
	   SELECT	Tabla.CaFixFecha
		,		Tabla.CaPesoFij / 100
		,		Tabla.CaFijacion 
		FROM	LNKOPC.CbMdbOpc.dbo.CaFixing Tabla 
		WHERE	Tabla.CaNumContrato = @Numero_Operacion
		AND		Tabla.CaNumEstructura = @Numero_Componente 
		ORDER BY	Tabla.CaFixFecha
END
GO
