USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FAX_T_LOCK_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_FAX_T_LOCK_FORWARD]  
       (  
        @nNumOper FLOAT,
        @Usuario  CHAR(20) = ''
       )  
AS  

BEGIN  
SET NOCOUNT ON  

   DECLARE @cTraCon          CHAR ( 40 )
   DECLARE @cVendedor        CHAR ( 70 )
   DECLARE @cFaxVen          CHAR ( 20 )
   DECLARE @cOpeVen          CHAR ( 40 )
   DECLARE @cComprador       CHAR ( 70 )
   DECLARE @cFaxCom          CHAR ( 20 )
   DECLARE @cOpeCom          CHAR ( 40 )
   DECLARE @cTipOpe          CHAR ( 10 )
   DECLARE @nPreSpt          NUMERIC ( 16, 10 )
   DECLARE @nObsIni          NUMERIC ( 08, 02 )
   DECLARE @nUFIni           NUMERIC ( 08, 02 )
   DECLARE @dFecIni          DATETIME  
   DECLARE @nCodMon          NUMERIC ( 03, 00 )
   DECLARE @nCodCnv          NUMERIC ( 03, 00 )
   DECLARE @cCodMon          CHAR ( 03 )  
   DECLARE @cCodCnv          CHAR ( 03 )  
   DECLARE @nPagoMx          NUMERIC ( 05, 00 )
   DECLARE @cPagoMx          CHAR ( 10 )  
   DECLARE @cModalidad       CHAR ( 14 )  
   DECLARE @cFirCom          CHAR ( 40 )  
   DECLARE @cFirVen          CHAR ( 40 )  
   DECLARE @nPreFut          NUMERIC ( 16, 10 )
   DECLARE @cNomprop         CHAR(50)  
   DECLARE @diasvalor        INT  
   DECLARE @feriado          INT  
   DECLARE @cfecvaluta       DATETIME
   DECLARE @pais             INT  
   DECLARE @pie_compra       CHAR(70)
   DECLARE @pie_venta        CHAR(70)
   DECLARE @Nombre_cliente   CHAR(70)
   DECLARE @Instrumento      CHAR(20)
   Declare @Glosa_Area       CHAR(70)
   DECLARE @Area             INT  
   DECLARE @Fax_Cliente      CHAR ( 20 )
   DECLARE @Codigo_Instr     INT   
   DECLARE @Familia_Serie    CHAR( 20 )
   DECLARE @Fecha_Vcto_Instrumento   DATETIME  


 /*=======================================================================*/  
    --> PRD 12712			
			
    DECLARE @ET_Periodicidad CHAR(50)
	DECLARE @Tipo_Cambio     VARCHAR(50)
	DECLARE @Paridad         VARCHAR(50)
	DECLARE @FPagoMN		 VARCHAR(50)
	DECLARE @FPagoMX		 VARCHAR(50)

	-- Periodicidad, se debe utilizar en el case
	--SELECT @ET_Periodicidad = CASE WHEN Periodicidad = 0          THEN 'NA' ELSE gd.tbglosa  END
	
	SELECT @ET_Periodicidad = CASE WHEN bearlytermination	= 0  THEN ''   ELSE gd.tbglosa  END  
	,      @Tipo_Cambio     = CASE WHEN ISNULL(rm.glosa,'') = '' THEN ''   ELSE rm.glosa    END
	,      @Paridad         = CASE WHEN cacolmon1 = 0            THEN ''   ELSE par.Glosa   END 
	,      @FPagoMN = fpMn.glosa
	,      @FPagoMX = fpMx.glosa 
	  FROM MFCA
		   INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE gd ON Periodicidad = gd.tbcodigo1
	       LEFT JOIN (    SELECT DISTINCT Codigo, Glosa 
			                FROM BacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO  
				                 INNER JOIN BacParamSuda.dbo.REFERENCIA_MERCADO     ON Codigo = Referencia
                           WHERE Estado    = 0
                             AND Producto  = 1 
	                 )        rm ON cacodpos2 = rm.Codigo
	       LEFT JOIN (    SELECT DISTINCT Codigo, Glosa 
			                FROM BacParamSuda.dbo.REFERENCIA_MERCADO_PRODUCTO  
				                 INNER JOIN BacParamSuda.dbo.REFERENCIA_MERCADO     ON Codigo = Referencia
                           WHERE Estado    = 0
                             AND Producto  = 12 
	                 )       par ON cacolmon1 = par.Codigo 
	       LEFT JOIN	(	SELECT clrut, clcodigo, clnombre 
		         	 		FROM	BacparamSuda.dbo.cliente WITH(NOLOCK)
						)	Cli		ON Cli.clrut = cacodigo AND clcodigo = cacodcli
		   LEFT JOIN	(	SELECT	codigo, glosa 
		         	 		FROM	BacparamSuda.dbo.Forma_de_pago WITH(NOLOCK)
						)	fpMn	ON fpMn.codigo = cafpagomn 

   		   LEFT JOIN	(	SELECT	codigo, glosa 
		         	 		FROM	BacparamSuda.dbo.Forma_de_pago WITH(NOLOCK)
						)	fpMx	ON fpMx.codigo = cafpagomx 
	 WHERE CaNumOper          = @nNumOper   
	 AND   gd.tbcateg         = 9920
	 AND   cafecha            = (SELECT acfecproc FROM BacFwdSuda.dbo.Mfac)  
	 
	--> PRD 12712	
	/*=======================================================================*/  
	 
  
  		DECLARE @Conta NUMERIC(10)

		SET @Conta = (SELECT charindex('-', (SELECT nombre FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)))

     SELECT @pais    = acpais  
   FROM   mfac      

   SELECT @cNomprop = rcnombre from VIEW_ENTIDAD
   SELECT @dFecIni  = CaFecha  FROM mfca WHERE canumoper = @nNumOper
   SELECT @nObsIni = ISNULL ( VmValor, 0 ) FROM VIEW_VALOR_MONEDA WHERE VmCodigo = 994 AND VmFecha = @dFecIni
   SELECT @nUFIni  = ISNULL ( VmValor, 0 ) FROM VIEW_VALOR_MONEDA WHERE VmCodigo = 998 AND VmFecha = @dFecIni
   SELECT @cTraCon    = ISNULL ( a.OpNombre, '' ),  
          @cVendedor  = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ClNombre         ELSE @cNomprop          END ), '' ) ,
          @cFaxVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ClFax            ELSE AcFax              END ), '' ) ,
          @cOpeVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cTraCon         ELSE b.nombre           END ), '' ) ,
          @cComprador = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ClNombre           END ), '' ) ,
          @cFaxCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN AcFax            ELSE ClFax              END ), '' ) ,
          @cOpeCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN b.nombre         ELSE @cTraCon           END ), '' ) ,
          @cTipOpe    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN 'COMPRA    '     ELSE 'VENTA     '       END ), '' ) ,
          @nPreSpt    = ISNULL ( ( CASE CaCodMon2 WHEN 999 THEN @nObsIni         ELSE @nObsIni / @nUFIni END ), 0  ) ,
          @nCodMon    = ISNULL ( CaCodMon1, 0 )          ,  
          @nCodCnv    = ISNULL ( CaCodMon2, 0 )          ,  
          @nPagoMx    = ISNULL ( CaFPagoMx, 0 )          ,  
          @cModalidad = ISNULL ( ( CASE CaTipModa WHEN 'C' THEN 'COMPENSACION  ' ELSE 'ENTREGA FISICA'   END ), '' ) ,
          @cFirCom    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN @cNomprop        ELSE ''                 END ), '' ) ,
          @cFirVen    = ISNULL ( ( CASE CaTipOper WHEN 'C' THEN ''               ELSE @cNomprop          END ), '' ) ,
          @nPreFut    = ISNULL ( ( CASE CaCodPos1 WHEN 3   THEN CaPreMon2        ELSE catipcam           END ), 0 ) , 
          @cfecvaluta = cafecvcto           ,  
          @pie_compra = CASE CaTipOper WHEN 'C' THEN @cNomprop ELSE '' END      ,
          @pie_venta  = CASE CaTipOper WHEN 'V' THEN @cNomprop ELSE '' END      ,
          @Nombre_cliente = clnombre,  
          @Fax_Cliente    = Clfax,  
          @Instrumento = caserie,  
          @Area        = caArea_Responsable,
          @Codigo_Instr = cabroker  
     

  /* FROM  
          MFCA,
          VIEW_CLIENTE,
          MFAC,  
          VIEW_CLIENTE_OPERADOR a,
          VIEW_USUARIO b  
   WHERE    
          CaNumOper      = @nNumOper AND
         (CaCodigo       = ClRut     AND
          cacodcli       = clcodigo ) AND
          CaCodigo      *= a.OpRutCli  AND
          CaContraparte *= a.OpRutOpe  AND
          CaOperador    *= b.usuario */  
   --Rq7619  

  FROM  
          MFCA LEFT OUTER JOIN  VIEW_CLIENTE_OPERADOR a ON CaCodigo   = a.OpRutCli AND CaContraparte = a.OpRutOpe
               LEFT OUTER JOIN  VIEW_USUARIO          b ON CaOperador = b.usuario,  
		  VIEW_CLIENTE,    
          MFAC      
   WHERE    
          CaNumOper      = @nNumOper AND
         (CaCodigo       = ClRut     AND
          cacodcli       = clcodigo )   
         

   SELECT @cCodMon = ISNULL ( MnNemo, '' ) FROM  VIEW_MONEDA WHERE @nCodMon = MnCodMon
   SELECT @cCodCnv = ISNULL ( MnNemo, '' ) FROM  VIEW_MONEDA WHERE @nCodCnv = MnCodMon
   SELECT @cPagoMx   = Glosa2 ,  
   @diasvalor = diasvalor    
   FROM VIEW_FORMA_DE_PAGO   
   WHERE Codigo = @nPagoMx  
