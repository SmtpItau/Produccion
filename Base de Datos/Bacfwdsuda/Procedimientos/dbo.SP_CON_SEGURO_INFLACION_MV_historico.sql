USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_SEGURO_INFLACION_MV_historico]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CON_SEGURO_INFLACION_MV_historico]
   (   @nNumOper   NUMERIC(10)   )
AS
BEGIN


   DECLARE @dFecha          DATETIME
   ,       @dFechaProceso   DATETIME

   SET NOCOUNT ON

   SELECT  @dFechaProceso   = acfecproc
   FROM    MFAC

   SELECT  @dFecha          = fecharecepcion
   FROM    MFCA 
   WHERE   canumoper        = @nnumoper 

   DECLARE @dFechaCierre    DATETIME
       SET @dFechaCierre    = (SELECT cafecha FROM BacFwdsuda.dbo.MFCA WHERE canumoper = @nnumoper)


   IF EXISTS(SELECT 1 FROM MFCA WHERE canumoper = @nnumoper)
   BEGIN
      IF @dFechaCierre >= @dFechaProceso
      BEGIN

           SELECT  Ctf_Numero_OPeracion
	      ,	   cacodigo	-- RUT CLIENTE
	      ,	   cacodcli	-- CODIGO CLIENTE
	      ,	   catipoper
	      ,	   cafecha
	      ,	   Ctf_Numero_Credito
	      ,	   Ctf_Correlativo
	      ,	   Ctf_Numero_Dividendo
	      ,	   Ctf_Plazo
	      ,	   Ctf_Fecha_Vencimiento
	      ,	   Ctf_Fecha_Fijacion
	      ,	   Ctf_Monto_Principal
	      ,	   Ctf_Precio_Contrato
	      ,	   Ctf_Precio_Costo
	      ,	   Ctf_Spread
	      ,	   Ctf_Tasa_Moneda_Principal
	      ,	   Ctf_Tasa_Moneda_Secundaria
	      ,	   Ctf_Precio_Proyectado
	      ,	   Ctf_Monto_Secundario
	      ,	   caoperador
	      ,	   CONVERT(CHAR(10),@dFechaProceso,103)	as Fecha_Proc
	      ,	   CONVERT(CHAR(10), GETDATE(),108)		as Hora
	   FROM	   BacFwdSuda.dbo.MFCA
		   INNER  JOIN BacFwdSuda.dbo.TBL_CARTERA_FLUJOS ON Ctf_Numero_OPeracion = canumoper
	   WHERE   canumoper	= @nnumoper 
	   ORDER BY ctf_numero_operacion, ctf_correlativo

      END ELSE
      BEGIN

           SELECT  Ctf_Numero_OPeracion       = grdfl.Ctf_Numero_OPeracion
	      ,	   cacodigo                   = cacodigo
	      ,	   cacodcli                   = cacodcli
	      ,	   catipoper                  = catipoper
	      ,	   cafecha                    = cafecha
	      ,	   Ctf_Numero_Credito         = grdfl.Ctf_Numero_Credito
	      ,	   Ctf_Correlativo            = grdfl.Ctf_Correlativo
	      ,	   Ctf_Numero_Dividendo       = grdfl.Ctf_Numero_Dividendo
	      ,	   Ctf_Plazo                  = grdfl.Ctf_Plazo
	      ,	   Ctf_Fecha_Vencimiento      = grdfl.Ctf_Fecha_Vencimiento
	      ,	   Ctf_Fecha_Fijacion         = grdfl.Ctf_Fecha_Fijacion
	      ,	   Ctf_Monto_Principal        = grdfl.Ctf_Monto_Principal
	      ,	   Ctf_Precio_Contrato        = grdfl.Ctf_Precio_Contrato
	      ,	   Ctf_Precio_Costo           = grdfl.Ctf_Precio_Costo
	      ,	   Ctf_Spread                 = grdfl.Ctf_Spread
	      ,	   Ctf_Tasa_Moneda_Principal  = grdfl.Ctf_Tasa_Moneda_Principal
	      ,	   Ctf_Tasa_Moneda_Secundaria = grdfl.Ctf_Tasa_Moneda_Secundaria
	      ,	   Ctf_Precio_Proyectado      = grdfl.Ctf_Precio_Proyectado
	      ,	   Ctf_Monto_Secundario       = grdfl.Ctf_Monto_Secundario
	      ,	   caoperador
	      ,	   Fecha_Proc                 = CONVERT(CHAR(10),@dFechaProceso, 103)
	      ,	   Hora                       = CONVERT(CHAR(10), GETDATE(),     108)
	   FROM	   BacFwdSuda.dbo.MFCA
                   INNER JOIN (SELECT Ctf_Numero_OPeracion          = Ctf_Numero_OPeracion  
				  ,   Ctf_Correlativo               = Ctf_Correlativo
				  ,   Ctf_Numero_Credito            = Ctf_Numero_Credito
				  ,   Ctf_Numero_Dividendo          = Ctf_Numero_Dividendo
				  ,   Ctf_Plazo                     = Ctf_Plazo
				  ,   Ctf_Fecha_Vencimiento         = Ctf_Fecha_Vencimiento
				  ,   Ctf_Fecha_Fijacion            = Ctf_Fecha_Fijacion
				  ,   Ctf_Monto_Principal           = Ctf_Monto_Principal
				  ,   Ctf_Precio_Contrato           = Ctf_Precio_Contrato
				  ,   Ctf_Precio_Costo              = Ctf_Precio_Costo
				  ,   Ctf_Monto_Secundario          = Ctf_Monto_Secundario
				  ,   Ctf_Spread                    = Ctf_Spread
				  ,   Ctf_Tasa_Moneda_Principal     = Ctf_Tasa_Moneda_Principal
				  ,   Ctf_Tasa_Moneda_Secundaria    = Ctf_Tasa_Moneda_Secundaria
				  ,   Ctf_Precio_Proyectado         = Ctf_Precio_Proyectado
				  ,   Ctf_Valor_Razonable_Activo    = Ctf_Valor_Razonable_Activo
				  ,   Ctf_Valor_Razonable_Pasivo    = Ctf_Valor_Razonable_Pasivo
				  ,   Ctf_Valor_Razonable           = Ctf_Valor_Razonable
				  ,   Ctf_Articulo84                = Ctf_Articulo84
			       FROM   TBL_CARTERA_FLUJOS            
                              WHERE   Ctf_Numero_OPeracion          = @nnumoper

			      UNION

			      SELECT  Ctf_Numero_OPeracion          = Cfr_Numero_OPeracion
				  ,   Ctf_Correlativo               = Cfr_Correlativo
				  ,   Ctf_Numero_Credito            = Cfr_Numero_Credito
				  ,   Ctf_Numero_Dividendo          = Cfr_Numero_Dividendo
				  ,   Ctf_Plazo                     = Cfr_Plazo
				  ,   Ctf_Fecha_Vencimiento         = Cfr_Fecha_Vencimiento
				  ,   Ctf_Fecha_Fijacion            = Cfr_Fecha_Fijacion
				  ,   Ctf_Monto_Principal           = Cfr_Monto_Principal
				  ,   Ctf_Precio_Contrato           = Cfr_Precio_Contrato
				  ,   Ctf_Precio_Costo              = Cfr_Precio_Costo
				  ,   Ctf_Monto_Secundario          = Cfr_Monto_Secundario
				  ,   Ctf_Spread                    = Cfr_Spread
				  ,   Ctf_Tasa_Moneda_Principal     = Cfr_Tasa_Moneda_Principal
				  ,   Ctf_Tasa_Moneda_Secundaria    = Cfr_Tasa_Moneda_Secundaria
				  ,   Ctf_Precio_Proyectado         = Cfr_Precio_Proyectado
				  ,   Ctf_Valor_Razonable_Activo    = 0
				  ,   Ctf_Valor_Razonable_Pasivo    = 0
				  ,   Ctf_Valor_Razonable           = 0
				  ,   Ctf_Articulo84                = 0
                              FROM    TBL_CARTERA_FLUJOS_RES   
                              WHERE   Cfr_Numero_OPeracion          = @nnumoper
                                AND   Cfr_Estado                    = 'V'
                              ) grdfl ON grdfl.Ctf_Numero_OPeracion = canumoper
	   WHERE   canumoper	= @nnumoper 
	   ORDER BY grdfl.ctf_numero_operacion, grdfl.ctf_correlativo
      END
   END
END
GO
