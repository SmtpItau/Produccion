USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_Lim_Per]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_Reporte_Lim_Per]
AS
BEGIN
   SET NOCOUNT ON

    DECLARE @fecha DATETIME
    SET @fecha = (SELECT acfecproc FROM mdac)

  

   DECLARE @ACFECPROC   CHAR(10),
	       @ACFECPROX   CHAR(10),
 	       @UF_HOY      FLOAT,
 	       @UF_MAN      FLOAT,
 	       @IVP_HOY     FLOAT,
	       @IVP_MAN     FLOAT,
	       @DO_HOY      FLOAT,
	       @DO_MAN      FLOAT,
	       @DA_HOY      FLOAT,
	       @DA_MAN      FLOAT,
	       @ACNOMPROP   CHAR(40),
	       @RUT_EMPRESA CHAR(12),
	       @HORA        CHAR(8)

   EXECUTE dbo.sp_Base_Del_Informe
 	      @acfecproc   OUTPUT,
	      @acfecprox   OUTPUT,
	      @uf_hoy      OUTPUT,
	      @uf_man      OUTPUT,
	      @ivp_hoy     OUTPUT,
	      @ivp_man     OUTPUT,
	      @do_hoy      OUTPUT,
	      @do_man      OUTPUT,
	      @da_hoy      OUTPUT,
	      @da_man      OUTPUT,
	      @acnomprop   OUTPUT,
	      @rut_empresa OUTPUT,
	      @hora        OUTPUT




DECLARE @COUNT INT
SET @COUNT = (SELECT COUNT(*) FROM MDDI INNER JOIN mdac                         ON 1 = 1
	                                    INNER JOIN mdcp                         ON cpnumdocu = DINUMDOCU AND cpcorrela = DICORRELA
	                                    LEFT JOIN  VALORIZACION_MERCADO         ON FECHA_VALORIZACION = @fecha
										   AND TIPO_OPERACION = 'CP'
										   AND RMNUMDOCU = DINUMDOCU
										   AND RMCORRELA = DICORRELA
	                                    LEFT JOIN VIEW_TABLA_GENERAL_DETALLE    ON TBCATEG   = 204 
										   AND TBCODIGO1 = DITIPCART
	                                    LEFT JOIN VIEW_EMISOR                   ON EMGENERIC = DIGENEMI
	                                    LEFT JOIN VIEW_TBLimper                 ON VIEW_TBLimper.Cartera = DITIPCART and instrumento = diserie --and.......
	                              WHERE DIGENEMI IN ('BCCH', 'TGR')      AND  --> EMISORES 
		                                DINOMINAL > 0                    AND  --> DISPONIBILIDAD DE NOMINAL
		                                DITIPOPER = 'CP')                 --> CARTERA COMPRA PROPIA)


IF @COUNT <> 0
BEGIN

select 
 'R.U.T.'                    = LTRIM(RTRIM(CONVERT(VARCHAR(15),emrut))) + '-' + emdv
