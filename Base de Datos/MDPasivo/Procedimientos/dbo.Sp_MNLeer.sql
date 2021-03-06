USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MNLeer]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Sp_MNLeer](@mncodmon1 NUMERIC(3))
AS 

BEGIN


SET DATEFORMAT dmy

IF EXISTS( SELECT * FROM  MONEDA WHERE (mnCodMon = @mncodmon1 OR @mncodmon1 = 0) and ESTADO='A' )
BEGIN
   SELECT -1 , 'Codigo de Moneda se encuentra Anulado'
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
      WHERE (mnCodMon = @mncodmon1 OR @mncodmon1 = 0) and ESTADO<>'A'

END



GO
