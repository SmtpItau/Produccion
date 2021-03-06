USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVENCIMIENTOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERVENCIMIENTOS]
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   DECLARE @nvaluf     FLOAT  
   DECLARE @nvalob     FLOAT

   SELECT @cnomprop = acnomprop
   ,      @cdirprop = acdirprop
   ,      @dfecproc = acfecproc
   ,      @cfecproc = CONVERT(CHAR(10),acfecproc,103)
   ,      @nvaluf   = b.vmvalor
   ,      @nvalob   = c.vmvalor
   FROM   MFAC               
   ,      VIEW_VALOR_MONEDA b
   ,      VIEW_VALOR_MONEDA c
   WHERE  b.vmcodigo = accodmonuf     
   AND    b.vmfecha  = acfecproc      
   AND    c.vmcodigo = accodmondolobs 
   AND    c.vmfecha  = acfecproc


   IF EXISTS(SELECT 1 FROM MFCA				a WHERE a.cafecvcto			  <= @dfecproc) OR 
	  EXISTS(SELECT 1 FROM TBL_CARTERA_FLUJOS WHERE Ctf_Fecha_Vencimiento <= @dfecproc)
   BEGIN

      SELECT 'Producto'           = d.descripcion
      ,      'Tipo Operacion'     = a.catipoper
      ,      'Nombre Cliente'     = c.clnombre
      ,      'Moneda M/X'         = e.mnnemo                                     
      ,      'Monto M/X'          = a.camtomon1
      ,      'Tipo Cambio'        = a.catipcam
      ,      'Valor Futuro'       = CASE WHEN a.cacodpos1 = 10 THEN a.devengo_acum_usd_hoy   --> vPresente
                                         ELSE                       a.caprecal
                                    END
      ,      'Moneda CNV'         = f.mnnemo
      ,      'Monto Final'        = CASE WHEN a.cacodpos1 = 10 THEN A.camtoliq -- a.devengo_acum_cnv_hoy   --> vMercado 
                                         ELSE a.camtomon2
                                    END
      ,      'NumeroOperacion'    = a.canumoper
      ,      'Fecha Inicio'       = CONVERT(CHAR(10),a.cafecha,103)
      ,      'Nombre Propietario' = @cnomprop
      ,      'Direccion'          = @cdirprop
      ,      'Fecha Proceso'      = @cfecproc
      ,      'Monto Compensado'   = CASE WHEN a.cacodpos1 = 10                        THEN a.camtocomp --> a.cavalordia
                                         WHEN a.caantici  = 'A' AND a.cacodpos1  = 13 THEN a.camtocomp
					 WHEN a.caantici  = 'A'                       THEN a.camtoliq
                                         WHEN a.catipmoda = 'C'							THEN 
                                         	      CASE WHEN a.cacodpos1 = 1 AND a.cacalcmpdol = 0		THEN a.camtocomp
                                         		   WHEN a.cacodpos1 = 1 AND a.cacalcmpdol = 999		THEN a.camtocomp
                                         		   WHEN a.cacodpos1 = 1 AND a.cacalcmpdol = 13		THEN (a.camtocomp / isnull(do.vmvalor, 1.0)) 
                                                           ELSE a.camtocomp 
                                                      END
                                         ELSE 0.0
                                    END
      ,      'Fecha Vcto'         = CONVERT(CHAR(10),a.cafecvcto,103)
      ,      'Modalidad'          = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'ValorUF'            = @nvaluf
      ,      'ValorObs'           = @nvalob
      ,      'Hora'               = CONVERT(CHAR(10),GETDATE(),108)
      ,      'Cartera'            = (SELECT rcnombre FROM VIEW_TIPO_CARTERA WHERE cacodpos1 = rccodpro and cacodcart = rcrut)
	  ,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   MFCA a   
                                  LEFT JOIN bacparamsuda..CLIENTE  c ON a.cacodigo   = c.clrut AND a.cacodcli        = c.clcodigo
                                  LEFT JOIN bacparamsuda..PRODUCTO d ON d.id_sistema = 'BFW'   AND d.codigo_producto = a.cacodpos1
                                  LEFT JOIN bacparamsuda..MONEDA   e ON e.mncodmon   = a.cacodmon1
                                  LEFT JOIN bacparamsuda..MONEDA   f ON f.mncodmon   = a.cacodmon2
             LEFT JOIN BacParamSuda.dbo.VALOR_MONEDA do with(nolock) ON do.vmfecha = a.cafecvcto AND do.vmcodigo = 994   
      ,      MFAC
      WHERE  a.cafecvcto       <= @dfecproc
