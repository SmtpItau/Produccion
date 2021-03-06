USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_CUADRO_TASAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec dbo.SP_GEN_CUADRO_TASAS '20141016', 999,8,1

CREATE PROCEDURE [dbo].[SP_GEN_CUADRO_TASAS]
   (   
		 @fecha_origen VARCHAR(80)
		,@codmon int 
		,@codtasa int
		,@periodo int 
   ) 
AS  
BEGIN

SET NOCOUNT ON
/* The following script, save only valid dates and  input the records in temporary table*/
CREATE TABLE #TempFechasCuadroTasas
(
	fecha		datetime,
	codMon		int,
	nombreMon	char(8),
	codTasa		int,
	nombreTasa	char(50),
	valorTasa	float,
	feriadoCL	char(1),
	feriadoUS	char(1),
	feriadoEN	char(1)
)

/*-------------------------------------------------------------*/
/* DECLARACION DE VARIABLES DEL SP								*/
/*-------------------------------------------------------------*/
DECLARE @iCount				int
DECLARE @FecTemporal		datetime
DECLARE @FechaOrigenTemp	datetime
DECLARE @ParamTasas			int 
DECLARE @PlazaCL			VARCHAR(5)
DECLARE @PlazaUS			VARCHAR(5)
DECLARE @PlazaEN			VARCHAR(5)

/*-------------------------------------------------------------*/
/* SETEO DE VARIABLES DEL SP								   */
/*-------------------------------------------------------------*/
SET @PlazaCL	= ';6;'
SET @PlazaUS	= ';225;'
SET @PlazaEN	= ';510;'
SET @iCount = 1
SET @ParamTasas = 1042		/* 1042 = TIPO DE TASAS (SWAP)      */
  --**************************PRD21657
   declare @fecaux datetime
   declare @fCL datetime
   declare @fUS datetime
   declare @fEN datetime
   declare @fecCL as table(fec datetime)
   declare @fecUS as table(fec datetime)
   declare @fecEN as table(fec datetime)
  --**************************PRD21657


SET @FechaOrigenTemp  = @fecha_origen
/*-------------------------------------------------------------*/
/* REALIZA BUSQUEDA DE FECHAS PREVIAS A LA FIJACIÓN DEL FLUJO  */
/*-------------------------------------------------------------*/
SET @FecTemporal = (SELECT dateadd(day,-1,@FechaOrigenTemp))
WHILE (@iCount < 4) 
BEGIN 
  /*	IF(DATEPART(WEEKDAY,@FecTemporal) = 7 OR DATEPART(WEEKDAY,@FecTemporal) = 1) --Sabado y Domingo
      BEGIN
         SET @FecTemporal = (SELECT dateadd(day,-1,@FecTemporal))
      END
	ELSE
	BEGIN*/
		set @fUS=  @FecTemporal
		set @fCL=  @FecTemporal
		set @fEN=  @FecTemporal
		SET @fecaux=@FecTemporal
		insert into @fecUS 
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
		insert into @fecCL
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL 
		insert into @fecEN
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN

	INSERT INTO  #TempFechasCuadroTasas (fecha,codMon,nombreMon,codTasa,nombreTasa,valorTasa,feriadoUS,feriadoCL,feriadoEN) 
		(  
			SELECT fecha,codmon,mon.mnnemo,codtasa,tbglosa,tasa
					,iif(@fUS=@fecaux,'-','X') AS feriadoUS
					,iif(@fCL=@fecaux,'-','X') AS feriadoCL
					,iif(@fEN=@fecaux,'-','X') AS feriadoEN
				FROM moneda_tasa mt 	
				INNER JOIN TABLA_GENERAL_DETALLE tas  ON mt.[codtasa] = tas.tbcodigo1  AND tas.tbcateg = @ParamTasas
				INNER JOIN MONEDA mon ON mt.codmon = mon.mncodmon
			WHERE codmon  = @codmon
					AND ((codtasa = @codtasa ) OR (@codtasa is null))
					AND fecha in (@FecTemporal)
					AND periodo = @periodo
		)
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,-1,@fecaux))
		delete from @fecUS
		delete from @fecCL
		delete from @fecEN
		SET @iCount = @iCount + 1  
	--END 
END

