USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[MUREX_MIGRACION_SAO_4_cartera_asiaticos]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC MUREX_MIGRACION_SAO
CREATE  PROCEDURE [dbo].[MUREX_MIGRACION_SAO_4_cartera_asiaticos] ( @FechaTrade VARCHAR(40) = '',  @Fecharespaldo VARCHAR(40) = '')
AS BEGIN 



DECLARE @Usuario     VARCHAR(15); SET @Usuario = 'prueba'
DECLARE @RutRepCli01 NUMERIC(9);  SET @RutRepCli01 = 0 
DECLARE @RutRepCli02 NUMERIC(9);  SET @RutRepCli02 = 0
DECLARE @RutRepBan01 NUMERIC(9);  SET @RutRepBan01 = 0
DECLARE @RutRepBan02 NUMERIC(9);  SET @RutRepBan02 = 0
DECLARE @Grupo       NUMERIC(8);  SET @Grupo = 17252

--DECLARE @FechaTrade VARCHAR(10);	SET @FechaTrade		= '2021-07-21'
--DECLARE @Fecharespaldo VARCHAR(10); SET @Fecharespaldo	= '2021-07-20'


if (@FechaTrade ='')
begin
	select @FechaTrade    = convert(varchar, fechaproc, 23)  FROM CbMdbOpc.dbo.OPCIONESGENERAL with(nolock)
end

if (@Fecharespaldo ='')
begin
	select @Fecharespaldo = convert(varchar, fechaant, 23)   FROM CbMdbOpc.dbo.OPCIONESGENERAL with(nolock)
end


DECLARE @mostrarDetalle VARCHAR(2); SET @mostrarDetalle = 'cd'	--S-N-CD=con detalle
DECLARE @numope INT; SET @numope = 7793		---para consultar cuando @mostrarDetalle = S ;  0 = Todos

--select * from IMPRESION where impfolio <> 0 order by 3 desc 
--exec sp_Contrato_Legal_Opciones 'prueba', 0, 0, 0, 0, 17252

--ImpID	ImpGrupo	ImpNumContrato	ImpFolio	ImpUsuario
--26603	17303	6143	8300	CJMA9550
--26602	17303	6142	8299	CJMA9550
       
    -- INSTRUCCIONES GENERALES DE MANTENCION            
    -- @RutRep01 numeric(9) , @RutRep02 numeric(9) corresponden a los rut de rep legales            
    -- que puede que no haya.            
    -- Idea: utilizar distinct y tablas verticales ( si existen )            
              
                  
    /*  --  Prueba con Contratos vencidos              
        select ImpGrupo from impresion where ImpNumContrato in ( select canumcontrato from caVenEncContrato )               
        order by ImpGrupo desc                 
        SP_Contrato_Legal_Opciones_TMP 'XX', 0, 0, 0, 0, 420              
              
        --  Prueba con Contratos vencidos              
        select ImpGrupo from impresion where ImpNumContrato in ( select canumcontrato from caEncContrato )              
        order by ImpGrupo desc              
        sp_Contrato_Legal_Opciones_TMP 'XX', 0, 0, 0, 0, 558              
        sp_Contrato_Legal_Opciones 'XX', 0, 0, 0, 0, 558              
    */              
  
    SET NOCOUNT ON            
            
    -- Pora hacer por elegancia: generalizar con @@DATEFIRST cualquiera            
    -- MAP 20091216 Faltaba condcion ImpGrupo            = @Grupo            
            
 -- ASVG 17 Marzo 2011 Se agregan campos y procedimiento para generar montos escritos.            
 -- ASVG 30 Marzo 2011 Ahora que no hay linkservers se podría aprovechar el SP_MONTOESCRITO directamente desde Bac.            
 -- ASVG 29 Abril 2011 Se agrega campo comuna del cliente para contrato Forward Americano.            
            
    SET DATEFIRST 7            
            
    DECLARE @Nombre       VARCHAR(120)            
    DECLARE @Rut          NUMERIC(9)            
    DECLARE @Dv           CHAR(1)            
    DECLARE @FechaProceso DATETIME            
    DECLARE @Domicilio    VARCHAR(50)            
    DECLARE @Fax          VARCHAR(100)            
    DECLARE @Fono         VARCHAR(100)            
    DECLARE @Codigo       NUMERIC(2)            
    DECLARE @FechaDefault DATETIME            
            
 DECLARE @MM1    NUMERIC(21,6)  --ASVG_20110317            
 DECLARE @MM2    NUMERIC(21,6)  --ASVG_20110317            
 DECLARE @MontoMon1Escrito VARCHAR(170)  --ASVG_20110317            
 DECLARE @MontoMon2Escrito VARCHAR(170)  --ASVG_20110317            
  
  DECLARE @DvEntidad  VARCHAR(1)    
 DECLARE @CodEntidad VARCHAR(2)  
 DECLARE @ComunaEntidad VARCHAR(30)  
 DECLARE @CiudadEntidad VARCHAR(30)  
 --DECLARE @LOGOBANCO IMAGE  
  
  
  
            
   SELECT @FechaProceso = FechaProc            
      --   , @Nombre       = nombre            
      --   , @Rut          = rut            
      --   , @Domicilio    = direccion            
      --   , @Fono         = telefono            
         , @Fax          = Fax            
     , @Codigo       = 1            
   FROM cbmdbopc.dbo.OpcionesGeneral            
  
   SELECT   
			@Nombre   = RazonSocial   
		 ,  @Rut   = RutEntidad   
		 ,  @Dv    = DigitoVerificador  
		 ,  @CodEntidad  =   CodigoEntidad  
		 ,  @Domicilio  = DireccionLegal + ', ' + Comuna + ', ' + Ciudad  
		 ,  @Fono   = TelefonoLegal  
		 ,  @ComunaEntidad  = Comuna  
		 ,  @CiudadEntidad  = Ciudad  
		 --,  @LOGOBANCO  = BannerLargoContrato  
	FROM bacparamsuda.dbo.Contratos_ParametrosGenerales  
  
  
  
 -- Obtener Nombre y rut de Apoderados ---  
 --DECLARE @cNom_Apoderado_Banco_1  VARCHAR(40); SET @cNom_Apoderado_Banco_1  = dbo.Fx_Retorna_Apoderados( 97023000, 1, 13842499, 2)  
 --print @cNom_Apoderado_Banco_1  
 -- 13842499-5  
 --select * FROM BacParamSuda.dbo.View_CLIENTEParaOpc     
 DECLARE @Num_Oper NUMERIC(20)   
 DECLARE @RUT_CLIENTE NUMERIC(11)  
 DECLARE @COD_CLIENTE NUMERIC(5)  
  
--SET @Num_Oper = (select impNumContrato from IMPRESION where ImpGrupo = @Grupo)  

---Enc.CanumContrato   = IMP.ImpNumContrato  
 
 /* comentado para prueba 
SET @RUT_CLIENTE = (select CaRutCliente from CaEncContrato where CaNumContrato = @Num_Oper  
      union  
     select CaRutCliente from CaVenEnccontrato  where CaNumContrato = @Num_Oper)  
  
SET @COD_CLIENTE = (select CaCodigo from CaEncContrato where CaNumContrato = @Num_Oper  
      union  
     select CaCodigo from CaVenEnccontrato  where CaNumContrato = @Num_Oper)  
  */
  
 --DECLARE @cNom_Apoderado_Banco_1  VARCHAR(40); SET @cNom_Apoderado_Banco_1  = dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan01, 1)  
 --DECLARE @cRut_Apoderado_Banco_1  VARCHAR(40); SET @cRut_Apoderado_Banco_1  = dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan01, 2)  
 --DECLARE @cNom_Apoderado_Banco_2  VARCHAR(40); SET @cNom_Apoderado_Banco_2  = dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan02, 1)  
 --DECLARE @cRut_Apoderado_Banco_2  VARCHAR(40); SET @cRut_Apoderado_Banco_2  = dbo.Fx_Retorna_Apoderados( 97023000, 1, @RutRepBan02, 2)  
 
 /* comentado para prueba
 DECLARE @cNom_Apoderado_Banco_1  VARCHAR(40); SET @cNom_Apoderado_Banco_1  = dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan01, 1)  
 DECLARE @cRut_Apoderado_Banco_1  VARCHAR(40); SET @cRut_Apoderado_Banco_1  = dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan01, 2)  
 DECLARE @cNom_Apoderado_Banco_2  VARCHAR(40); SET @cNom_Apoderado_Banco_2  = dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan02, 1)  
 DECLARE @cRut_Apoderado_Banco_2  VARCHAR(40); SET @cRut_Apoderado_Banco_2  = dbo.Fx_Retorna_Apoderados( @Rut, @CodEntidad, @RutRepBan02, 2)  
 DECLARE @cNom_Apoderado_Cliente_1 VARCHAR(40); SET @cNom_Apoderado_Cliente_1 = dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli01, 1)  
 DECLARE @cRut_Apoderado_Cliente_1 VARCHAR(40); SET @cRut_Apoderado_Cliente_1 = dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli01, 2)  
 DECLARE @cNom_Apoderado_Cliente_2 VARCHAR(40); SET @cNom_Apoderado_Cliente_2 = dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli02, 1)  
 DECLARE @cRut_Apoderado_Cliente_2 VARCHAR(40); SET @cRut_Apoderado_Cliente_2 = dbo.Fx_Retorna_Apoderados( @RUT_CLIENTE, @COD_CLIENTE, @RutRepCli02, 2)  
 */

