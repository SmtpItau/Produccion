USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_SADP_GRABA_RESCATES_A_PAGO_REV]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SADP_GRABA_RESCATES_A_PAGO_REV] ( @dfecha DATETIME , @sUsuario VARCHAR(15))
AS   
BEGIN  
  
  INSERT   
    INTO SADP_RESCATES_PAGO( Fecha    ,  
         idFolio    ,  
         secuencia   ,    
         codFondo   ,  
         Monto    ,  
         Estado    ,  
         sNumTransferencia ,   
         sUsuario   )  
      
  SELECT fecha_pago  
  ,  folio_movimiento  
  ,  secuencia  
  ,  fmc.cod_fondo  
  ,      (fds.monto_pago_detalle_um-fds.comision_monto)   
  ,  'P'  
  ,  ''  
  ,  'RES'   
    FROM fmparticipes.dbo.fmp_movimientos_cursados fmc  
   INNER   
    JOIN FMParticipes.dbo.FMP_DETALLE_SOLICITUDES fds  
   ON fds.folio_solicitud=fmc.folio_movimiento  
     AND fds.cod_movimiento=fmc.cod_movimiento  
   WHERE fmc.fecha_pago = @dFecha  
     AND FMC.TIPO_MOVIMIENTO ='R'  
     AND folio_movimiento NOT IN (SELECT idFolio   
            FROM bacparamsuda.dbo.SADP_RESCATES_PAGO   
                                   WHERE fecha =@dfecha)  
     
  
  DECLARE @table   
     TABLE(  Folio   NUMERIC(10)   
      ,  Secuencia  NUMERIC(10)  
      ,  codBanco  INT  
      ,  CtaCte   VARCHAR(20)  
      ,  RutBanco  NUMERIC(10)  
      ,  swift   VARCHAR(25)  
      ,  dv    VARCHAR(1)  
      ,  Direc   VARCHAR(100)  
      ,  Cod    SMALLINT  
      ,  NomBanco  VARCHAR(100)  
      ,  Moneda   SMALLINT  
      ,  RutPar   NUMERIC(10)  
      ,  dvPar   VARCHAR(1)  
      ,  NomPar   VARCHAR(100)  
      ,  codfPago  NUMERIC(3)  
      ,  monto   NUMERIC(21,4)  
      ,       ben_rut   NUMERIC(10)  
      ,       ben_rutdv  VARCHAR(1)  
      ,  ben_nombre  VARCHAR(100)  
     )  
       
  DECLARE @tblCargadas  
     TABLE(  numOper   NUMERIC(10)  
      ,  codfPago  NUMERIC(3) )  
        
  INSERT INTO @table  
  (  
   Folio,  
   Secuencia,   
   codBanco,  
   CtaCte,  
   RutBanco,  
   swift,  
   dv,  
   Direc,  
   Cod,  
   NomBanco,  
   Moneda,  
     
   RutPar,  
   dvPar,  
   NomPar,  
     
   codfPago,  
   monto,  
     
   ben_rut,  
   ben_rutdv,   
   ben_nombre  
  )  
    
  SELECT fds.folio_solicitud    AS Folio  
  ,  fds.secuencia     AS Sec              
  ,  ISNULL(vsb.Cod_Inst,0)   AS CodBanco  
  ,  fds.numero_cta_cte_part   AS CtaCte  
  ,  srbb.rut      AS RutBanco  
  ,  ISNULL(vsb.Clswift,'')   AS Swift  
  ,  ISNULL(vsb.Cldv,'')    AS Dv      
  ,  ISNULL(vsb.Cldirecc,'')    AS Direc     
  ,  ISNULL(vsb.Clcodigo,1)    AS Codigo  
  ,  ISNULL(vsb.Clnombre,'')   AS NomBanco  
  ,  sc.iCodSADP      AS Moneda  
  ,  fmc.RUT_PARTICIPE    AS RutParticipe  
  ,  fp.DV_RUT_PAR     AS DvParticipe  
  ,  CASE WHEN fp.tipo_persona = 1 THEN  nombres +' '+ fp.apellido_paterno + ' ' + fp.apellido_materno   
      ELSE fp.RAZON_SOCIAL  END  AS Cliente  
  ,  CASE	WHEN srfp.nCodInterno =103 AND srbb.rut<>97023000 THEN 134 
      ELSE           srfp.nCodInterno   
     END        AS CodigoFPago  
  ,      (fds.MONTO_PAGO_DETALLE_UM-fds.COMISION_monto) AS Monto  
     ,      case when fds.SW_PAGA_TERCERO='S' THEN fds.RUT_TERCERO ELSE 0 end    
  ,    0  
  ,    ''  
    FROM fmparticipes.dbo.fmp_movimientos_cursados fmc  
   INNER   
    JOIN FMParticipes.dbo.FMP_DETALLE_SOLICITUDES fds  
   ON fds.folio_solicitud=fmc.folio_movimiento  
     AND fds.cod_movimiento=fmc.cod_movimiento  
   INNER   
    JOIN SADP_RELACION_FPAGO srfp  
      ON srfp.cOrigen ='FFMM'  
     AND LTRIM(RTRIM(srfp.nCodExterno)) = CONVERT(CHAR(10),fds.cod_documento)  
   INNER   
    JOIN FMParticipes.dbo.FMP_BANCOS fb  
   ON fb.COD_BANCO = CASE  WHEN fds.COD_EMISOR_DOCUMENTO = 0 THEN 9999 ELSE  fds.COD_EMISOR_DOCUMENTO END     
   INNER  
    JOIN SADP_CONVERSIONMONEDA sc  
      ON sc.sSistema='FFMM'  
     AND sc.iCodMoneda=fds.COD_MONEDA  
   INNER  
    JOIN fmparticipes.dbo.FMP_PARTICIPES fp  
   ON fp.rut_participe=fmc.rut_participe  
    LEFT   
    JOIN SADP_REL_BCOFFMM_BANCOS srbb  
      ON srbb.codigo = fb.NEMOTECNICO  
    LEFT   
    JOIN view_sadp_bancos vsb  
      ON vsb.Clrut = srbb.rut           
   WHERE fmc.tipo_movimiento='R'  
     AND fmc.fecha_pago = @dFecha  
   ORDER   
   BY fmc.folio_movimiento  
     
  
  UPDATE @table  
     SET ben_rutdv = fpa.DV_RUT_AUTORIZADO  
  ,    ben_nombre = fpa.NOMBRE_AUTORIZADO   
  FROM @table  tbl  
  inner join FMParticipes.dbo.FMP_PERSONAS_AUTORIZADAS fpa  
    ON fpa.RUT_AUTORIZADO = tbl.ben_rut  
		 WHERE ben_rut <>0
  
		UPDATE @table SET CodfPago = 128 WHERE CodfPago= 134 AND monto>1000000000  --Mayor a 1000000000 se cambia a LBTR
		UPDATE @table set CtaCte = REPLACE(CtaCte ,'-','');
  
  INSERT INTO @tblCargadas  
  SELECT numero_operacion, forma_pago  
    FROM mdlbtr   
   WHERE fecha = @dfecha   
     AND sistema ='FFMM'   
     AND tipo_mercado='RES'   
		   AND estado_envio <>'E'
		   
		   --> Limpio todo lo que ya se envio
		   --> 

