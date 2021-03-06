USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CONSULTA_FECHAS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CONSULTA_FECHAS] 
     ( @Fecha DATETIME
     , @Numero_Simulaciones int  )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	-- SP_RIEFIN_CONSULTA_FECHAS '20110311', 2
	SET NOCOUNT ON;
    set @Numero_Simulaciones = @Numero_Simulaciones + 1
    SELECT TOP (@Numero_Simulaciones)
		acfecproc
    from
		BactraderSuda.dbo.fechas_proceso
    where
		fecha <= @Fecha
    ORDER BY
		acfecproc
	DESC
END
GO
