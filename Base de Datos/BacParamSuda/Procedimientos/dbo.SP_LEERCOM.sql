USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERCOM]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERCOM] ( @cod_pai NUMERIC ( 6 ),
                              @cod_ciu NUMERIC ( 6 )
                            )
AS
BEGIN   
   SELECT cod_com,
          nom_ciu
   FROM   ciudad_comuna
   WHERE  cod_pai = @cod_pai AND
          cod_ciu = @cod_ciu
   ORDER BY nom_ciu
   RETURN
END  
-- cod_pai  cod_ciu  cod_com  nom_ciu

GO