SELECT * FROM @table WHERE Folio =1448687
       
  DELETE @table     
   FROM @table PAGOS   
  INNER   
      JOIN mdlbtr Pago  
        ON pago.fecha = @dFecha  
       AND pago.sistema='FFMM'  
       AND pago.numero_operacion = pagos.Folio  
       AND pago.Secuencia        = pagos.Secuencia  
       AND pago.estado_envio     = 'E'  
       
SELECT * FROM @table WHERE Folio =1448687


		   --> Elimino los que no tendran ningun valor agregado
/*		DELETE @table
		WHERE codfPago = 0 				   
*/
       
		   
	   DELETE sadp_detalle_pagos
	     FROM sadp_detalle_pagos sdp
  INNER   
	     JOIN MDLBTR m
	       ON sdp.nContrato  = m.numero_operacion
	      AND sdp.cModulo	 = m.sistema
	      AND sdp.iSecuencia = m.Secuencia
		  AND m.fecha		 = @dfecha
		INNER 
		 JOIN @table tbl
		   ON tbl.Folio = m.numero_operacion
		  AND tbl.Secuencia = m.Secuencia
         
         
	   DELETE sadp_detalle_pagos 
    FROM SADP_DETALLE_PAGOS sdp  
   INNER   
	     JOIN MDLBTR m
	       ON sdp.nContrato  = m.numero_operacion
	      AND sdp.cModulo	 = m.sistema
	      AND sdp.iSecuencia = m.Secuencia
		  AND m.fecha		 = @dfecha
		  AND m.forma_pago = 0
		  AND m.tipo_mercado = 'RES'
		  AND m.sistema      ='FFMM'
		  
		  

	   DELETE MDLBTR
	     FROM MDLBTR m
   INNER   
    JOIN @table tbl  
		   ON tbl.Folio = m.numero_operacion
		  AND tbl.Secuencia = m.Secuencia
	            
	   DELETE MDLBTR
	   WHERE  forma_pago = 0
		  AND tipo_mercado = 'RES'
		  AND sistema      ='FFMM'