-------------------- TRADER MUREX - INI -----------------------
--- sección que valida codigos correctos de TRADER en MUREX ---

	DECLARE @totalUM AS INTEGER
	DECLARE @totalUB AS INTEGER

	SELECT "Colaborador" = 'Jiska Vos', "USER ID ITAU" = 'CJDV9015' INTO #tmpUsuariosMUREX UNION 
	SELECT "Colaborador" = 'Luis Perez', "USER ID ITAU" = 'CLPV7353' UNION 
	SELECT "Colaborador" = 'Marcelo Otarola', "USER ID ITAU" = 'CMOI0880' UNION 
	SELECT "Colaborador" = 'Martin Finger', "USER ID ITAU" = 'CMFR3217' UNION 
	SELECT "Colaborador" = 'AVECEDO, MARCELA', "USER ID ITAU" = 'CMAS2820' UNION 
	SELECT "Colaborador" = 'AVENDAÑO SALAZAR CLAUDIA ANDREA', "USER ID ITAU" = 'CCAS3191' UNION 
	SELECT "Colaborador" = 'IGNACIO ARBIZU PAIS', "USER ID ITAU" = 'CIAP0956' UNION 
	SELECT "Colaborador" = 'CIFUENTES PIZARRO MARIA FRANCISCA', "USER ID ITAU" = 'CMCP7133' UNION 
	SELECT "Colaborador" = 'CORIA MALDONADO LUIS ANTONIO', "USER ID ITAU" = 'CLCM1076' UNION 
	SELECT "Colaborador" = 'CORNEJO BELMAR VIVIANA BEATRIZ', "USER ID ITAU" = 'CVCB4928' UNION 
	SELECT "Colaborador" = 'CRUZAT UGARTE MATIAS', "USER ID ITAU" = 'CMCU6463' UNION 
	SELECT "Colaborador" = 'DIAZ FERRER MARIA JOSE', "USER ID ITAU" = 'CMDF8200' UNION 
	SELECT "Colaborador" = 'DIAZ, TOMAS', "USER ID ITAU" = 'CTDL7864' UNION 
	SELECT "Colaborador" = 'FORNO JELDES CRISTIAN ALFREDO', "USER ID ITAU" = 'CCFJ6408' UNION 
	SELECT "Colaborador" = 'GOFFARD RODRIGUEZ MICHEL CRISTIAN', "USER ID ITAU" = 'CMGR4915' UNION 
	SELECT "Colaborador" = 'GRAU PEQUEÑO ANDRES FARRAN', "USER ID ITAU" = 'CAGP436K' UNION 
	SELECT "Colaborador" = 'LUIS FARIAS SANCHEZ', "USER ID ITAU" = 'CLFS4749' UNION 
	SELECT "Colaborador" = 'LAGOS, JORGE ', "USER ID ITAU" = 'CJLM2936' UNION 
	SELECT "Colaborador" = 'MACKENNEY DA GIAU MARTHA PATRICIA', "USER ID ITAU" = 'CMMG2984' UNION 
	SELECT "Colaborador" = 'NASER, CRISTOBAL ', "USER ID ITAU" = 'CCNR6817' UNION 
	SELECT "Colaborador" = 'OBAID, MAURICIO ANDRÉS', "USER ID ITAU" = 'CMOG1777' UNION 
	SELECT "Colaborador" = 'PALACIOS, DANIEL', "USER ID ITAU" = 'CDPP3266' UNION 
	SELECT "Colaborador" = 'PATRICIO, RONCAGLIOLO', "USER ID ITAU" = 'CPRG444K' UNION 
	SELECT "Colaborador" = 'PONCE, JOSE LUIS ', "USER ID ITAU" = 'CJPS8271' UNION 
	SELECT "Colaborador" = 'RABAH RAMIREZ ALBERTO EDUARDO', "USER ID ITAU" = 'CARR9233' UNION 
	SELECT "Colaborador" = 'RAMIREZ, CAMILA', "USER ID ITAU" = 'CCRP5440' UNION 
	SELECT "Colaborador" = 'RAMIREZ, LORETO', "USER ID ITAU" = 'CLRP1107' UNION 
	SELECT "Colaborador" = 'REINIKE HERMAN GERARDO ANDRES', "USER ID ITAU" = 'CGRH0392' UNION 
	SELECT "Colaborador" = 'RINGELING, MARIANA', "USER ID ITAU" = 'CMRA7518' UNION 
	SELECT "Colaborador" = 'RIVERA LAGOS FELIPE JAVIER', "USER ID ITAU" = 'CFRL7607' UNION 
	SELECT "Colaborador" = 'RODRIGUEZ JUAN', "USER ID ITAU" = 'CJRA0393' UNION 
	SELECT "Colaborador" = 'ROSSI VILLAR PAOLA LORENA', "USER ID ITAU" = 'CPRV2151' UNION 
	SELECT "Colaborador" = 'SANTAMARIA ARTIGAS DANIEL IGNACIO', "USER ID ITAU" = 'CDSA2371' UNION 
	SELECT "Colaborador" = 'SILVA HERRERA ELIZABETH CAROLINA', "USER ID ITAU" = 'CESH0571' UNION 
	SELECT "Colaborador" = 'TORRES , LORENA', "USER ID ITAU" = 'CLTM3774' UNION 
	SELECT "Colaborador" = 'TUTELEERS TRENOVA JUAN PABLO', "USER ID ITAU" = 'CJTT8921' UNION 
	SELECT "Colaborador" = 'UMAÑA ARIAS PABLO ALEJANDRO', "USER ID ITAU" = 'CPUA0010' UNION 
	SELECT "Colaborador" = 'VILLENA PRIEGO PAULA FRANCISCA', "USER ID ITAU" = 'CPVP8594' UNION 
	SELECT "Colaborador" = 'YATES, SEBASTIAN ', "USER ID ITAU" = 'CSYO0476' UNION 
	SELECT "Colaborador" = 'ZARATE DE MENDOZA MARIO ALFONSO', "USER ID ITAU" = 'CMZD4830' UNION 
	SELECT "Colaborador" = 'Alejandro Teuber', "USER ID ITAU" = 'CATQ4698' UNION 
	SELECT "Colaborador" = 'Jose Pedro Melo', "USER ID ITAU" = 'CJMO2443' UNION 
	SELECT "Colaborador" = 'Luis Tapia V', "USER ID ITAU" = 'CLTV8426' UNION 
	SELECT "Colaborador" = 'Matias Stange', "USER ID ITAU" = 'CMSC1441' UNION 
	SELECT "Colaborador" = 'Michelle Montagnon', "USER ID ITAU" = 'CMMS1316' UNION 
	SELECT "Colaborador" = 'Pablo Vergara', "USER ID ITAU" = 'CPVC6556' UNION 
	SELECT "Colaborador" = 'Roberto Navarrete', "USER ID ITAU" = 'CRNC0366' UNION 
	SELECT "Colaborador" = 'Acuña Nelson', "USER ID ITAU" = 'CNAV0174' UNION 
	SELECT "Colaborador" = 'Alvarez Jose Miguel', "USER ID ITAU" = 'CJAN1418' UNION 
	SELECT "Colaborador" = 'Arroyo Rodrigo', "USER ID ITAU" = 'CRAP3579' UNION 
	SELECT "Colaborador" = 'Coromionas Matias', "USER ID ITAU" = 'CMCS5469' UNION 
	SELECT "Colaborador" = 'Flores Rodrigo', "USER ID ITAU" = 'CRFV0022' UNION 
	SELECT "Colaborador" = 'Hamel Ignacio', "USER ID ITAU" = 'CIHC0275' UNION 
	SELECT "Colaborador" = 'Huidobro Pablo', "USER ID ITAU" = 'CPHH0174' UNION 
	SELECT "Colaborador" = 'Linares Nolberto', "USER ID ITAU" = 'CNLB2726' UNION 
	SELECT "Colaborador" = 'Martinez Pablo', "USER ID ITAU" = 'CPMO742K' UNION 
	SELECT "Colaborador" = 'Massu Tomas', "USER ID ITAU" = 'CTMS5004' UNION 
	SELECT "Colaborador" = 'MEHECH , MARCELLE ', "USER ID ITAU" = 'NBKQ6EB' UNION 
	SELECT "Colaborador" = 'Ramirez Pedro', "USER ID ITAU" = 'CPRC1418' UNION 
	SELECT "Colaborador" = 'Salgado Tomas', "USER ID ITAU" = 'CRSE6198' UNION 
	SELECT "Colaborador" = 'Yañez Darwing', "USER ID ITAU" = 'CDYS5060'

	SET @totalUM = @@ROWCOUNT
	
	SELECT "TRADER_BAC" = 'CRAMIREZ', "TRADER_ITAU" = 'CCRP5440' INTO #tmpRelTrader UNION 
	SELECT "TRADER_BAC" = 'Pvillena', "TRADER_ITAU" = 'CPVP8594' UNION 
	SELECT "TRADER_BAC" = 'RFLORES', "TRADER_ITAU" = 'CRFV0022'

			
	SELECT DISTINCT 	
		--"OPERACIONES" = 'FWD',
		U.usuario,
		U.nombre,	
		U.tipo_usuario	,
		U.fecha_expira	,
		U.RutUsuario,	
		U.usuario_original
	INTO #tmpOperBAC 
	FROM 
		Bacfwdsuda..MFCARES AS FWD INNER JOIN BacParamSuda..USUARIO AS U ON
			U.USUARIO = FWD.caoperador
	WHERE 
