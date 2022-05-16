USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_LeerCom]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






-- drop PROCEDURE Sp_LeerCom
CREATE PROCEDURE [dbo].[Sp_LeerCom] ( @cod_pai NUMERIC ( 6 ),
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
