USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_INST_BEX]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_INST_BEX]
               (
               @Busqueda CHAR(1)
               )
AS
BEGIN
   
   IF @Busqueda = '1'
      BEGIN
         SELECT Cod_familia
               ,Nom_Familia
          FROM BacBonosExtSuda.dbo.text_fml_inm order by Nom_Familia
      END

END
GO