--		FWD.CAESTADO <> 'A'
		CaFechaProceso >= '20190101' and 
		--CaFechaProceso = (SELECT TOP 1 CaFechaProceso FROM MFCARES ORDER BY 1 DESC)
		CAFECHA BETWEEN '20190101' AND @FechaTrade --OR 	--order by
	--	2 
	UNION
		---CLIENTES 'SAO' MOVIMIENTOS
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
		--	"OPERACIONES" = 'SAO',
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..MoEncContrato AS SAO INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = SAO.MoOperador
		WHERE 
			MoFechaContrato BETWEEN '20180101' AND @FechaTrade OR
			MoFechaPagoPrima > '20190101' 		--ORDER BY 
	--	3
	UNION
	-- CLIENTES 'SAO' CARTERA
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
		--	"OPERACIONES" = 'SAO',
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..CaEncContrato AS SAO INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = SAO.CaOperador
		WHERE 
			CaFechaContrato BETWEEN '20190101' AND @FechaTrade OR
			CaFechaPagoPrima > '20190101' 		--ORDER BY 
	--	4
	UNION
		SELECT DISTINCT --M.*
		--	"OPERACIONES" = 'SPOT',	
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM [BacCamSuda].dbo.MEMOH AS M INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = m.MOOPER
		WHERE
			--MOFECH between '20190101' and '20201020' OR 
			MOFECH between '20190101' and @FechaTrade OR
			MOVALUTA1 >= '20190101' OR 
			MOVALUTA2>= '20190101'
	--ORDER BY 2
	--	5
	UNION
		SELECT DISTINCT 
		--	"OPERACIONES" = 'SWP',	
			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM   BacSwapSuda..CARTERAHIS AS SWP INNER JOIN BacParamSuda..USUARIO AS U ON
			U.USUARIO = SWP.operador
      WHERE  
	  			(SWP.fecha_inicio >= '20190101' OR
				SWP.fecha_termino >= '20190101')

	--CPL 20210610
			UNION
	-- CLIENTES 'SAO' CARTERA
		SELECT DISTINCT --top 10 
		--	SAO.MoRutCliente, SAO.MoCodigo, 
		--	"OPERACIONES" = 'SAO',
 			U.usuario,
			U.nombre,	
			U.tipo_usuario	,
			U.fecha_expira	,
			U.RutUsuario,	
			U.usuario_original
		FROM 
		--	CbMdbOpc..MoHisEncContrato AS SAO --LEFT JOIN BacParamSuda..CLIENTE AS cl ON
			CbMdbOpc..CaresEncContrato AS SAO INNER JOIN BacParamSuda..USUARIO AS U ON
				U.USUARIO = SAO.CaOperador
		WHERE 
			CaFechaContrato BETWEEN '20190101' AND @FechaTrade OR
			CaFechaPagoPrima > '20190101' 		--ORDER BY 
			and caencfecharespaldo = @Fecharespaldo
					ORDER BY 2
	--CPL 20210610

      
   SET @totalUB = @@ROWCOUNT
   
   
	--SELECT 
	--	"USUARIOS TRADER MUREX" = @totalUM,
	--	"USUARIOS BAC" = @totalUB
	
	SELECT 
			--"OPERACIONES" = OB.OPERACIONES,
			"COD. OPER. BAC" = OB.usuario,
			"ES VALIDO EN MUREX" = OM.[USER ID ITAU],
			"TRADER A INFORMAR" = CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
												OM.[USER ID ITAU] 
										ELSE
											(SELECT TOP 1 U.USUARIO 
											FROM BacParamSuda..USUARIO AS U INNER JOIN #tmpUsuariosMUREX AS OM3 on
												OM3.[USER ID ITAU] = U.USUARIO
											WHERE
												U.[RutUsuario] = OB.RutUsuario AND
												--U.USUARIO <> OB.usuario --AND
												--U.USUARIO = OM.[USER ID ITAU]
												LEFT(U.USUARIO, 1) = 'C'
											ORDER BY U.USUARIO DESC)
										--ELSE
										END,
			"TRADER ES VALIDO EN MUREX" = CASE WHEN EXISTS (SELECT 1 FROM #tmpUsuariosMUREX AS OM2 
																	WHERE OM2.[USER ID ITAU] = 
																				CASE WHEN OM.[USER ID ITAU] = OB.usuario THEN
																						OM.[USER ID ITAU] 
																				ELSE
																					(SELECT TOP 1 U.USUARIO 
																					FROM BacParamSuda..USUARIO AS U INNER JOIN #tmpUsuariosMUREX AS OM3 on
																						OM3.[USER ID ITAU] = U.USUARIO
																					WHERE
																						U.[RutUsuario] = OB.RutUsuario AND
																						--U.USUARIO <> OB.usuario --AND
																						--U.USUARIO = OM.[USER ID ITAU]
																						LEFT(U.USUARIO, 1) = 'C'
																					ORDER BY U.USUARIO DESC)

																				END) THEN 'SI'
											ELSE
												'NO'
											END,
			OB.nombre,	
			OB.tipo_usuario	,
			OB.fecha_expira	,
			OB.RutUsuario,	
			OB.usuario_original		 
		--OM.* 
	INTO #RESULTADO
   FROM #tmpOperBAC AS OB LEFT JOIN #tmpUsuariosMUREX AS OM ON
				OB.usuario = OM.[USER ID ITAU]
--	WHERE 
--		OM.[USER ID ITAU] IS NULL
	ORDER BY
		NOMBRE


	SELECT 
		--R.OPERACIONES,
		R.[COD. OPER. BAC], 
--		R.[ES VALIDO EN MUREX], 
		"TRADER A INFORMAR" = RTRIM(LTRIM(CASE WHEN R.[TRADER A INFORMAR] IS NULL THEN 
										(SELECT RT.TRADER_ITAU FROM #tmpUsuariosMUREX AS M INNER JOIN #tmpRelTrader AS RT ON
												M.[USER ID ITAU] = RT.TRADER_ITAU
										WHERE
												RT.TRADER_BAC = R.[COD. OPER. BAC])
									ELSE 
										R.[TRADER A INFORMAR] 
									END)), 
		--"TRADER ES VALIDO EN MUREX" = CASE WHEN R.[TRADER A INFORMAR] IS NULL THEN 
		--										(SELECT CASE WHEN RT.TRADER_ITAU IS NULL THEN 'NO' ELSE 'SI' END 
		--										FROM #tmpUsuariosMUREX AS M INNER JOIN #tmpRelTrader AS RT ON
		--												M.[USER ID ITAU] = RT.TRADER_ITAU
		--										WHERE
		--												RT.TRADER_BAC = R.[COD. OPER. BAC])
		--									ELSE 
		--										R.[TRADER ES VALIDO EN MUREX]
		--									END, 		
		R.[nombre] 
		--R.[tipo_usuario], 
		--R.[fecha_expira], 
		--R.[RutUsuario], 
		--R.[usuario_original]
	INTO #TRADER_MUREX
	FROM #RESULTADO AS R LEFT JOIN #tmpUsuariosMUREX AS OM ON
				R.[TRADER A INFORMAR] = OM.[USER ID ITAU]