/*--------------------------------------------------------------------*/
/* INSERTO REGISTRO CON LA FECHA PRINCIPAL DE CONSULTA (FEC PROCESO)  */
/*--------------------------------------------------------------------*/

   set @fUS= @fecha_origen
   set @fCL= @fecha_origen
   set @fEN= @fecha_origen
   
  insert into @fecUS
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
  insert into @fecCL
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL 
  insert into @fecEN
  exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN
INSERT INTO  #TempFechasCuadroTasas (fecha,codMon,nombreMon,codTasa,nombreTasa,valorTasa,feriadoUS,feriadoCL,feriadoEN) 
(  
	SELECT fecha,codmon,mon.mnnemo,codtasa,tbglosa,tasa
					,iif(@fUS=@fecha_origen,'-','X') AS feriadoUS
					,iif(@fCL=@fecha_origen,'-','X') AS feriadoCL
					,iif(@fEN=@fecha_origen,'-','X') AS feriadoEN
		FROM moneda_tasa mt 	
		INNER JOIN TABLA_GENERAL_DETALLE tas  ON mt.[codtasa] = tas.tbcodigo1  AND tas.tbcateg = @ParamTasas
		INNER JOIN MONEDA mon ON mt.codmon = mon.mncodmon
	WHERE codmon  = @codmon
			AND ((codtasa = @codtasa ) OR (@codtasa is null))
			AND fecha in (@fecha_origen)
			AND periodo = @periodo
)
delete from @fecUS
delete from @fecCL
delete from @fecEN


/*-----------------------------------------------------------------*/
/* REALIZA BUSQUEDA DE FECHAS POSTERIORES A LA FIJACIÓN DEL FLUJO  */
/*-----------------------------------------------------------------*/
SET @iCount=1
SET @FecTemporal = (SELECT dateadd(day,1,@FechaOrigenTemp))
WHILE (@iCount < 4) 
BEGIN 
  /*	IF(DATEPART(WEEKDAY,@FecTemporal) = 7 OR DATEPART(WEEKDAY,@FecTemporal) = 1) 
      BEGIN
         SET @FecTemporal = (SELECT dateadd(day,1,@FecTemporal))
      END
	ELSE
	BEGIN*/
		set @fUS=  @FecTemporal
		set @fCL=  @FecTemporal
		set @fEN=  @FecTemporal
		SET @fecaux=@FecTemporal
		insert into @fecUS
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fUS output,@PlazaUS
		insert into @fecCL
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fCL output,@PlazaCL 
		insert into @fecEN
		exec bacparamsuda.dbo.SP_MUESTRAFECHAVALIDA @fEN output,@PlazaEN

	INSERT INTO  #TempFechasCuadroTasas (fecha,codMon,nombreMon,codTasa,nombreTasa,valorTasa,feriadoUS,feriadoCL,feriadoEN) 
		(  
			SELECT fecha,codmon,mon.mnnemo,codtasa,tbglosa,tasa
					,iif(@fUS=@fecaux,'-','X') AS feriadoUS
					,iif(@fCL=@fecaux,'-','X') AS feriadoCL
					,iif(@fEN=@fecaux,'-','X') AS feriadoEN
				FROM moneda_tasa mt 	
				INNER JOIN TABLA_GENERAL_DETALLE tas  ON mt.[codtasa] = tas.tbcodigo1  AND tas.tbcateg = @ParamTasas
				INNER JOIN MONEDA mon ON mt.codmon = mon.mncodmon
			WHERE codmon  = @codmon
					AND ((codtasa = @codtasa ) OR (@codtasa is null))
					AND fecha in (@FecTemporal)
					AND periodo = @periodo
		)
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		SET @FecTemporal = (SELECT dateadd(day,1,@fecaux))
		delete from @fecUS
		delete from @fecCL
		delete from @fecEN
		SET @iCount = @iCount + 1  
	--END 
END
/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/
/* RETORNO LOS REGISTROS DEL QUERY				               */
/*-------------------------------------------------------------*/
/*-------------------------------------------------------------*/
SELECT fecha, codMon,nombreMon,codTasa,nombreTasa,valorTasa,feriadoUS,feriadoCL,feriadoEN	FROM #TempFechasCuadroTasas 
ORDER BY fecha

/*-------------------------------------------------------------*/
/* ELIMINACION TABLA TEMPORAL    				               */
/*-------------------------------------------------------------*/
DROP TABLE #TempFechasCuadroTasas
SET NOCOUNT OFF

END

GO
