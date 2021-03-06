USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERLETRASCLIENTES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LEERLETRASCLIENTES]
         (   @nombre CHAR(40)
         )
AS
BEGIN
   SET ROWCOUNT 50
   SELECT rut_cliente      --01
      ,   codigo_cliente   --02
      ,   dv               --03
      ,   nombre           --04
      ,   codigo_pais      --05
      ,   codigo_region    --06
      ,   codigo_ciudad    --07
      ,   codigo_comuna    --08
      ,   direccion        --09
      ,   telefono         --10
      ,   fax              --11
      ,   email            --12
      FROM
         LETRA_HIPOTECARIA_CLIENTE, MDAC
      WHERE 
         rut_cliente <> acrutprop AND
         nombre > @nombre 
      ORDER BY
         nombre
   
   SET ROWCOUNT 50
END
                                                                              


GO