--- sección que valida codigos correctos de TRADER en MUREX ---
-------------------- TRADER MUREX - FIN ----------------------- 
 
 DECLARE @cNom_Apoderado_Banco_1  VARCHAR(40); SET @cNom_Apoderado_Banco_1  = ''
 DECLARE @cRut_Apoderado_Banco_1  VARCHAR(40); SET @cRut_Apoderado_Banco_1  = ''
 DECLARE @cNom_Apoderado_Banco_2  VARCHAR(40); SET @cNom_Apoderado_Banco_2  = ''
 DECLARE @cRut_Apoderado_Banco_2  VARCHAR(40); SET @cRut_Apoderado_Banco_2  = ''
 DECLARE @cNom_Apoderado_Cliente_1 VARCHAR(40); SET @cNom_Apoderado_Cliente_1 = ''
 DECLARE @cRut_Apoderado_Cliente_1 VARCHAR(40); SET @cRut_Apoderado_Cliente_1 = ''
 DECLARE @cNom_Apoderado_Cliente_2 VARCHAR(40); SET @cNom_Apoderado_Cliente_2 = ''
 DECLARE @cRut_Apoderado_Cliente_2 VARCHAR(40); SET @cRut_Apoderado_Cliente_2 = ''
 
             
 declare @dvb1 varchar(2)  
 declare @dvb2 varchar(2)  
 declare @dvc1 varchar(2)  
 declare @dvc2 varchar(2)  
 set @dvb1 = ''  
 set @dvb2 = ''  
 set @dvc1 = ''  
 set @dvc2 = ''  
  
 --if @cRut_Apoderado_Banco_1 <> ''  
 --begin  
 -- set @dvb1 = SUBSTRING(@cRut_Apoderado_Banco_1,len(@cRut_Apoderado_Banco_1),+1)  
 --                  set @cRut_Apoderado_Banco_1 = SUBSTRING(@cRut_Apoderado_Banco_1,1,CHARINDEX('-',@cRut_Apoderado_Banco_1)-1)    
 -- set @cRut_Apoderado_Banco_1 =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_1))) ), 1), '.00', ''), ',','.'))  
 --end  
 --if @cRut_Apoderado_Banco_2 <> ''  
 --begin  
 -- set @dvb2 = SUBSTRING(@cRut_Apoderado_Banco_2,len(@cRut_Apoderado_Banco_2),+1)  
 -- set @cRut_Apoderado_Banco_2 = SUBSTRING(@cRut_Apoderado_Banco_2,1,CHARINDEX('-',@cRut_Apoderado_Banco_2)-1)    
 -- set @cRut_Apoderado_Banco_2 =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Banco_2))) ), 1), '.00', ''), ',','.'))  
 --end  
 -- if @cRut_Apoderado_Cliente_1 <> ''  
 --begin  
 -- set @dvc1 = SUBSTRING(@cRut_Apoderado_Cliente_1,len(@cRut_Apoderado_Cliente_1),+1)  
 -- set @cRut_Apoderado_Cliente_1 = SUBSTRING(@cRut_Apoderado_Cliente_1,1,CHARINDEX('-',@cRut_Apoderado_Cliente_1)-1)    
 -- set @cRut_Apoderado_Cliente_1 =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_1))) ), 1), '.00', ''), ',','.'))  
 --end  
   
 --if @cRut_Apoderado_Cliente_2 <> ''  
 --begin  
 -- set @dvc2 = SUBSTRING(@cRut_Apoderado_Cliente_2,len(@cRut_Apoderado_Cliente_2),+1)  
 -- set @cRut_Apoderado_Cliente_2 = SUBSTRING(@cRut_Apoderado_Cliente_2,1,CHARINDEX('-',@cRut_Apoderado_Cliente_2)-1)    
 -- set @cRut_Apoderado_Cliente_2 =  (select replace (replace (convert (varchar(40), convert(money, rtrim(ltrim(convert(varchar(40),@cRut_Apoderado_Cliente_2))) ), 1), '.00', ''), ',','.'))  
 --end  
  
    --SELECT @FechaProceso = FechaProc            
    --     , @Nombre       = nombre            
    --     , @Rut          = rut            
    --     , @Domicilio    = direccion            
    --     , @Fono         = telefono            
    --     , @Fax          = Fax            
    --     , @Codigo       = 1            
    --  FROM dbo.OpcionesGeneral      
                
            
    --SELECT @Dv   = ClDv            
    --     , @Fax  = ClFax            
    --     , @Fono = Clfono         
    --  FROM BacParamSuda.dbo.View_CLIENTEParaOpc            
    -- WHERE clrut = @Rut             
    -- AND  Clcodigo =1         
    -- MAP 14 Nov. 2009 desvio por prob lnkServer          
        
                
            
    SET @FechaDefault = '19000101'            
  /*          
    -- Sección que genera el registro vacóo.            
    SELECT 'Reporte'                       = CONVERT( VARCHAR(40), 'CONTRATO LEGAL' )            
         , 'TipReg'                        = CONVERT( VARCHAR(10), 'VACIO'  )            
         , 'NumContrato'                   = CONVERT( NUMERIC(8), 0 )            
         , 'CaNumEstructura'               = CONVERT( NUMERIC(6), 0 )             
         ,'CaVinculacion'					= CONVERT( VARCHAR(40), '' )
         , 'CliRut'                        = CONVERT( NUMERIC(13), 0 )            
         , 'CliCod'                        = CONVERT( NUMERIC(5), 0 )            
         , 'CliDv'                         = CONVERT( VARCHAR(1), '' )    
   , 'CliNom'           = CONVERT( VARCHAR(100), 'NO HAY DATOS' )    
         , 'Operador'                      = CONVERT( VARCHAR(15), '' )            
   , 'OpcEstCod'                     = CONVERT( VARCHAR(2), '' )            
         , 'OpcEstDsc'                     = CONVERT( VARCHAR(30), '' ) -->     
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100),  '' )            
   , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100),  '' )            
         , 'NumComponente'                 = CONVERT( NUMERIC(6), 0 )            
         , 'PayOffTipCod'       = CONVERT( VARCHAR(2), '' )            
         , 'PayOffTipDsc'                  = CONVERT( VARCHAR(20), '' )            
         , 'CallPut'                       = CONVERT( VARCHAR(5), '' )            
         , 'CVOpcCod'                      = CONVERT( VARCHAR(3), '' )            
         , 'CompraVentaOpcDsc'             = CONVERT( VARCHAR(6), '' )            
         , 'FechaContrato'                 = @FechaDefault            
         , 'FechaPagoEjer'                 = @FechaDefault            
         , 'FechaVcto'                     = @FechaDefault            
         , 'FechaCG'                       = @FechaDefault            
         , 'ChkFechaCG'                    = CONVERT( CHAR(1), 'N')            
         , 'FechaCGComp'                   = @FechaDefault            
         , 'ChkFechaCGComp'                = CONVERT( NUMERIC(1), 0)            
         , 'FechaCGSup'                    = @FechaDefault            
         , 'ChkFechaCGSup'                 = CONVERT( NUMERIC(1), 0)            
         , 'Mon1Cod'                       = CONVERT( NUMERIC(5), 0 )            
         , 'Mon1Dsc'                       = CONVERT( VARCHAR(35), '' )            
         , 'MontoMon1'                     = CONVERT( NUMERIC(21,6), 0 )            
         , 'MontoMon1Strangle'             = CONVERT( NUMERIC(21,6), 0 )            
         , 'MontoMon2Straddle'             = CONVERT( NUMERIC(21,6), 0 )            
         , 'Mon2Cod'        = CONVERT( NUMERIC(5), 0 )            
         , 'Mon2Dsc'        = CONVERT( VARCHAR(35), '' )            
         , 'MontoMon2'                     = CONVERT( NUMERIC(21,6), 0 )            
         , 'ModalidadCod'                  = CONVERT( VARCHAR(1), ''  )   
		, 'ModalidadDsc'                  = CONVERT( VARCHAR(15), ''  )            
         , 'MdaCompensacionCod'            = CONVERT( NUMERIC(5), 0 )            
         , 'MdaCompensacionDsc'            = CONVERT( VARCHAR(35), ''  )            
         , 'Strike'                        = CONVERT( FLOAT, 0.0 )            
         , 'NumeroFijacion'                = CONVERT( NUMERIC(6), 0 )            
         , 'FechaFijacion'                 = @FechaDefault            
         , 'PesoFijacion'                  = CONVERT( FLOAT, 0.0 )            
         , 'FixBenchCompCod'               = CONVERT( NUMERIC(5), 0 )            
         , 'FixBenchCompDsc'               = CONVERT( VARCHAR(40), '' )            
         , 'FixBenchCompHora'              = CONVERT( VARCHAR(8), '00:00:00' )            
         , 'FixBenchEsEditable'            = CONVERT( VARCHAR(1), '' )             
         , 'FixBenchMdaCodValorDef'        = CONVERT( NUMERIC(5), 0 )            
         , 'FixBenchMdaCodValorDefValor'   = CONVERT( FLOAT, 0 )              
         , 'FixParBench'                   = CONVERT( VARCHAR(7), '' )            
         , 'FixEstado'                     = CONVERT( VARCHAR(1), '' )            
         , 'FixValorFijacion'              = CONVERT( FLOAT, 0.0 )            
         , 'EstadoEjercicioCod'            = CONVERT( VARCHAR(2), '' )            
         , 'EstadoEjercicioDsc'            = CONVERT( VARCHAR(20), '' )            
         , 'EstadoMotorPagoCod'            = CONVERT( VARCHAR(2), '' )            
         , 'EstadoMotorPagoDsc'      = CONVERT( VARCHAR(20), '' )             
         , 'Refijable'                     = CONVERT( VARCHAR(10), 'RE-FIJABLE' )            
         , 'Usuario'                    = CONVERT( VARCHAR(15), '' )            
         , 'Anno'                          = CONVERT( VARCHAR(4), '2000' )            
         , 'Banco'                         = CONVERT( VARCHAR(16), LEFT( @Nombre, 16 ) )            
         , 'Rut'                  = CONVERT( NUMERIC(9), @Rut )            
         , 'Dv'                            = CONVERT( VARCHAR(1), @Dv )            
         , 'FechaContratoLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )            
         , 'FechaCondGeneLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )            
         , 'FechaCondGeneOpcLarga'         = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )            
         , 'FechaCondGeneOpcSupLarga'      = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )            
         , 'TipoEjercicioCod'              = CONVERT( CHAR(1),  ' ' )            
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), 'AMERICANA' )            
         , 'PrecioTope'                    = CONVERT( FLOAT, 0.0 )        --PRD_20975 ASVG_20140730 Para Strike4  
         , 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )            
         , 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )            
         , 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )            
         , 'MtoPrima'                      = CONVERT( FLOAT, 0.0 )            
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), 0 )            
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), '' )            
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5), 0 )             
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), '' )            
         , 'FechaPagoPrima'                = @FechaDefault            
        -- , 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )     
   , 'ApoderadoClienteRut01'         = @cRut_Apoderado_Cliente_1       --> PRD-21658   
         , 'ApoderadoClienteDv01'          = CONVERT( CHAR(1), 0 )            
         , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )            
         , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )            
         , 'ApoderadoClienteFax01'        = CONVERT( VARCHAR(50), '' )             
   , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )            
         --, 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )            
         --, 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )     
   , 'ApoderadoBancoRut01'           = @cRut_Apoderado_Banco_1       --> PRD-21658   
         , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )           
   , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )            
   , 'ApoderadoBancoFax01'           = CONVERT( VARCHAR(50), '' )            
         , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )       
          
         --, 'ApoderadoBancoRut02'           = CONVERT( NUMERIC(9), 0 )          
         --, 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )      
   , 'ApoderadoBancoRut02'           = @cRut_Apoderado_Banco_2        
         , 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )          
  
         , 'ApoderadoBancoNombre02'        = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoBancoDomicilio02'     = CONVERT( VARCHAR(100), '' )          
         , 'ApoderadoBancoFax02'           = CONVERT( VARCHAR(50), '' )          
         , 'ApoderadoBancoFono02'          = CONVERT( VARCHAR(50), '' )    
         , 'MtoPrecioTope'                 = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioSuperior'             = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioMedio'                = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioPiso'                 = CONVERT( FLOAT, 0.0 )  
         , 'ReceptorPrima'                 = CONVERT( VARCHAR(100), '' )            
         , 'PagadorPrima'                  = CONVERT( VARCHAR(100), '' )            
         , 'Control'                       = CONVERT( VARCHAR(250), '' )            
   , 'MontoMon1Escrito'      = CONVERT( VARCHAR(250), '' )  --ASVG_20110317    
   , 'MontoMon2Escrito'      = CONVERT( VARCHAR(250), '' )  --ASVG_20110317    
   , 'FechaVctoLarga'       = CONVERT( VARCHAR(30), '' )   --ASVG_20110317    
   , 'ApoderadoClienteComuna01'    = CONVERT( VARCHAR(50), '' )   --ASVG_20110429    
   , 'FechasVencimiento'             = CONVERT( VARCHAR(3000), '' )  --PRD_7274 STRIP    
         , 'FechasPago'                    = CONVERT( VARCHAR(3000), '' )  --PRD_7274 STRIP    
         , 'FechasVctoFinal'               = CONVERT( VARCHAR(10), '' )      --PRD_7274 STRIP    
         , 'RelacionaPAE'                  = CONVERT( CHAR(1), 0 )           --PRD_13085 PAE Bonificado    
         , 'CliDireccion'       = CONVERT( VARCHAR(40), '' )      --PRD_13085 PAE Bonificado    
   , 'CliCiudad'              = CONVERT( VARCHAR(40), '' )      --PRD_13085 PAE Bonificado    
  
      , 'ApoderadoClienteRut02'         = @cRut_Apoderado_Cliente_2         
         , 'ApoderadoClienteDv02'          = CONVERT( CHAR(1), 0 )            
         , 'ApoderadoClienteNombre02'      = CONVERT( VARCHAR(100), '' )     
   , 'LogoBanco'      = CONVERT (IMAGE, '')  
            
      INTO #Resultado -- Genera tabla con el registro vacío            
            
    CREATE INDEX INumContrato ON #Resultado(NumContrato,NumComponente )            
*/            
    -- Acopio de todos los contratos (incluso los vencidos)              
    select @Fecharespaldo as CaEncFechaRespaldo , * into #CaEncContrato              
    from	cbmdbopc..CaEncContrato          
