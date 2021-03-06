USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORMACION_LINEAS_POR_PLAZO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INFORMACION_LINEAS_POR_PLAZO]
   (   @rut_cli   NUMERIC(9)
   ,   @cod_cli   NUMERIC(9)
   )
AS 
BEGIN

   SET NOCOUNT ON

		SELECT LP.Id_Sistema        -- 00        
        ,      LP.Codigo_Producto	-- 01
		,      LP.incodigo			-- 02
		,      LP.mncodmon			-- 03
		,      LP.codigo			-- 04
		,      LP.plazodesde			-- 05
		,      LP.Plazohasta			-- 06
		,      LP.TotalAsignado			-- 07
		,      LP.TotalOcupado			-- 08	
		,      LP.TotalExceso			-- 09
		,      'Producto' = ISNULL(PS.Descripcion,'')	-- 10
		,      'Serie'    = ISNULL(VI.inserie,'')		-- 11
		,      'GlosaForPag'  = ISNULL(VF.glosa,'')		-- 12
		,      'GlosaMoneda'  = ISNULL(VM.mnnemo,'')	-- 13
        ,      S.nombre_sistema         -- 14 
   	    FROM LINEA_PRODUCTO_POR_PLAZO  LP
			   LEFT JOIN BacParamSuda.dbo.INSTRUMENTO	 VI ON VI.incodigo	= LP.incodigo
			   LEFT JOIN BacParamSuda.dbo.MONEDA		 VM ON VM.mncodmon	= LP.mncodmon
			   LEFT JOIN BacParamSuda.dbo.FORMA_DE_PAGO  VF ON VF.codigo	= LP.codigo
			   LEFT JOIN PRODUCTO_SISTEMA	 PS ON  PS.Id_Sistema= LP.Id_Sistema 
								 AND PS.Codigo_Producto = LP.Codigo_Producto   
               LEFT  JOIN BacParamSuda.dbo.SISTEMA_CNT S with (nolock) ON S.id_sistema =  LP.id_sistema 
		 WHERE LP.Rut_Cliente 		= @rut_cli
		   AND LP.Codigo_Cliente	= @cod_cli
		   AND LP.Codigo_Producto 	= PS.Codigo_Producto
		ORDER BY LP.Id_Sistema
            ,    ISNULL(PS.Descripcion,'')
	        ,    ISNULL(VI.inserie,'')
	        ,    ISNULL(VM.mnnemo,'')
	        ,    ISNULL(VF.glosa,'')
	        ,    LP.plazodesde
	        ,    LP.Plazohasta

END
GO
