USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDRCLeerCodigo]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






CREATE PROCEDURE [dbo].[Sp_MDRCLeerCodigo] 
       (
        @ncodpro    CHAR(5),
        @Id_Sistema CHAR(3)
       )
AS
BEGIN
	SET NOCOUNT ON 

	SELECT	rcrut     ,
		rcnombre  ,
		rcnumcorr        -- Utilizado para determinar si afecta Hedge 1 ó 0
	FROM  	TIPO_CARTERA
	WHERE 	rcsistema = @Id_Sistema AND rccodpro = @ncodpro
	ORDER BY rcrut
   
	SET NOCOUNT OFF

END


-- sp_autoriza_ejecutar 'bacuser'





GO
