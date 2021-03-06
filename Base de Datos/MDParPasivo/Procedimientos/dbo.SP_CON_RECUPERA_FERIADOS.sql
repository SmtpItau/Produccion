USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RECUPERA_FERIADOS]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_RECUPERA_FERIADOS]
						@dFecha_Desde		CHAR(08)
					,	@dFecha_Hasta		CHAR(08)
AS
BEGIN

	 SET NOCOUNT ON
	 SET DATEFORMAT DMY
	 SET DATEFIRST 1

  	 DECLARE @Fecha_DesdeX	DATETIME
  	 DECLARE @Fecha_HastaX	DATETIME

  	 SET @Fecha_DesdeX	= @dFecha_Desde
  	 SET @Fecha_HastaX	= @dFecha_Hasta

	 DECLARE @iDiferencia_Dias	INTEGER

	 CREATE TABLE #TEMP_FERIADOS(	Plaza		INTEGER
				    ,	Fecha		DATETIME )

	INSERT #TEMP_FERIADOS(Plaza, Fecha)
			SELECT Plaza, Fecha FROM FERIADO WHERE fecha BETWEEN @Fecha_DesdeX AND @Fecha_HastaX

/*
	SET @iDiferencia_Dias = (6 - DATEPART(weekday, @Fecha_DesdeX))

	SET @Fecha_DesdeX = DATEADD(day, @iDiferencia_Dias, @Fecha_DesdeX)

	WHILE @Fecha_DesdeX <= @Fecha_HastaX BEGIN


		INSERT #TEMP_FERIADOS (Plaza, Fecha        )
				SELECT -1 , @Fecha_DesdeX

		INSERT #TEMP_FERIADOS (Plaza, Fecha        )
				SELECT -1 , DATEADD(day,1,@Fecha_DesdeX)

		SET @Fecha_DesdeX = DATEADD(day, 7, @Fecha_DesdeX)

	END
*/
	SELECT Plaza, Fecha FROM #TEMP_FERIADOS ORDER BY Plaza, Fecha

END

GO
