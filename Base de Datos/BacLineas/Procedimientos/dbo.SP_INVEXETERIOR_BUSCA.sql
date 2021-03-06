USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INVEXETERIOR_BUSCA]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_Busca    fecha de la secuencia de comandos: 03/04/2001 15:18:06 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_InvExeterior_Busca    fecha de la secuencia de comandos: 14/02/2001 09:58:27 ******/
CREATE PROCEDURE [dbo].[SP_INVEXETERIOR_BUSCA]
     (@Rut_Cliente NUMERIC(9))
AS
BEGIN
        SET NOCOUNT ON
  SELECT  rut_cliente,
   codigo_cliente,
   nombre,
   plazo,
   arbspo_total,
   arbspo_ocupado,
   arbspo_disponible,
   arbspo_exceso,
   arbfwd_total,
   arbfwd_ocupado,
   arbfwd_disponible,
   arbfwd_exceso,
   invext_total,
   invext_ocupado,
   invext_disponible,
   arbext_exceso,
   fecha_vencimiento,
   fecha_fin_contrato
    FROM 
   INVERSION_EXTERIOR
     WHERE rut_cliente=@Rut_Cliente
   SET NOCOUNT OFF
END
GO
