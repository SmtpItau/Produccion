USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTADOFORMAPAGO]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LISTADOFORMAPAGO]
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
   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 FROM FORMA_DE_PAGO 
 ORDER BY codigo
 SET NOCOUNT OFF
END


GO
