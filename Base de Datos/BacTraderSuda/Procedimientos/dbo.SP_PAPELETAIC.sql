USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PAPELETAIC]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_PAPELETAIC] 
                     (		@xNumeroOperacion NUMERIC(10)						
						,	@FechaConsulta DATETIME
						)
AS
BEGIN

/*=======================================================================*/
 DECLARE @firma1 char(15)
 DECLARE @firma2 char(15)

	  Select @firma1=rtrim(ltrim(res.Firma1)),
		 @firma2=rtrim(ltrim(res.Firma2))
	   From BacLineas.dbo.detalle_aprobaciones res
	   Where res.Numero_Operacion=@xNumeroOperacion
/*=======================================================================*/

/*MODIFICADO POR LD1-COR-035 PAPELETA CAPTACIONES*/


DECLARE @ACNOMPROP  CHAR(40)
DECLARE @ACFECPROC  CHAR(10)
DECLARE @ACRUTPROP NUMERIC (9)
DECLARE @ACDIGPROP      CHAR(1)

DECLARE @dFechaProceso	DATETIME

SELECT 
 @ACNOMPROP = acnomprop,
 @ACFECPROC = acfecproc,
 @ACRUTPROP = acrutprop,
 @ACDIGPROP = acdigprop,
 @dFechaProceso	= acfecproc
  FROM MDAC           
  