/*  

Obtiene glosa de area responsable  

*/  

Declare @Operador as varchar(15)  
set @Operador = (select top 1 caoperador from MFCA where canumoper = @nNumOper)  

  

SELECT @Glosa_Area =  tbglosa   
  FROM   VIEW_TABLA_GENERAL_DETALLE
  ,      VIEW_TBL_RELACIONES  
  WHERE  tbcateg        = '1553'
  AND    tbcodigo1      = Rel_IdRelacion1
  AND    Rel_IdCodigo1  = 'BFW'  
  AND    tbcateg        = Rel_IdCodigo2
  AND    tbcodigo1      = @Area  
  

  
SELECT @Fecha_Vcto_Instrumento = Fecha_Vcto  FROM instrumentos_subyacentes_inv_ext where Cod_Nemo = @Instrumento 

SELECT @Familia_Serie = Nom_Familia  from bacbonosextsuda..text_fml_inm i where i.Cod_familia = @Codigo_Instr    

 Declare @Rut_Cli as numeric(9)  
 set @Rut_Cli = (select cacodigo from MFCA where canumoper = @nNumOper)
   

 Declare @Cod_Cli as numeric(5)  
 set @Cod_Cli = (select cacodcli from MFCA where canumoper = @nNumOper)  

  

  /*=======================================================================*/  

   SELECT 'Proprietario'       = @cNomprop                               ,  
          'Numoper'            = @nNumOper                                , 
          'Fecha Inicio'       = CONVERT ( CHAR ( 10 ), CaFecha  , 103 ) ,  
          'Fecha Vto'          = CONVERT ( CHAR ( 10 ), CaFecVcto, 103 ) ,  
          'Plazo'              = CaPlazo                                 ,  
          'Valor UF INI '      = @nUFIni                                 ,  
          'Valor Obs Ini'      = @nObsIni                                ,  
          'Vendedor'           = @cVendedor                              ,  
          'FaxVta'             = @cFaxVen                                ,  
          'Operador Ven'       = @cOpeVen                                ,  
          'Comprador'          = @cComprador                             ,  
          'FaxCMP'             = @cFaxCom                                ,  
          'Operador com'       = @cOpeCom                                ,  
          'TipoOPer'           = @cTipOpe                                ,  
          'Mto Mex'            = CaMtoMon1                               ,  
          'CodMoneda'          = @cCodMon                                ,  
          'CodCnversion'       = @cCodCnv                                ,
          'Precio'             = catipcam     ,   --CaPreCal                                ,  
          'Precio Spt'         = @nPreSpt                                ,  
          'Precio futuro'      = @nPreFut                                ,  
          'Monto Final'        = CaMtoMon2                               ,  
          'Modalidad'          = @cModalidad        ,  
          'PagoMX'             = ISNULL ( @cPagoMx, '' )                 ,  
          'Glosa'              = MnGlosa                                 ,  
          'No. Fax Enitidad'   = AcFax                                   ,  
          'Firma Compra'       = @cFirCom                                ,  
          'Firma Venta'        = @cFirVen                                ,  
          'Nombre Entidad'     = (Select rcnombre from VIEW_ENTIDAD where rccodcar=cacodsuc1 )       , 
          'Pie_compra'         = @pie_compra      ,  
          'Pie_Venta'          = @pie_venta ,  
          'Nombre Cliente'     = @Nombre_cliente,  
          'Usuario'            = @Usuario,  
          'Instrumento'        = @Instrumento,  
          'Glosa_Area'         = @Glosa_Area,  
          'Fax_Cliente'        = @Fax_Cliente,  
          'Familia'            = @Familia_Serie,  
          'Fecha_Vcto_Papel'   = @Fecha_Vcto_Instrumento,  
            'firmabanco'         = CASE WHEN @cTipOpe = 'COMPRA' THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario)  
			                     ELSE '' END,
		  'firmabancov'        = CASE WHEN @cTipOpe = 'VENTA'  THEN (select firma from bacparamsuda..reportes_firma where nombre_usuario = @Usuario)  
			                     ELSE '' END
		, 'Usuario_Banco'	   = CASE WHEN @cTipOpe = 'COMPRA' THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
								 ELSE '' END 		
		, 'Usuario_Bancov'     = CASE WHEN @cTipOpe = 'VENTA'  THEN (SELECT rtrim(ltrim(nombre)) FROM BACPARAMSUDA..USUARIO WHERE USUARIO = @Usuario)
								 ELSE '' END 
		 --> PRD 12712
		, 'ET_Marca'            = MFCA.bEarlyTermination
		, 'ET_IdPeriodicidad'   = MFCA.Periodicidad
		, 'ET_Periodicidad'     = @ET_Periodicidad
		, 'ET_FechaInicio'      = MFCA.FechaInicio		  
		, 'Tipo_Cambio'         = @Tipo_Cambio
		, 'Paridad'             = @Paridad
		, 'Swap_FX_Spot'	    = caoperrelaspot 
		, 'FPagoMN'             = ISNULL(@FPagoMN,'0')
		, 'FPagoMX'             = ISNULL(@FPagoMX,'0')

 /* FROM  
          MFAC, 
          MFCA,  
          VIEW_MONEDA  
   WHERE  
          CaNumOper   = @nNumOper AND  
          CaMdaUSD   *= MnCodMon */  
   --Rq 7619  

   FROM  
         MFCA LEFT OUTER JOIN  VIEW_MONEDA ON   CaMdaUSD = MnCodMon ,  
         MFAC   
   WHERE  
          CaNumOper   = @nNumOper  

  

SET NOCOUNT OFF  

END  

GO
