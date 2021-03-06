USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ListadoFormaPago]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[Sp_ListadoFormaPago]
AS
BEGIN
 SET NOCOUNT ON
        SELECT   codigo     ,
                  glosa      ,
                  perfil     ,
                  codgen     ,
                  glosa2     ,
                  cc2756     ,
                  afectacorr ,
                  diasvalor  ,
                  numcheque  ,
                  ctacte     ,
   'hora'     = CONVERT(varchar(10), GETDATE(), 108),
   'nombreentidad' = (Select rcnombre from entidad)
 FROM FORMA_DE_PAGO 
 ORDER BY codigo
 SET NOCOUNT OFF
END







GO
