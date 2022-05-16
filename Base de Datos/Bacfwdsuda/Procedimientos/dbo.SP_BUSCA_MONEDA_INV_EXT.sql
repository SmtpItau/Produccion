USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_MONEDA_INV_EXT]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SP_BUSCA_MONEDA_INV_EXT] (@Codigo_nemo     CHAR(20))

AS
      SELECT monemi
      FROM instrumentos_subyacentes_inv_ext i, VIEW_TEXT_SER tx
      WHERE i.cod_nemo = tx.cod_nemo
       and i.Fecha_Vcto=  tx.Fecha_Vcto
       and i.cod_nemo = @Codigo_nemo 


GO
