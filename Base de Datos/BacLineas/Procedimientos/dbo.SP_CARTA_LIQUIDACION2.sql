USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTA_LIQUIDACION2]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARTA_LIQUIDACION2](	@tipoper 	CHAR(10),
					        @cliente	CHAR(50)	,
					        @monto_mon	FLOAT		,
					        @monto_pesos	FLOAT		,
					        @forma_pago	CHAR(50)	,
					        @valuta		CHAR(8)		,
					        @Numoper        FLOAT	,
					        @Merc	        CHAR(4) 	,
					        @ForpagR        CHAR(30)= ' '
					)

AS
BEGIN

--declare @acfecproc datetime 
--select @acfecproc = acfecproc from view_Mdac 
------- saca monto escrito **  
declare @monto_escrito char(170)
execute BACTRAdersuda..SP_MONTOESCRITO @monto_pesos,@monto_escrito output
-------------------------- **
 DECLARE @FORPAG CHAR (5)
	SELECT	'FECHA'			=	CONVERT( CHAR(10),acfecpro,103)										,
		'CLIENTE'		=	@cliente													,
		'MONTO1'		=	@monto_mon													,
		'FECHA_VALUTA'		=	CONVERT(CHAR(10),CONVERT(DATETIME,@valuta),103)									,
		'FORMA_DE_PAGO'		=	@forma_pago													,
		'MONTO2'		=	case when a.mocodcnv ='USD' then a.moussme else @monto_pesos   END						,							
		'CTA_CTE'		=	(SELECT CUENTA_CORRIENTE FROM VIEW_CORRESPONSAL,MEAC WHERE RUT_CLIENTE = ACRUT AND ACCORRES = CODIGO_CORRES)	,
		--'NOMBRE'		=	(SELECT RTRIM(NOMBRE) + ' ' + RTRIM(codigo_swift) FROM VIEW_CORRESPONSAL,MEAC WHERE RUT_CLIENTE = ACRUT AND ACCORRES = CODIGO_CORRES)		,
		'NOMBRE'		=	(SELECT NOMBRE FROM VIEW_CORRESPONSAL,MEAC WHERE RUT_CLIENTE = ACRUT AND ACCORRES = CODIGO_CORRES)	,	  
                'HORA_PROC'		=	CONVERT(CHAR(8),GETDATE(),108),	
                'ENTIDAD'               =       (SELECT ACNOMBRE FROM MEAC),
		'NUMOPER'		=       @Numoper	,
		'CTACTECLI'		=       (SELECT clctacte FROM  view_cliente  WHERE Clrut = a.morutcli and Clcodigo = a.mocodcli  ),
		'VALUTA1'		= 	CASE a.motipope WHEN 'C' THEN a.movaluta2 ELSE a.movaluta1 END	,
		'VALUTA2'		= 	CASE a.motipope WHEN 'V' THEN a.movaluta1 ELSE a.movaluta2 END	,
		'MONEDA1'		= 	a.mocodmon	,
		'MONEDA2'		= 	a.mocodcnv	 	,
		'FORPAG'		=       @ForpagR,
                'mto_escrito'           =       @monto_escrito,
                'tipo_cambio'           =       moticam,
                'corresp_cliente'       =       (SELECT Nombre_Corresponsal FROM view_cliente_corresponsal,memo  WHERE MORUTCLI = Rut_Cliente AND MOCODCLI = Codigo_Cliente and monumope = @Numoper ),		  
                'cuenta_corresp'        =       (SELECT Cuenta_Corresponsal FROM view_cliente_corresponsal,memo  WHERE MORUTCLI = Rut_Cliente AND MOCODCLI = Codigo_Cliente and monumope = @Numoper ),   
                'merc'                  =       @merc,
                'valu_canje'            =       Valuta_Cli_Ext 
                --'tipo_cambio'           =       (select ISNULL(vmvalor, 0.0) FROM VIEW_VALOR_MONEDA WHERE vmfecha  = @acfecproc AND vmcodigo = 994)
		--( select mncodmon from view_moneda,memo  where mnnemo = memo.mocodmon )					
	FROM	meac ,				
		memo a 
	where 
		a.monumope = @Numoper
END
GO
