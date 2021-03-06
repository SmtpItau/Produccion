USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Instrumentos]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Trae_Instrumentos]
    (   @xSerie    CHAR(12) = ' ')
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

SELECT 	inserie		,		--1
	inglosa		,		--2
	incodigo	,		--3
	inprog		,		--4
	inrefnomi	,		--5
	inrutemi	,		--6
	inmonemi	,		--7
	inbasemi	,		--8
	intasest	,		--9
	intipo		,		--10
	inmdse		,		--11
	inmdpr		,		--12
	inmdtd		,		--13
	intipfec	,		--14
	inemision	,		--15
	ineleg		,		--16
	incontab	,            	--17
        insecuritytype  ,               --18         
        intotalemitido  ,               --19 
        insecuritytype2 ,               --20
        intiporig       ,               --21
        'incontab'	= CASE WHEN incontab = 'S' THEN 'SI' --22
                               ELSE 'NO'
                               END   ,
	codigo_inversion	     ,
	codigo_producto		     ,
	TipIrfEsp		     ,		--09/11/2004 JSPP INTEFAZ CONTABILIDAD ESPAÑA TIPO IRF
	Disponible_FLI				--07/06/2005 Incorporacion de FLI

	FROM INSTRUMENTO
	WHERE 	(inserie    =    @xserie OR @xserie = ' ')

END



GO
