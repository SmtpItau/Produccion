USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_ACTUALIZA_VAR]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_ACTUALIZA_VAR] (
	@Fecha DATETIME
,	@Rut numeric(15)  -- 10967
,	@Tipo_Operacion VARCHAR(20)
,	@Numero_Operacion INT
,	@VaR90D FLOAT     -- 10967
,   @Codigo numeric(5)
,   @Vehiculo varchar(15) = 'CORPBANCA'
) 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	INSERT INTO TBL_RIEFIN_Tabla_VaR90D
	SELECT
		@Fecha
	,	@Rut
    ,   @Codigo  -- 10967
	,	@Tipo_Operacion
	,	@Numero_Operacion
	,	@VaR90D
    ,   @Vehiculo
		
END

GO