----Operaciones del dia
 if  @FechaConsulta = @dFechaProceso
 begin     
		 SELECT   'Fecpro'=CONVERT(CHAR(10),mofecpro,103),  --Fecha de Operación(1)
			 'Rutcart'=RTRIM(LTRIM(STR(morutcart))+'-'+rcdv), --Rut de Catera(2)
		   monumdocu   ,   --Numero de Documento(3)
		   mocorrela   ,   --Correlativo Operación(4)
		   monumoper   ,   --Numero de Operación(5)
		   motipoper   ,   --Tipo de Operación(6)
		   monominal   ,   --Nominal(7)
		   movpresen   ,   --Valor Inicio $$(8)
		   Tasa    ,   --Tasa Captación(9)
		   Tasa_tran   ,   --Tasa Transferencia(10)
		   'FechaIni'=CONVERT(CHAR(10),mofecinip,103),  --Fecha de Inicio(11)
		   'FechaVcto'=CONVERT(CHAR(10),mofecvenp,103),  --Fecha de Vencimiento(12)
		   'plazo'=DATEDIFF(DAY,mofecinip,mofecvenp),  --Plazo(13)
		   monominal   ,   --Valor Inicio(14)
		   movalvenp   ,   --Valor Final(15)
		   'monpact'=mnnemo  ,   --Moneda de la Operación(16)
		   'forpagini'=glosa  ,   --Forma pago Inicio(17)
		   'Rutcliente'=RTRIM(LTRIM(STR(morutcli))+'-'+cldv), --Rut de Cliente(18)
		   mocodcli   ,   --Codigo de Cliente(19)
		   motipret   ,   --Tipo de Retiro(20)
		   'custodia'=CASE Custodia WHEN 'P' THEN 'PROPIA'
							  WHEN 'C' THEN 'CLIENTE'
								 ELSE 'DCV' END,  --Custodia(21)
		   mohora    ,   --Hora de la Operación(22)
		   mousuario   ,   --Usuario(23)
		   moterminal   ,   --Terminal(24)
		   'tipodep'=CASE m.Tipo_Deposito WHEN 'R' THEN 'RENOVABLE'
									  ELSE     'FIJO' END, --Tipo de Deposito(25)
		   'nomentidad'=rcnombre  ,   --Nombre Entidad(26)
		   'nomcliente'=clnombre  ,   --Nombre del Cliente(27)
		   'ValorMoneda'=CASE momonpact WHEN 999 THEN 1 
				  ELSE ISNULL(vmvalor,0) END, --Valor Unidad Monetaria 
				  mostatreg,
		 'banco' =  @ACNOMPROP ,
		 'codigo_AS400' = codigo_as400,
		 'diaPago' = CASE WHEN m.Fecha_PagoMañana = '1900-01-01' then ''
						else  Convert(char(10), m.Fecha_PagoMañana, 103)
						end,
		 'Obser' = m. moobserv,
		 'Linea1' = m.moobserv2,
		 'Foncli' = clfono ,
		 'Faxcli' = clfax  ,
		 'Dircli' = cldirecc,
		  'Tipcli'= (SELECT tbglosa    
					FROM VIEW_TABLA_GENERAL_DETALLE
					WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,cltipcli)),
		'condicion' = CASE WHEN RTRIM(LTRIM(GEN_CAPTACION.Condicion_Captacion)) = 'E' THEN 'ENDOSABLE' ELSE 'NOMINATIVO' END,
		'base'		= m.mobasemi
		,'CodigoDCV'   = ISNULL(moclave_dcv ,'')    
        ,'CuentaDCV'   = ISNULL(GEN_CAPTACION.numero_certificado_dcv,m.numero_certificado_dcv)
        ,'certificado_dcv'= GEN_CAPTACION.numero_certificado_dcv
        ,'TipoRetiro'	  = CASE RTRIM(LTRIM(motipret)) WHEN 'R' THEN 'RETENER' ELSE 'ENTREGAR' END   --Tipo de Retiro       
	/* ========================================================================================================================================================= */
	/* +++ VBF 10-10-2018 se agrega tipo de emision a papeleta																									 */
		,'Emision' = case when GEN_CAPTACION.Tipo_Emision = 2 then 'DESMATERIALIZADO' ELSE 'FISICO' END 
	/* --- VBF 10-10-2018 se agrega tipo de emision a papeleta																									 */
	/* ========================================================================================================================================================= */
		  ,'Firma1'=@firma1
		  ,'Firma2'=@firma2
		  FROM --  REQ. 7619 
			  MDMO m LEFT OUTER JOIN VIEW_VALOR_MONEDA ON mofecpro  = vmfecha  
													AND  momonpact = vmcodigo  
			 , GEN_CAPTACION
			 , VIEW_ENTIDAD
			 , VIEW_CLIENTE
			 , VIEW_FORMA_DE_PAGO
			 , VIEW_MONEDA
		--  REQ. 7619
		--   , VIEW_VALOR_MONEDA
		  WHERE  (motipoper = 'AIC' OR  motipoper = 'IC') AND
		   monumoper = numero_operacion AND
		   mocorrela = correla_operacion AND
		   monumoper = @xnumerooperacion AND
		   morutcart = rcrut  AND
		   morutcli  = clrut  AND
		   mocodcli  = clcodigo AND --20180508 jcamposd debe considerar el codigo cliente
		   codigo    = moforpagi  AND
		   momonpact = mncodmon  
		--  REQ. 7619
		/*
		   mofecpro  *= vmfecha  AND
		   momonpact *= vmcodigo  
		*/
		  ORDER BY mocorrela