--    where  CaEstado = ''
    union              
    select @Fecharespaldo as CaEncFechaRespaldo ,* from cbmdbopc..CaVenEnccontrato              
--    where  CaEstado = ''
	union
    select * from cbmdbopc..CaresEncContrato  where  caencfecharespaldo =@Fecharespaldo
   
IF @mostrarDetalle = 'S'
	--SELECT * FROM #CaEncContrato
	SELECT "tipo" = '#CaEncContrato', * FROM #CaEncContrato 
	where CanumContrato = @numope or @numope = 0
	--WHERE CanumContrato in(7320,7322,7323,7324,7336,7337) 
   
    --select * 
    --from CaVenEnccontrato WHERE CanumContrato = 5779
    --select * from CaVenDetContrato              WHERE CanumContrato = 5779

  
    SELECT @Fecharespaldo as CaDetFechaRespaldo , * INTO #CaDetContrato              
    FROM cbmdbopc..CaDetContrato             
    UNION              
    SELECT @Fecharespaldo as CaDetFechaRespaldo , * FROM cbmdbopc..CaVenDetContrato   
	union     
	select * from  [CbMdbOpc].[dbo].[CaResDetContrato] where CaDetFechaRespaldo   = @Fecharespaldo            

IF @mostrarDetalle = 'S'
	SELECT "tipo" = '#CaDetContrato', * FROM #CaDetContrato
	where CanumContrato = @numope or @numope = 0
	--WHERE CanumContrato in(7320,7322,7323,7324,7336,7337)
              
    SELECT @Fecharespaldo as CaFixingFechaRespaldo , * INTO #CaFixing
    FROM cbmdbopc..CaFixing              
    UNION              
    SELECT @Fecharespaldo as CaFixingFechaRespaldo , * FROM cbmdbopc..CaVenFixing
	union
	select * FROM [CbMdbOpc].[dbo].[CaResFixing] where CaFixingFechaRespaldo = @Fecharespaldo

IF @mostrarDetalle = 'S'
	SELECT "tipo" = '#CaFIXING', * FROM #CaFixing
	where CaNumContrato = @numope or @numope = 0
              
    SELECT * INTO #CaCaja
    FROM cbmdbopc..CaCaja              
    UNION              
    SELECT * FROM cbmdbopc..CaVenCaja      
    -- Acopio de todos los contratos (incluso los vencidos)              
              
IF @mostrarDetalle = 'S'
	SELECT "tipo" = '#CaCaja', * FROM #CaCaja
	where CaNumContrato = @numope or @numope = 0
    
    -- Estrategria            
    -- Cargar tabla con los datos Fixing por fecha            
    -- mediante update aplicar los datos de:            
    -- CaEncContrato, CaDetContrato, CaVenEncContrato y CaVenEncContrato            
    -- por ahora tratar de mantener información historica junto con             
    -- la vigente, si el desempeño no mejora separamos la cosa.   
   
  SELECT DISTINCT   --> SE SACO EL DISTINCT PORQUE NO TRABAJA CON EL CAMPO LOGOBANCO, SE DEBE REVISAR SI NO PERJUDICA LA QUERY       
--    SELECT             
           'Reporte'                       = CONVERT( VARCHAR(40), 'CONTRATO LEGAL' )            
         , 'TipReg'                        = CONVERT( VARCHAR(10), 'CONTRATO'  )            
         , 'NumContrato'                   = CONVERT( NUMERIC(8), Fix.CaNumContrato )            
         , "NumEstructura"               = Fix.CaNumEstructura --CONVERT( NUMERIC(6), Fix.CaNumEstructura )            
         ,"Vinculacion" = Det.CaVinculacion
         , 'CliRut'                        = CONVERT( NUMERIC(13), Enc.CaRutCliente )            
         , 'CliCod'                        = CONVERT( NUMERIC(5), Enc.CaCodigo )            
         , 'CliDv'                         = CONVERT( CHAR(1), ISNULL( Cliente.ClDv, '' )   )            
         , 'CliNom'                        = CONVERT( VARCHAR(100), ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ) )            
         , 'Operador'                      = CONVERT( VARCHAR(15), Enc.CaOperador )            
