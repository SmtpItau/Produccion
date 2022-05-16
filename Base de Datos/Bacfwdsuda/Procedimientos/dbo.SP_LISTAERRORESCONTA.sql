USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAERRORESCONTA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LISTAERRORESCONTA] 
AS
BEGIN
 SET NOCOUNT ON
 SELECT MENSAJE,
  'Nombre' = b.acnomprop,
  'FechaP' = convert(char(10),b.Acfecproc,103),
  'Hora'   = CONVERT(CHAR(5),getdate(),108 )
 FROM Errores_Cnt ,
  mfac b
 SET NOCOUNT OFF
END

GO
