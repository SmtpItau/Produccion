USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeer_extranjera]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_MNLeer_extranjera]
			(
			@mncodmon1 NUMERIC(3)
			)
AS 

BEGIN


SET DATEFORMAT dmy

IF EXISTS( SELECT * FROM  MONEDA WHERE (mnCodMon = @mncodmon1 OR @mncodmon1 = 0) and ESTADO='A' )
BEGIN
   SELECT -1 , 'MONEDA UTILIZADA ANTERIORMENTE'
END ELSE
   
   SELECT mncodmon
         ,   mnnemo
         ,   mnsimbol
         ,   mnglosa
         ,   mnredondeo
         ,   mnbase
         ,   mntipmon
         ,   mncodbanco
         ,   mnperiodo
         ,   mncodsuper
         ,   mncodfox
         ,   codigo_pais
         ,   mncodcor
         ,   mnextranj
         ,   mnrefmerc
         ,   'mnrefusd' = CASE WHEN mnrefusd = 1 THEN 0 ELSE 1 END
         ,   mnlocal
         ,   codigo_canasta
         ,   mnvalfox
         ,   ocurrencia
	 ,   CodDivEsp --06/11/2004 Jspp Campo para interfaz a España
      FROM  MONEDA
      WHERE 	(mnCodMon 	= @mncodmon1 OR @mncodmon1 = 0) 
		and ESTADO	<>'A'
		and mnextranj 	= 0

END



GO