--         ,Enc.CaCodEstructura
--         ,"OPcEstCod-estructura" = Estructura.OPcEstCod 
         , "OpcEstCod"                     =  Estructura.OPcEstCod	--CONVERT( VARCHAR(2), Estructura.OPcEstCod)					--Enc.CaCodEstructura 
    
         , "OpcEstDsc"  = CONVERT( VARCHAR(30), ISNULL(  Estructura.OpcEstDsc  , 'Estructura no Existe'  ) )              
    
         , 'OpcCompraEstrucutura'          = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre          ELSE Cliente.ClNombre END )            
           -- Se realizo cambio, sin embargo se esta solicitando al usuario formalizar. Por mientras se deja el codigo e comentario      
           /*    
           CASE WHEN Enc.CaCodEstructura = 4 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )    
                    WHEN Enc.CaCodEstructura = 5 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )    
                    ELSE         CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre ELSE Cliente.ClNombre  END )    
                   END    
           */    
         , 'OpcVENDeEstrucutura'           = CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre          END )            
           /*    
           -- Se realizo cambio, sin embargo se esta solicitando al usuario formalizar. Por mientras se deja el codigo e comentario    
           CASE WHEN Enc.CaCodEstructura = 4 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre  ELSE Cliente.ClNombre END )    
                    WHEN Enc.CaCodEstructura = 5 THEN CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN @Nombre  ELSE Cliente.ClNombre END )    
                    ELSE         CONVERT( VARCHAR(100), CASE WHEN CaCVEstructura = 'C' THEN Cliente.ClNombre ELSE @Nombre  END )    
                   END    
           */    
         , 'NumComponente'                 = CONVERT( NUMERIC(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Fix.CaNumEstructura END )            
         , 'PayOffTipCod'                  = CONVERT( VARCHAR(2), Det.CaTipoPayOff )             
         , 'PayOffTipDsc'                  = CONVERT( VARCHAR(20), upper( PayOffTipo.PayOffTipDsc ) )             
         -- PRD_7274 STRIP          
         --, 'CallPut'                       = CONVERT( VARCHAR(5), UPPER( CASE WHEN Enc.CaCodEstructura in (9,10) THEN Det.CaCallPut              
         --            ELSE CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCallPut END    
         --    END ))    
         , 'CallPut'                       = Det.CaCallPut
                 
         --, 'CVOpcCod'                      = CONVERT( VARCHAR(3), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' ELSE Det.CaCVOpc END )            
         , 'CVOpcCod'                      = Det.CaCVOpc             
         , 'CompraVentaOpcDsc'             = CONVERT( VARCHAR(6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 'N/A' WHEN Det.CaCVOpc = 'C' THEN 'Compra' ELSE 'Venta' END )            
         , 'FechaContrato'                 = Enc.CaFechacontrato    -- FECHA            
         , 'FechaPagoEjer'                 = Det.CaFechaPagoEjer    -- FECHA            
         , 'FechaVcto'                     = Det.CaFechaVcto        -- FECHA            
         , 'FechaCG'                       = ISNULL( Cliente.FECHA_FIRMA_NUEVO_CCG, @FechaDefault ) -- FECHA select * from lnkbac.BacParamSuda.dbo.cliente            
         , 'ChkFechaCG'                    = CONVERT( CHAR(1), ISNULL( Cliente.NUEVO_CCG_FIRMADO, 'N' ) )            
         , 'FechaCGComp'                   = ISNULL( clFechaFirma_cond_Opc, @FechaDefault )  -- FECHA            
         , 'ChkFechaCGComp'                = CONVERT( NUMERIC(1), ISNULL( clFechaFirma_cond_OpcChk, 0 ) )            
         , 'FechaCGSup'                    = ISNULL( clFechaFirma_Supl_Opc, @FechaDefault )  -- FECHA            
         , 'ChkFechaCGSup'          = CONVERT( NUMERIC(1), clFechaFirma_Supl_OpcChk, 0 )            
         , 'Mon1Cod'                       = CONVERT( NUMERIC(5), Det.CaCodMon1 )            
         , 'Mon1Dsc'                       = CONVERT( CHAR(35), ISNULL( MonedaM1.MnGlosa, 'Moneda M1 no existe' )  )            
         , 'MontoMon1'                     = CONVERT( NUMERIC(21,6), Det.CaMontoMon1 )            
         , 'MontoMon1Strangle'             = CONVERT( NUMERIC(21,6), 0 )            
         , 'MontoMon2Straddle'             = CONVERT( NUMERIC(21,6), 0 )            
         , 'Mon2Cod'                       = CONVERT( NUMERIC(5), Det.CaCodMon2 )            
         , 'Mon2Dsc'                       = CONVERT( CHAR(35), ISNULL( MonedaM2.MnGlosa, 'Moneda M2 no existe' ) )            
         
         --, 'MontoMon2'                     = CONVERT( NUMERIC(21,6), CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0 ELSE Det.CaMontoMon2 END )            
         , 'MontoMon2'                     = Det.CaMontoMon2 
         
 
, "MonPrimaCosto" = CaMonPrimaCosto
, "PrimaCosto" = CaPrimaCosto

         , 'ModalidadCod'                  = CONVERT( VARCHAR(1), Det.CaModalidad  )            
         , 'ModalidadDsc'       = CONVERT( VARCHAR(15), CASE WHEN Det.CaModalidad  = 'E' THEN 'Entrega Fis.' ELSE 'Compensación' END  )            
         , 'MdaCompensacionCod'            = CONVERT( NUMERIC(5), CaMdaCompensacion )             
         , 'MdaCompensacionDsc'            = CONVERT( VARCHAR(35), ISNULL( MdaComp.MnGlosa, 'Moneda Comp. no existe' )  )            
         , 'Strike'                        = CONVERT( FLOAT, CASE WHEN Det.CaVinculacion = 'Estructura' THEN 0.0 ELSE  Det.CaStrike END )            
         , 'NumeroFijacion'                = CONVERT( NUMERIC(6), Fix.CaFixNumero )            
         , 'FechaFijacion'                 = Fix.cafixFecha -- FECHA         
         , 'PesoFijacion'                  = CONVERT( FLOAT, Fix.CaPesoFij )            
         , 'FixBenchCompCod'               = CONVERT( NUMERIC(5), Fix.CaFixBenchComp )   
         , 'FixBenchCompDsc'               = CONVERT( VARCHAR(40),BenchFix.BenchMarkDescripcion )            
         , 'FixBenchCompHora'              = CONVERT( VARCHAR(8), BenchFix.BenchMarkHora, 108 )             
         , 'FixBenchEsEditable'            = CONVERT( VARCHAR(1), BenchFix.BenchEditable )             
         , 'FixBenchMdaCodValorDef'        = CONVERT( NUMERIC(5), BenchFix.BenchMdaCodValorDef )            
         , 'FixBenchMdaCodValorDefValor'   = CONVERT( FLOAT, ISNULL(  DefectoBench.vmvalor, 0 ) )              
         , 'FixParBench'                   = CONVERT( VARCHAR(7), Fix.CaFixParBench )             
         , 'FixEstado'                     = CONVERT( VARCHAR(1), Fix.CaFixEstado )             
         , 'FixValorFijacion'              = CONVERT( FLOAT, Fix.CaFijacion )            
         , 'EstadoEjercicioCod'            = CONVERT( VARCHAR(2), ISNULL( CaCajEstado, 'NE' ) )            
         , 'EstadoEjercicioDsc'            = CONVERT( VARCHAR(20), '' )            
         , 'EstadoMotorPagoCod'            = CONVERT( VARCHAR(2), ISNULL( CaCajMotorPago, 'NE' ) )            
         , 'EstadoMotorPagoDsc'            = CONVERT( VARCHAR(20), '' )            
         , 'Refijable'                     = CONVERT( VARCHAR(10), 'RE-FIJABLE' )            
         , 'Usuario'                       = CONVERT( VARCHAR(15), @Usuario )            
         , 'Anno'                          = CONVERT( VARCHAR(4), '2000' )            
         , 'Banco'                         = CONVERT( VARCHAR(16), substring( @Nombre, 1, 16 ) )                        
         , 'Rut'                           = CONVERT( NUMERIC(9), @Rut )            
         , 'Dv'                            = CONVERT( VARCHAR(1), @Dv )            
         --, 'FechaContratoLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )               
         --, 'FechaCondGeneLarga'            = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )            
         --, 'FechaCondGeneOpcLarga'         = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )               
         --, 'FechaCondGeneOpcSupLarga'      = CONVERT( VARCHAR(30), '01 de Enero del año 1900' )               
         , 'TipoEjercicioCod'              = CONVERT( VARCHAR(1),  CaTipoEjercicio )             
         -- PRD_7274 STRIP          
         , 'TipoEjercicioDsc'              = CONVERT( VARCHAR(10), UPPER( CASE WHEN Enc.CaCodEstructura in (9,10) THEN UPPER(OT.OpcTipDsc)              
                   ELSE              
                   CONVERT( VARCHAR(10), CASE WHEN CaTipoEjercicio = 'E' THEN  'EUROPEA' ELSE 'AMERICANA' END  )              
                   END               
                  ))              
         , 'PrecioTope'                    = CONVERT( FLOAT, 0.0 )        --PRD_20975 ASVG_20140730 Para Strike4  
         --, 'PrecioSuperior'                = CONVERT( FLOAT, 0.0 )            
         --, 'PrecioMedio'                   = CONVERT( FLOAT, 0.0 )            
         --, 'PrecioPiso'                    = CONVERT( FLOAT, 0.0 )            
         , 'MtoPrima'                      = CONVERT( FLOAT, CaPrimaInicial )              
         , 'FormaPagoPrimaCod'             = CONVERT( NUMERIC(3), CafPagoPrima )               
         , 'FormaPagoPrimaDsc'             = CONVERT( VARCHAR(30), ISNULL( FormaPagoPrima.Glosa, 'Forma Pago Prima no existe' ) )            
         , 'MdaPagoPrimaCod'               = CONVERT( NUMERIC(5) , CaCodMonPagPrima )             
         , 'MdaPagoPrimaDsc'               = CONVERT( VARCHAR(35), ISNULL( MonedaPrima.MnGlosa, 'Moneda Prima no existe' )  )              
         , 'FechaPagoPrima'                = CaFechaPagoPrima            
   --      --, 'ApoderadoClienteRut01'         = CONVERT( NUMERIC(9), 0 )    
   --, 'ApoderadoClienteRut01'         =  @cRut_Apoderado_Cliente_1     
   --      , 'ApoderadoClienteDv01'          = CONVERT( VARCHAR(1), 0 )            
   --      , 'ApoderadoClienteNombre01'      = CONVERT( VARCHAR(100), '' )            
   --      , 'ApoderadoClienteDomicilio01'   = CONVERT( VARCHAR(100), '' )            
   --      , 'ApoderadoClienteFax01'         = CONVERT( VARCHAR(50), '' )             
   --      , 'ApoderadoClienteFono01'        = CONVERT( VARCHAR(50), '' )            
   --      --, 'ApoderadoBancoRut01'           = CONVERT( NUMERIC(9), 0 )            
   --      --, 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )     
   --, 'ApoderadoBancoRut01'           = @cRut_Apoderado_Banco_1     
   --  , 'ApoderadoBancoDv01'            = CONVERT( VARCHAR(1), '' )   
            
   --      , 'ApoderadoBancoNombre01'        = CONVERT( VARCHAR(100), '' )            
   --      , 'ApoderadoBancoDomicilio01'     = CONVERT( VARCHAR(100), '' )            
   --      , 'ApoderadoBancoFax01'           = CONVERT( VARCHAR(50), '' )             
   --      , 'ApoderadoBancoFono01'          = CONVERT( VARCHAR(50), '' )            
               
   --      --, 'ApoderadoBancoRut02'           = CONVERT( NUMERIC(9), 0 )          
   --      --, 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )          
   --, 'ApoderadoBancoRut02'           = @cRut_Apoderado_Banco_2          
   --      , 'ApoderadoBancoDv02'            = CONVERT( VARCHAR(1), '' )     
  
  
         --, 'ApoderadoBancoNombre02'        = CONVERT( VARCHAR(100), '' )          
         --, 'ApoderadoBancoDomicilio02'     = CONVERT( VARCHAR(100), '' )          
         --, 'ApoderadoBancoFax02'           = CONVERT( VARCHAR(50), '' )           
         --, 'ApoderadoBancoFono02'          = CONVERT( VARCHAR(50), '' )       
                           
         , 'MtoPrecioTope'                 = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioSuperior'             = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioMedio'                = CONVERT( FLOAT, 0.0 )  
         , 'MtoPrecioPiso'                 = CONVERT( FLOAT, 0.0 )  
         , 'ReceptorPrima'                 = CONVERT( VARCHAR(100), CASE WHEN CaPrimaInicial > 0            
                    THEN @Nombre            
                                                                         ELSE LEFT( ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ), 100 )             
                                                                    END  )            
         , 'PagadorPrima'                  = CONVERT( VARCHAR(100), CASE WHEN CaPrimaInicial <= 0            
                                                                         THEN @Nombre            
                                                                         ELSE LEFT( ISNULL( Cliente.ClNombre, 'Cliente no esta en BAC' ), 100 )            
                                                                    END  )            
         , 'Control'                       = CONVERT( VARCHAR(250), '' )            
   , 'MontoMon1Escrito'      = CONVERT( VARCHAR(250), '' ) --ASVG_20110317            
   , 'MontoMon2Escrito'      = CONVERT( VARCHAR(250), '' ) --ASVG_20110317            
   , 'FechaVctoLarga'       = Det.CaFechaVcto --CONVERT( VARCHAR(30), '' ) --ASVG_20110317            
   , 'ApoderadoClienteComuna01'    = CONVERT( VARCHAR(50), '' )   --ASVG_20110429            
         , 'FechasVencimiento'             = CONVERT( VARCHAR(3000), '' )     --PRD_7274 STRIP              
         , 'FechasPago'                    = CONVERT( VARCHAR(3000), '' )     --PRD_7274 STRIP              
         , 'FechasVctoFinal'               = CONVERT( VARCHAR(10), '' )     --PRD_7274 STRIP              
         , 'RelacionaPAE'                  = CONVERT( CHAR(1), Enc.CaRelacionaPAE )  --PRD_13085 PAE Bonificado                     
   , 'CliDireccion'       = CONVERT( VARCHAR(40), Cliente.Cldirecc ) --PRD_13085 PAE Bonificado        
   , 'CliCiudad'           = CONVERT( VARCHAR(40), Ciudad.Nombre ) --PRD_13085 PAE Bonificado      
     
         --, 'ApoderadoClienteRut02'         = @cRut_Apoderado_Cliente_2         
         --, 'ApoderadoClienteDv02'          = CONVERT( CHAR(1), 0 )            
         --, 'ApoderadoClienteNombre02'      = CONVERT( VARCHAR(100), '' )     