,'Nombre_Emisor'             = emnombre
,'Serie'                     = diinstser
,'Cartera'                   = CASE WHEN TBCODIGO1 = 2 THEN 'AFS' else tbglosa END
,'Um'                        = dinemmon
,'Operaci¾n'                 = ltrim(rtrim(convert(varchar(15),DINUMDOCU))) + '-' + ltrim(rtrim(convert(VARCHAR(15),DICORRELA)))
,'Tasa_Compra'               = ISNULL(tasa_compra,0)
,'Tasa_Mercado'              = ISNULL(tasa_mercado,0)
,'Fecha_Vencimiento'         = cpfecven
,'Nominales_Totales'         = ISNULL(dinominal,0)--ISNULL(valor_nominal,0)
,'Valor_Libro'               = ISNULL(divptirc,0)--ISNULL(Valor_presente,0)
,'Valor_Mercado'             = ISNULL(valor_mercado,0)
,'cpfeccomp'				 = cpfeccomp
,'Plazo_Vto_Permanencia'     = ISNULL(CASE WHEN DATEDIFF(DAY,@fecha,DATEADD(DAY,plazo_maximo,cpfeccomp)) < 0 THEN 0 ELSE DATEDIFF(DAY,@fecha,DATEadd(DAY,plazo_maximo,cpfeccomp)) end ,0)  --ISNULL(Plazo_maximo,0)--DATEDIFF(DAY,cpfeccomp,@fecha) --x
,'Fecha_estimada_venta'      = ISNULL(DATEadd(DAY,plazo_maximo,cpfeccomp),0)--x
,'Plazo_vencido_Permanencia' = ISNULL(CASE WHEN Plazo_maximo > DATEDIFF(DAY,cpfeccomp,@fecha) THEN 0 ELSE abs((Plazo_maximo - DATEDIFF(DAY,cpfeccomp,@fecha))) END ,0)--x
,'Hora'                      = CONVERT(CHAR(10),GETDATE(),108)
,'Plazo_maximo'              = ISNULL(Plazo_maximo,0)--x
,'Nombre Propietario'        = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales) --Min(acnomprop),
,'Rut Propietario'           = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop
,'DÝas de Permanencia'       = DATEDIFF(DAY,cpfeccomp,@fecha) 
,'Corte_control'             = CASE WHEN DATEDIFF(DAY,cpfeccomp,@fecha) > 730 THEN 'Mayor a  730'
                                    WHEN DATEDIFF(DAY,cpfeccomp,@fecha) <= 90 THEN 'Menor a  90'
                                    ELSE 'Entre 90 - 730' 
                                END
,'Numero_corte'            = CASE WHEN DATEDIFF(DAY,cpfeccomp,@fecha) > 730 THEN 1
                                    WHEN DATEDIFF(DAY,cpfeccomp,@fecha) <= 90 THEN 2
                                    ELSE 3 
                                END
FROM MDDI 
	INNER JOIN mdac                         ON 1 = 1
	INNER JOIN mdcp                         ON cpnumdocu = DINUMDOCU
										   AND cpcorrela = DICORRELA
	LEFT JOIN  VALORIZACION_MERCADO        ON FECHA_VALORIZACION = @fecha
										   AND TIPO_OPERACION = 'CP'
										   AND RMNUMDOCU = DINUMDOCU
										   AND RMCORRELA = DICORRELA
	LEFT JOIN VIEW_TABLA_GENERAL_DETALLE    ON TBCATEG   = 204 
										   AND TBCODIGO1 = DITIPCART
	LEFT JOIN VIEW_EMISOR                   ON EMGENERIC = DIGENEMI
	LEFT JOIN VIEW_TBLimper                 ON VIEW_TBLimper.Cartera = DITIPCART and instrumento = diserie --and.......
	WHERE DIGENEMI IN ('BCCH', 'TGR')      AND  --> EMISORES 
		  DINOMINAL > 0                    AND  --> DISPONIBILIDAD DE NOMINAL
		  DITIPOPER = 'CP'                 --> CARTERA COMPRA PROPIA
	ORDER BY cpfeccomp


END

ELSE

BEGIN

select 
 'R.U.T.'                    = ''
,'Nombre_Emisor'             = ''
,'Serie'                     = ''
,'Cartera'                   = ''
,'Um'                        = ''
,'Operaci¾n'                 = ''
,'Tasa_Compra'               = ''
,'Tasa_Mercado'              = ''
,'Fecha_Vencimiento'         = ''
,'Nominales_Totales'         = ''
,'Valor_Libro'               = ''
,'Valor_Mercado'             = ''
,'cpfeccomp'				 = ''
,'Plazo_Vto_Permanencia'     = ''
,'Fecha_estimada_venta'      = ''
,'Plazo_vencido_Permanencia' = ''
,'Hora'                      = ''
,'Plazo_maximo'              = ''
,'Nombre Propietario'        = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales) --Min(acnomprop),
,'Rut Propietario'           = ''
,'DÝas de Permanencia'       = ''
,'Corte_control'             = ''
,'Numero_corte'              = ''


END



   SET NOCOUNT OFF

END
-- Base de Datos --

GO
