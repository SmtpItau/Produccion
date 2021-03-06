USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PLANILLON_SECCION3]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_PLANILLON_SECCION3]( @dFecha      CHAR(8) ,
                                        @nPosicion      INT         ,
                                        @nCod_operacion INT         ,
                                        @nTip_operacion INT         ,
                                        @nCod_anulacion INT  ,
                                        @nTip_anulacion INT         ,
                                        @cDes_concepto  VARCHAR(40) = '' )
AS
BEGIN
     SET NOCOUNT ON
     DECLARE @nCnt_operacion INT     ,
             @nMto_operacion FLOAT   ,
             @nCnt_anulacion INT     ,
             @nMto_anulacion FLOAT
     ------<< Cantidad y Total de operaciones Vigentes
     SELECT @nCnt_operacion = COUNT(*),
            @nMto_operacion = SUM(p.monto_dolares)
       FROM view_tbCodigoOMA    o,
            view_Planilla_SPT   p
      WHERE  planilla_fecha          = @dFecha
        AND (p.tipo_operacion_cambio = @nCod_operacion OR (@nTip_operacion <> 0 AND @nCod_operacion  = 0))
        AND (p.tipo_documento        = @nTip_operacion OR (@nTip_operacion  = 0 AND @nCod_operacion <> 0))
        AND  o.codigo_numerico       = p.tipo_operacion_cambio
      GROUP BY p.tipo_documento -- p.tipo_operacion_cambio
     ------<< Cantidad y Total de operaciones anuladas
     SELECT @nCnt_anulacion = COUNT(*),
            @nMto_anulacion = SUM(p.monto_dolares)
       FROM view_tbCodigoOMA    o,
            view_Planilla_SPT   p
      WHERE  planilla_fecha          = @dFecha
        AND (p.tipo_operacion_cambio = @nCod_anulacion OR (@nCod_anulacion  = 0 AND @nTip_anulacion <> 0))
        AND (p.tipo_documento        = @nTip_anulacion OR (@nCod_anulacion <> 0 AND @nTip_anulacion  = 0))
        AND  o.codigo_numerico       = p.tipo_operacion_cambio
      GROUP BY p.tipo_documento -- p.tipo_operacion_cambio
     SELECT  posicion      = @nPosicion           ,
             tipo          = SUBSTRING(@cDes_concepto,1, 1),
             des_operacion = SUBSTRING(@cDes_concepto,2,30),
             cod_operacion = ISNULL(@nCod_operacion,0 ) ,
             cnt_operacion = ISNULL(@nCnt_operacion,0 ) ,
             mto_operacion = ISNULL(@nMto_operacion,0.) ,
             cod_anulacion = ISNULL(@nCod_anulacion,0 ) ,
             cnt_anulacion = ISNULL(@nCnt_anulacion,0 ) ,
             mto_anulacion = ISNULL(@nMto_anulacion,0.) 
END



GO