, "GLOSA" = ENC.CAGLOSA
,CaResultadoVentasML as CaResultadoVentasML
,CaParStrike as CaParStrike       
,CaStrike          as CaStrike      
,CaPorcStrike as CaPorcStrike

      INTO #FIXING            
      from #CaFixing                                Fix               
           INNER JOIN #CaEncContrato                            Enc         ON
					Enc.CanumContrato = Fix.CaNumContrato 

     -- Para el cambio de un conepto a nivel de contrato se invierte la seleccion de la estructura para las Fwd Acotados    
           LEFT JOIN cbmdbopc..OpcionEstructura               Estructura      ON 
										Estructura.OpcEstCod = case when Enc.CaCodEstructura = 4 then 5     
																	when Enc.CaCodEstructura = 5 THEN 4    
																	else Enc.CaCodEstructura    
                                                                                                       end    
           -- Para el cambio de un conepto a nivel de contrato se invierte la seleccion de la estructura para las Fwd Acotados    
           LEFT JOIN BacParamSuda.dbo.Forma_de_Pago            
                                                    FormaPagoPrima  ON FormaPagoPrima.Codigo         = Enc.CafPagoPrima            

           LEFT JOIN BacParamSuda.dbo.cliente Cliente         ON Cliente.ClRut                 = Enc.CaRutCliente            
                                                                    AND Cliente.ClCodigo              = Enc.CaCodigo             
     -->   Se cambio de Orden y se agrego un LEFT  
     LEFT JOIN BacParamSuda.dbo.Ciudad  Ciudad On Ciudad.codigo_ciudad = Cliente.Clciudad  
     -->   Se cambio de Orden y se agrego un LEFT  
  
    
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaPrima     ON MonedaPrima.MnCodMon          = Enc.CaCodMonPagPrima            
           LEFT JOIN cbmdbopc..breakBacParamSudaCLIENTE       CGOp            ON CGOp.ClRut                    = Cliente.ClRut             
                                                                   AND CGOp.ClCodigo                 = Cliente.ClCodigo            
  
  
  
    LEFT JOIN cbmdbopc.dbo.Benchmark                 BenchFix         ON BenchFix.BenchMarkCod         = Fix.CaFixBenchComp                 
           LEFT JOIN cbmdbopc.dbo.BacParamSudaValor_Moneda      DefectoBench     ON Fix.cafixFecha                = DefectoBench.VmFecha            
                                                                   AND BenchFix.BenchMdaCodValorDef  = DefectoBench.vmcodigo            
           LEFT JOIN #CaCaja        Caj              ON Caj.CanumContrato             = Fix.CaNumContrato              
                                                                   AND Caj.CaNumEstructura           = Fix.CaNumEstructura            
                                                       AND Caj.CaCajOrigen              <> 'PP'            
         , #CaDetContrato                        Det              
           LEFT JOIN cbmdbopc..PayOffTipo                                     ON PayOffTipo.PayOffTipCod       = Det.CaTipoPayOff             
           -- POR HACER: cambiar a BDOpciones.BacParamMoneda            
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaM1        ON MonedaM1.MnCodMon             = Det.CaCodMon1            
           LEFT JOIN BacParamSuda.dbo.Moneda MonedaM2        ON MonedaM2.MnCodMon             = Det.CaCodMon2            
           LEFT JOIN BacParamSuda.dbo.Moneda MdaComp         ON MdaComp.MnCodMon              = Det.CaMdaCompensacion            

  --       , IMPRESION IMP            
         , cbmdbopc.dbo.OpcionTipo OT     --PRD_7274 STRIP            