--	AND	a.cacodpos1	<> 13

	UNION

	SELECT	'Producto'           = d.descripcion
	,	'Tipo Operacion'     = a.catipoper
	,	'Nombre Cliente'     = c.clnombre
	,	'Moneda M/X'         = e.mnnemo                                     
	,	'Monto M/X'          = FL.Ctf_Monto_Principal
	,	'Tipo Cambio'        = a.catipcam
	,	'Valor Futuro'       = Ctf_Precio_Contrato
	,	'Moneda CNV'         = f.mnnemo
	,	'Monto Final'        = FL.Ctf_Monto_Secundario
	,	'NumeroOperacion'    = a.canumoper
	,	'Fecha Inicio'       = CONVERT(CHAR(10),a.cafecha,103)
	,	'Nombre Propietario' = @cnomprop
	,	'Direccion'          = @cdirprop
	,	'Fecha Proceso'      = @cfecproc
	,	'Monto Compensado'   =	ROUND(CASE	WHEN a.catipoper = 'C' 
								THEN (ROUND(FL.Ctf_Monto_Principal * @nvaluf,0) - FL.Ctf_Monto_Secundario) 
							ELSE	(FL.Ctf_Monto_Secundario - ROUND(FL.Ctf_Monto_Principal * @nvaluf,0))
						END,0)
	,	'Fecha Vcto'         = CONVERT(CHAR(10),FL.Ctf_Fecha_Vencimiento,103)
	,	'Modalidad'          = 'COMPENSACION'
	,	'ValorUF'            = @nvaluf
	,	'ValorObs'           = @nvalob
	,	'Hora'               = CONVERT(CHAR(10),GETDATE(),108)
	,	'Cartera'            = (SELECT rcnombre FROM VIEW_TIPO_CARTERA WHERE cacodpos1 = rccodpro and cacodcart = rcrut)
	,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
	FROM	MFCA a		LEFT JOIN bacparamsuda..CLIENTE  c ON a.cacodigo   = c.clrut AND a.cacodcli        = c.clcodigo
				LEFT JOIN bacparamsuda..PRODUCTO d ON d.id_sistema = 'BFW'   AND d.codigo_producto = a.cacodpos1
				LEFT JOIN bacparamsuda..MONEDA   e ON e.mncodmon   = a.cacodmon1
				LEFT JOIN bacparamsuda..MONEDA   f ON f.mncodmon   = a.cacodmon2	
	,	TBL_CARTERA_FLUJOS	FL
	WHERE	a.cacodpos1			= 13
	AND	a.canumoper			= FL.Ctf_Numero_Operacion
	AND	FL.Ctf_Fecha_Vencimiento	<= @dfecproc
       ORDER BY a.canumoper

   END 
   ELSE BEGIN
      SELECT 'Producto'           = ''
      ,      'Tipo Operacion'     = ''
    ,      'Nombre Cliente'   = ''
      ,      'Moneda M/X'         = ''
      ,      'Monto M/X'          = 0
      ,      'Tipo Cambio'        = 0
      ,      'Valor Futuro'       = 0
      ,      'Moneda CNV'         = ''
      ,      'Monto Final'        = 0
      ,      'NumeroOperacion'    = 0
      ,      'Fecha Inicio'       = ''
      ,      'Nombre Propietario' = ''
      ,      'Direccion'          = ''
      ,      'Fecha Proceso'      = @cfecproc
      ,      'Monto Compensado'   = 0
      ,      'Fecha Vcto'         = ''
      ,      'Modalidad'          = ''
      ,      'ValorUF'            = @nvaluf
      ,      'ValorObs'           = @nvalob
      ,      'Hora'               = CONVERT(CHAR(10),GETDATE(),108)
      ,      'Cartera'            = ''
	  ,      'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 END   
   SET NOCOUNT OFF
END

GO
