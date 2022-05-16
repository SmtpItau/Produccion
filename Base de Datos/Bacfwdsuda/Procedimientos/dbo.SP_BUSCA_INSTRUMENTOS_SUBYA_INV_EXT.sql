USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_INSTRUMENTOS_SUBYA_INV_EXT]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_BUSCA_INSTRUMENTOS_SUBYA_INV_EXT]
AS
BEGIN
	SELECT cod_familia,
	       cod_nemo,
	       fecha_vcto	
	FROM instrumentos_subyacentes_inv_ext 
	ORDER BY cod_nemo 
END


-- select * from instrumentos_subyacentes_inv_ext
-- select name from sysobjects where name like 'SP_BUSCA_INSTRUMENTOS_%'


GO
