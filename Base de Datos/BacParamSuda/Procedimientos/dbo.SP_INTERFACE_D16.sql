USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFACE_D16]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFACE_D16]
	(	@mesinforme NUMERIC(2),
		@anoinforme NUMERIC(4),
		@cuantos CHAR(1)='T'
	)
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #tmpD16(
		rut CHAR(9),
		dv CHAR(1),
		nom CHAR(50),
		numgtia CHAR(30),
		tipo CHAR(4),
		fecha DATETIME,
		dia CHAR(2),
		mes CHAR(2),
		amo CHAR(4),
		fechatas CHAR(8),
		valor CHAR(14),
		montoseg CHAR(14),
		fechaseg CHAR(8),
		posicion NUMERIC(9) IDENTITY)

	DECLARE @tvalor CHAR(14)

	INSERT INTO #tmpD16(rut,dv,nom, numgtia, tipo, fecha, valor, montoseg, fechaseg)

	SELECT CONVERT(CHAR(9),ag.RutCliente), 
	c.Cldv, CONVERT(CHAR(50),c.Clnombre), 
	CONVERT(CHAR(30),ag.NumeroGarantia),
	'9299',
	m.Fecha,
	CONVERT(CHAR(14),(SELECT SUM(d.ValorPresente) FROM Bacparamsuda..tbl_mov_garantia_detalle d WHERE d.NumeroOperacion = ag.NumeroGarantia)),
	'00000000000000',
	'99999999'
	FROM BacParamsuda.dbo.tbl_gar_AsociacionGtia ag,
	Bacparamsuda.dbo.CLIENTE c, 
	Bacparamsuda.dbo.tbl_mov_garantia m
	WHERE ag.RutCliente = c.Clrut
	AND ag.CodCliente = c.Clcodigo
	AND ag.NumeroGarantia = m.NumeroOperacion
	AND DATEPART(mm,m.FechaVigencia) = @mesinforme
	AND DATEPART(yyyy,m.FechaVigencia) = @anoinforme
	ORDER BY m.Fecha ASC

	UPDATE #tmpD16
	SET dia = CASE WHEN DATEPART(dd,fecha) < 10 THEN '0'+CONVERT(CHAR(1),DATEPART(dd,fecha)) WHEN DATEPART(dd,fecha) >= 10 THEN CONVERT(CHAR(2),DATEPART(dd,fecha)) END,
	    mes = CASE WHEN DATEPART(mm,fecha) < 10 THEN '0'+CONVERT(CHAR(1),DATEPART(mm,fecha)) WHEN DATEPART(mm,fecha) >= 10 THEN CONVERT(CHAR(2),DATEPART(mm,fecha)) END,
	    amo = CONVERT(CHAR(4),DATEPART(yyyy,fecha))

	UPDATE #tmpD16
	SET 	fechatas = dia+mes+amo

	DECLARE @treg NUMERIC(9),
		@nreg NUMERIC(9),
		@evalor VARCHAR(14),
		@svalor VARCHAR(14),
		@engtia VARCHAR(30),
		@sngtia VARCHAR(30),
		@erut VARCHAR(9),
		@srut VARCHAR(9),
		@enom VARCHAR(50),
		@snom VARCHAR(50)
	
	SELECT  @treg = COUNT(*) FROM #tmpD16
	SELECT  @nreg = 1
	WHILE @nreg <= @treg
	BEGIN
		SELECT @evalor = valor,
		@engtia = numgtia,
		@erut = rut,
		@enom = nom
		FROM #tmpD16 WHERE posicion = @nreg	
		EXECUTE SP_RELLENATEXTO @evalor,'0',14,1, @svalor OUTPUT
		EXECUTE SP_RELLENATEXTO @engtia,'.',30,1, @sngtia OUTPUT 
		EXECUTE SP_RELLENATEXTO @erut,'0',9,1, @srut OUTPUT
		EXECUTE SP_RELLENATEXTO @enom,'.',50,1, @snom OUTPUT

		UPDATE #tmpD16
		SET valor = @svalor,
		numgtia = @sngtia,
		rut = @srut,
		nom = @snom
		WHERE posicion = @nreg
		SELECT @nreg = @nreg + 1
	END

	DECLARE @emes VARCHAR(2),
		@smes VARCHAR(2),
		@eano VARCHAR(4),
		@sano VARCHAR(4)

		SELECT 	@emes = CONVERT(VARCHAR(2),@mesinforme),
			@eano = CONVERT(VARCHAR(4),@anoinforme)

		EXECUTE SP_RELLENATEXTO @emes,'0',2,1,@smes OUTPUT
		EXECUTE SP_RELLENATEXTO @eano,'0',4,1,@sano OUTPUT

	IF @cuantos = '1'
		SELECT '027D16'+@smes+@sano
	ELSE
		SELECT 	rut, dv, nom, numgtia, tipo, fechatas, valor, montoseg, fechaseg
		FROM #tmpD16
		DROP TABLE #tmpD16

	SET NOCOUNT OFF
END

GO
