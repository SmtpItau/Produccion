USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_BUSCAR_CUENTA]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CON_BUSCAR_CUENTA]
   (   @cConcepto_Contable  CHAR(05)
   ,   @cSubproducto        CHAR(07)
   ,   @cTipo_Plazo         CHAR(01)
   ,   @cFinanciamiento     CHAR(03) 
   ,   @cCodigo_Sector      CHAR(01)
   ,   @cCodigo_Subsector   CHAR(02)
   ,   @cBanco_Corresponsal CHAR(05)
   ,   @cStatus_Cuota       CHAR(01)
   ,   @cStatus_Colocacion  CHAR(01)
   ,   @cReajustabilidad    CHAR(01)
   ,   @cDivisa             CHAR(03)
   ,   @cTipo_Divisa        CHAR(01)
   ,   @cCuenta             CHAR(15) OUTPUT
   ,   @Ristra 	            VARCHAR(69) output
   ,   @cCodigo_Operacion   CHAR(03)
   )
AS
BEGIN

   SET NOCOUNT OFF
   SET DATEFORMAT DMY

   DECLARE @cRistra  CHAR(69)
   DECLARE @cRistra_sin_Procesar CHAR(69)

   SELECT @cRistra_sin_Procesar= '89'
                               + RTRIM(@cSubproducto)         + REPLICATE('-',7 - LEN(@cSubproducto))
                               + RTRIM(@cTipo_Plazo)          + REPLICATE('-',1 - LEN(@cTipo_Plazo))
                               + RTRIM(@cFinanciamiento)      + REPLICATE('-',3 - LEN(@cFinanciamiento))
                               + RTRIM(@cCodigo_Sector)       + REPLICATE('-',1 - LEN(@cCodigo_Sector))
                               + RTRIM(@cCodigo_Subsector)    + REPLICATE('-',2 - LEN(@cCodigo_Subsector))
                               + RTRIM(@cBanco_Corresponsal)  + REPLICATE('-',5 - LEN(@cBanco_Corresponsal))
                               + REPLICATE('-',2)
                               + RTRIM(@cStatus_Cuota)        + REPLICATE('-',1 - LEN(@cStatus_Cuota))
                               + RTRIM(@cStatus_Colocacion)   + REPLICATE('-',1 - LEN(@cStatus_Colocacion))
                               + REPLICATE('-',2)
                               + SPACE(1)
                               + RTRIM(@cReajustabilidad)     + REPLICATE('-',1 - LEN(@cReajustabilidad))
                               + RTRIM(@cCodigo_Operacion)    + REPLICATE('-',3 - LEN(@cCodigo_Operacion))
                               + RTRIM(@cConcepto_Contable)   + LTRIM(REPLICATE('-',5 - LEN(@cConcepto_Contable)))
                               + RTRIM(@cDivisa)              + REPLICATE('-',3 - LEN(@cDivisa))
                               + RTRIM(@cTipo_Divisa)         + REPLICATE('-',1 - LEN(@cTipo_Divisa))
   FROM   CONCEPTO_CONTABLE
   WHERE  concepto_contable = @cConcepto_Contable

   SELECT @cSubproducto        = CASE WHEN switch_producto         = 1 THEN RTRIM(@cSubproducto)        + REPLICATE('-',7 - LEN(@cSubproducto))         ELSE REPLICATE('-',7) END --SPACE(07) END
      ,   @cTipo_Plazo         = CASE WHEN switch_tipo_plazo       = 1 THEN RTRIM(@cTipo_Plazo)         + REPLICATE('-',1 - LEN(@cTipo_Plazo))          ELSE REPLICATE('-',1) END --SPACE(01) END
      ,   @cFinanciamiento     = CASE WHEN switch_financia         = 1 THEN RTRIM(@cFinanciamiento)     + REPLICATE('-',3 - LEN(@cFinanciamiento))      ELSE REPLICATE('-',3) END --SPACE(03) END
      ,   @cCodigo_Sector      = CASE WHEN switch_sector           = 1 THEN RTRIM(@cCodigo_Sector)      + REPLICATE('-',1 - LEN(@cCodigo_Sector))       ELSE REPLICATE('-',1) END --SPACE(01) END
      ,   @cCodigo_Subsector   = CASE WHEN switch_sector           = 1 THEN RTRIM(@cCodigo_Subsector)   + REPLICATE('-',2 - LEN(@cCodigo_Subsector))    ELSE REPLICATE('-',2) END --SPACE(02) END
      ,   @cBanco_Corresponsal = CASE WHEN switch_corresponsal     = 1 THEN RTRIM(@cBanco_Corresponsal) + REPLICATE('-',5 - LEN(@cBanco_Corresponsal))  ELSE REPLICATE('-',5) END --SPACE(05) END
      ,   @cStatus_Cuota       = CASE WHEN switch_cuota            = 1 THEN RTRIM(@cStatus_Cuota)       + REPLICATE('-',1 - LEN(@cStatus_Cuota))        ELSE REPLICATE('-',1) END --SPACE(01) END
      ,   @cStatus_Colocacion  = CASE WHEN switch_colocacion       = 1 THEN RTRIM(@cStatus_Colocacion)  + REPLICATE('-',1 - LEN(@cStatus_Colocacion))   ELSE REPLICATE('-',1) END --SPACE(01) END
      ,   @cReajustabilidad    = CASE WHEN switch_recup            = 1 THEN RTRIM(@cReajustabilidad)    + REPLICATE('-',1 - LEN(@cReajustabilidad))     ELSE REPLICATE('-',1) END-- SPACE(01) END
      ,   @cDivisa             = CASE WHEN switch_divisa           = 1 THEN RTRIM(@cDivisa)             + REPLICATE('-',3 - LEN(@cDivisa))              ELSE REPLICATE('-',3) END-- SPACE(03) END
      ,   @cTipo_Divisa        = CASE WHEN switch_tipo_moneda      = 1 THEN RTRIM(@cTipo_Divisa)        + REPLICATE('-',1 - LEN(@cTipo_Divisa))         ELSE REPLICATE('-',1) END-- SPACE(01) END
      ,   @cCodigo_Operacion   = CASE WHEN switch_codigo_operacion = 1 THEN RTRIM(@cCodigo_Operacion)   + REPLICATE('-',3 - LEN(@cCodigo_Operacion))    ELSE REPLICATE('-',3) END-- SPACE(03) END
   FROM   CONCEPTO_CONTABLE
   WHERE  concepto_contable = @cConcepto_Contable

   SELECT @cRistra = '89'+ @cSubproducto
                   + @cTipo_Plazo
                   + @cFinanciamiento
                   + @cCodigo_Sector
                   + @cCodigo_Subsector
                   + @cBanco_Corresponsal
                   + REPLICATE('-',2)
                   + @cStatus_Cuota
                   + @cStatus_Colocacion
                   + REPLICATE('-',2)
                   + SPACE(1)
                   + @cReajustabilidad
                   + @cCodigo_Operacion
                   + RTRIM(@cConcepto_Contable)  + LTRIM(REPLICATE('-',5 - LEN(@cConcepto_Contable)))
                   + @cDivisa
                   + @cTipo_Divisa

   IF EXISTS(SELECT 1 FROM PLAN_CUENTA_CONTABLE WHERE ristra_contable = @cRistra)
   BEGIN

      SELECT cuenta_contable,
	     ristra_contable,
             @cRistra_sin_Procesar
      FROM   PLAN_CUENTA_CONTABLE
      WHERE  ristra_contable = @cRistra

   END ELSE BEGIN

      SELECT ' ' ,  @cristra, @cRistra_sin_Procesar

   END

   SET NOCOUNT OFF

END










GO