SELECT * FROM @table WHERE Folio =1448687

SELECT * FROM MDLBTR WHERE sistema ='FFMM' AND tipo_mercado='RES' AND numero_operacion=1448687
SELECT * FROM SADP_DETALLE_PAGOS WHERE CMODULO='FFMM' AND NCONTRATO=1448687

			INSERT INTO MDLBTR
			(	fecha,
				sistema,
				tipo_mercado,
				tipo_operacion,
				estado_envio,
				numero_operacion,
				rut_cliente,
				codigo_cliente,
				moneda,
				monto_operacion,
				forma_pago,
				fecha_operacion,
				fecha_vencimiento,
				liquidada,
				RecRutBanco,
				RecCodBanco,
				RecCodSwift,
				RecDireccion,
				RecCtaCte,
				Tipo_Movimiento,
				GlosaAnticipo,
				Id_Paquete,
				Estado_Paquete,
				Reservado,
				secuencia)
			SELECT @dFecha	 
				,	'FFMM'
				,	'RES'
				,	'RES'
				,	'PF2'
				,   tbl.folio
				,	tbl.RutPar
				,	1
				,	tbl.moneda
				,   tbl.monto
				,	tbl.CodfPago
				,	@dFecha
				,	@dFecha
				,	''
				,	tbl.RutBanco
				,	tbl.codBanco
				,	tbl.swift
				,	tbl.Direc
				,	tbl.CtaCte
				,	'C'
				,	''
				,	0
				,	'D'
				,	''
				,	tbl.Secuencia
				  FROM  @table tbl
			      	  
			INSERT INTO SADP_DETALLE_PAGOS
			(
				nContrato,
				cModulo,
				iMoneda,
				iFormaPago,
				nMonto,
				iRutBeneficiario,
				sDigBeneficiario,
				sNomBeneficiario,
				sNomBanco,
				sSwift,
				sCtaCte,
				sUsuario,
				sFirma1,
				sFirma2,
				cEstado,
				cObservaciones,
				iRutCliente,
				iCodigo,
				iRutBanco,
				sDvBanco,
				vNumTransferencia,
				iSecuencia)
			SELECT 
				tbl.Folio
			,	'FFMM'
			,	tbl.Moneda
			,	tbl.codfPago
			,	tbl.monto
			,	CASE when tbl.ben_rut <> 0 THEN tbl.ben_rut		else tbl.RutPar END 
			,	CASE when tbl.ben_rut <> 0 then tbl.ben_rutdv   else tbl.dvPar END
			,	CASE when tbl.ben_rut <> 0 then substring(tbl.ben_nombre,1,50) else SUBSTRING(tbl.NomPar,1,50) END 
			,	SUBSTRING(tbl.NomBanco,1,50)
			,	tbl.swift
			,	tbl.CtaCte
			,	@sUsuario
			,	@sUsuario
			,	''
			,	'PF2'
			,	''
			,	tbl.RutPar
			,	1
			,	tbl.RutBanco
			,	tbl.dv
			,	''
			,	tbl.Secuencia
			
			FROM @table tbl 
  
END  
-- SP_SADP_GRABA_RESCATES_A_PAGO_REV '20110915'  
GO