--         , BacParamSuda.dbo.Ciudad Ciudad                 
     WHERE 
       Det.CaNumContrato   = Fix.CaNumContrato            
       AND Det.CaNumEstructura = Fix.CaNumEstructura        
       AND Det.CaFechaFijacion = Fix.CaFixFecha
     
       AND Enc.CaNumContrato   = Det.CaNumContrato            
    
--       AND Enc.CanumContrato   = IMP.ImpNumContrato            
--       AND ImpGrupo            = @Grupo            
              
       AND Det.CaTipoOpc       = OT.OpcTipCod    --PRD_7274 STRIP            
--    AND Cliente.Clciudad    = Ciudad.codigo_ciudad      


--and OpcEstCod = 0 --0=vanilla; 8=americano
--and enc.CaCodEstructura = 0 --0=vanilla; 8=americano
--and --(Fix.cafixFecha > '2020-06-05'	--FechaFijacion
		--or 
and		Det.CaFechaVcto >= '20201016'--)20191218
--AND CaCajEstado = 'N'
--8=collar  	--0=vanilla, 2=collar, 4=FWD Utilidad Acotada (Ganancia)

--order by Fix.CaNumContrato, CaNumEstructura,	Fix.CaFixNumero	--NumeroFijacion
           
--and Enc.CanumContrato in(5705,6375,6406,6426)
--5705,6375,6406,6978) 


--SELECT top 20 * FROM #CaEncContrato order by canumcontrato desc
--where canumcontrato = 5786
-- order by 1 desc 


--SELECT top 20 * FROM #CaDetContrato where canumcontrato = 6340
-- order by 1 desc 

IF @mostrarDetalle = 'S'
	SELECT "tipo" = '#FIXING', * FROM #FIXING 
	where numcontrato = @numope or @numope = 0
	ORDER BY numcontrato, numestructura, NumeroFijacion DESC

--SELECT 
--	"Num Opr." = 'SAO ' + CAST(NumContrato AS VARCHAR(10)) + '-' + CAST(numestructura AS VARCHAR(10)),
--	"Tipo Opr." = CVOpcCod + '-' + CallPut,
--	"Mon Opr." = RTRIM(MN1.mnnemo),
--	"Monto Opr." = REPLACE(CAST(MontoMon1 as VARCHAR(30)), '.', ','),
--	"Mon Conv." = RTRIM(MN2.mnnemo),
--	"Instrument" = RTRIM(MN1.mnnemo) + '/' + RTRIM(MN2.mnnemo),
--	"Monto Conv." = REPLACE(CAST(MontoMon2 as VARCHAR(30)), '.', ','),
----	"Mon Prima" = RTRIM(MNP.mnnemo),
----	"Prima Costo" = CaPrimaCosto,
--	"Contraparte" = CliNom,
--	"Operador" = T.[TRADER A INFORMAR], --Operador,
--	"Fecha Inicio" = RTRIM(CONVERT(VARCHAR(10), FechaContrato, 103)),
--	"Vencimiento" = RTRIM(CONVERT(VARCHAR(10), FechaVcto, 103)),
--	"Modalidad" = ModalidadDsc,
--	"Producto" = OpcEstDsc,
--	"Vinculacion" = Vinculacion,
--	"Glosa" = Glosa
----	OpcEstCod IN(6,
--, "MonPrimaCosto" = RTRIM(MNP.mnnemo) 
--, "PrimaCosto" = PrimaCosto
--, #FIXING.*
----*
--FROM #FIXING 	LEFT JOIN BacParamSuda.dbo.MONEDA   MN1 ON mn1.mncodmon = Mon1Cod	--cacodmon1    
--	LEFT JOIN BacParamSuda.dbo.MONEDA   MN2 ON mn2.mncodmon = Mon2Cod	--cacodmon1    
--	LEFT JOIN BacParamSuda.dbo.MONEDA   MNP ON mnP.mncodmon = MonPrimaCosto
--	LEFT JOIN #TRADER_MUREX AS T ON
--		T.[COD. OPER. BAC] = Operador 
----where  OpcEstCod = 0 --0=vanilla; 8=americano
--order by 1

--7320,7322,7323,7324,7336,7337

SELECT distinct
	--"Codigo Estructura" = 
	OpcEstCod,
	--"Descrip. Estructura" = 
	OpcEstDsc,
	NumContrato,
	"Glosa"
INTO #FIXING2
FROM #FIXING

--SELECT 
--	"Codigo Estructura" = OpcEstCod,
--	"Descrip. Estructura" = OpcEstDsc,
--	GLOSA,
--	"Cantidad de Operaciones" = count(1)
----	"Cantidad de Operaciones Vigentes" = ISNULL(CASE WHEN GLOSA <> 'Simulación consumo LCR / Opciones' THEN count(1) END, 0),
----	"Simulaciones" = ISNULL(CASE WHEN GLOSA = 'Simulación consumo LCR / Opciones' THEN count(1) END, 0)
--FROM #FIXING2
--group by
--	OpcEstCod,
--	OpcEstDsc, GLOSA
--order by 1, 2

--*** FIJACIONES ***
--SELECT --CAF.* 
--	--CaNumContrato	
--	--CaNumEstructura
--	"Num Opr." = 'SAO ' + CAST(CAF.CaNumContrato AS VARCHAR(10)) + '-' + CAST(CAF.CaNumEstructura AS VARCHAR(10)),	
--	"CaFixFecha"	= RTRIM(CONVERT(VARCHAR(10), CAF.CaFixFecha, 103)),
--	CAF.CaFixNumero,
--	CAF.CaPesoFij	,
--	CAF.CaVolFij	,
--	CAF.CaFijacion,	
--	--CaFixBenchComp	,
--	"CaFixBenchComp" = RTRIM(MNF.mnnemo)
--	--CaFixParBench	,
--	--CaFixEstado,
--FROM #CaFixing AS CAF INNER JOIN #FIXING AS FIX ON
--	CAF.CanumContrato = FIX.NumContrato and
--	CAF.CaNumEstructura = fix.NumEstructura 
--	LEFT JOIN BacParamSuda.dbo.MONEDA   MNF ON MNF.mncodmon = CaFixBenchComp
--WHERE
--	OpcEstCod IN(6, 13)		--6=ASIATICOS y 13=Forward Entrada Salida
--ORDER BY 
--	CAST(CanumContrato AS INT), CAST(CaNumEstructura AS INT), CAST(CaFixNumero AS INT)


--SELECT * FROM #CaEncContrato WHERE CanumContrato in(5779, 7071, 7086) ORDER BY CanumContrato
 
--SELECT * FROM #CaDetContrato WHERE CanumContrato in(5779, 7071, 7086) ORDER BY CanumContrato

--asiatico SAO 7703-1
--select * from reportes..OpcionEstructura

IF @mostrarDetalle IN('S', 'CD')
BEGIN
	SELECT 
		"Num Opr." = 'SAO ' + CAST(E.CanumContrato AS VARCHAR(10)) + '-' + CAST(D.CaNumEstructura AS VARCHAR(10)),
      "Tipo Oper."  = CONVERT( VARCHAR(30), ISNULL(  Estructura.OpcEstDsc  , 'Estructura no Existe' )),
		"Glosa" = E.CAGLOSA,
		"TIPO 1 ->" = 'ENCABEZADO', E.*, 
		"TIPO 2 ->" = 'DETALLE', D.*,
		"TIPO 3 ->" = 'CAJA', C.*
--		"TIPO 4 ->" = 'FIJACION', F.*
		
	FROM #CaEncContrato AS E LEFT JOIN #CaDetContrato AS D ON
			D.CaNumContrato = E.CanumContrato
		LEFT JOIN #CaCaja AS C ON
			C.CaNumContrato = E.CanumContrato		
        LEFT JOIN cbmdbopc..OpcionEstructura  Estructura      ON 
					Estructura.OpcEstCod = case when E.CaCodEstructura = 4 then 5     
															when E.CaCodEstructura = 5 THEN 4    
															else E.CaCodEstructura    
													END
	WHERE 		
		E.CanumContrato = @numope or @numope = 0
--		D.CaFechaVcto >= '20201016'--)20191218
	ORDER BY 1
END 



END 
GO