END
else
begin
 SELECT   'Fecpro'=CONVERT(CHAR(10),mofecpro,103),  --Fecha de Operación(1)
			 'Rutcart'=RTRIM(LTRIM(STR(morutcart))+'-'+rcdv), --Rut de Catera(2)
		   monumdocu   ,   --Numero de Documento(3)
		   mocorrela   ,   --Correlativo Operación(4)
		   monumoper   ,   --Numero de Operación(5)
		   motipoper   ,   --Tipo de Operación(6)
		   monominal   ,   --Nominal(7)
		   movpresen   ,   --Valor Inicio $$(8)
		   Tasa    ,   --Tasa Captación(9)
		   Tasa_tran   ,   --Tasa Transferencia(10)
		   'FechaIni'=CONVERT(CHAR(10),mofecinip,103),  --Fecha de Inicio(11)
		   'FechaVcto'=CONVERT(CHAR(10),mofecvenp,103),  --Fecha de Vencimiento(12)
		   'plazo'=DATEDIFF(DAY,mofecinip,mofecvenp),  --Plazo(13)
		   monominal   ,   --Valor Inicio(14)
		   movalvenp   ,   --Valor Final(15)
		   'monpact'=mnnemo  ,   --Moneda de la Operación(16)
		   'forpagini'=glosa  ,   --Forma pago Inicio(17)
		   'Rutcliente'=RTRIM(LTRIM(STR(morutcli))+'-'+cldv), --Rut de Cliente(18)
		   mocodcli   ,   --Codigo de Cliente(19)
		   motipret   ,   --Tipo de Retiro(20)
		   'custodia'=CASE Custodia WHEN 'P' THEN 'PROPIA'
							  WHEN 'C' THEN 'CLIENTE'
								 ELSE 'DCV' END,  --Custodia(21)
		   mohora    ,   --Hora de la Operación(22)
		   mousuario   ,   --Usuario(23)
		   moterminal   ,   --Terminal(24)
		   'tipodep'=CASE m.Tipo_Deposito WHEN 'R' THEN 'RENOVABLE'
									  ELSE     'FIJO' END, --Tipo de Deposito(25)
		   'nomentidad'=rcnombre  ,   --Nombre Entidad(26)
		   'nomcliente'=clnombre  ,   --Nombre del Cliente(27)
		   'ValorMoneda'=CASE momonpact WHEN 999 THEN 1 
				  ELSE ISNULL(vmvalor,0) END, --Valor Unidad Monetaria 
				  mostatreg,
		 'banco' =  @ACNOMPROP ,
		 'codigo_AS400' = codigo_as400,
		 'diaPago' = CASE WHEN m.Fecha_PagoMañana = '1900-01-01' then ''
						else  Convert(char(10), m.Fecha_PagoMañana, 103)
						end,
		 'Obser' = m. moobserv,
		 'Linea1' = m.moobserv2,
		 'Foncli' = clfono ,
		 'Faxcli' = clfax  ,
		 'Dircli' = cldirecc,
		  'Tipcli'= (SELECT tbglosa    
					FROM VIEW_TABLA_GENERAL_DETALLE
					WHERE tbcateg=207 AND CONVERT(INTEGER,tbcodigo1)=CONVERT(INTEGER,cltipcli)),		  
		'condicion' = CASE WHEN RTRIM(LTRIM(GEN_CAPTACION.Condicion_Captacion)) = 'E' THEN 'ENDOSABLE' ELSE 'NOMINATIVO' END,
		'base'		= m.mobasemi
		,'CodigoDCV'   = ISNULL(moclave_dcv ,'')    
        ,'CuentaDCV'   = ISNULL(GEN_CAPTACION.numero_certificado_dcv,m.numero_certificado_dcv)		
        ,'certificado_dcv'= GEN_CAPTACION.numero_certificado_dcv   
        ,'TipoRetiro'	  = CASE RTRIM(LTRIM(motipret)) WHEN 'R' THEN 'RETENER' ELSE 'ENTREGAR' END   --Tipo de Retiro       
	/* ========================================================================================================================================================= */
	/* +++ VBF 10-10-2018 se agrega tipo de emision a papeleta																									 */
		,'Emision' = case when GEN_CAPTACION.Tipo_Emision = 2 then 'DESMATERIALIZADO' ELSE 'FISICO' END 
	/* --- VBF 10-10-2018 se agrega tipo de emision a papeleta																									 */
	/* ========================================================================================================================================================= */
		  ,'Firma1'=@firma1
		  ,'Firma2'=@firma2
		  FROM GEN_CAPTACION 
			INNER JOIN MDMH M  ON
				monumoper = @xnumerooperacion
				AND monumoper = numero_operacion 
				AND mocorrela = correla_operacion
			INNER JOIN VIEW_ENTIDAD ON
				rcrut = GEN_CAPTACION.entidad
			INNER JOIN VIEW_CLIENTE ON
				clrut  = morutcli 
				AND Clcodigo = mocodcli
			INNER JOIN VIEW_FORMA_DE_PAGO ON
				codigo    = moforpagi		
			INNER JOIN VIEW_MONEDA ON
				mncodmon = momonpact 		
			LEFT OUTER JOIN VIEW_VALOR_MONEDA ON vmfecha  = @FechaConsulta  
													AND  momonpact = vmcodigo  
		  --WHERE  (motipoper = 'AIC' OR  motipoper = 'IC')

		  ORDER BY mocorrela


end

end

GO
