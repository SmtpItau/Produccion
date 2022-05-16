USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAERRORESCONTA]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTAERRORESCONTA]
AS
BEGIN
 SET NOCOUNT ON
 SELECT MENSAJE,
  'Nombre'=b.acnombre,
  'FechaP'=CONVERT(CHAR(10),b.acfecpro,103),
  'Hora'= CONVERT(CHAR(5),GETDATE(),108 )
 FROM bac_cnt_errores,
  meac b
 SET NOCOUNT OFF
END

GO
