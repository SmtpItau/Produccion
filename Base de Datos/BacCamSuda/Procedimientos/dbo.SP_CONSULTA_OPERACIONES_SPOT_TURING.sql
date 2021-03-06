USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_SPOT_TURING]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_SPOT_TURING]    
     (    
		  @MOTIPMER    CHAR(04)     = 'T'  -- PRODUCTO
		, @RUTCLI     Numeric(9,0)  = 0    -- RUT CLIENTE
		, @MOCODMON   CHAR(03)      = 'T'  -- CODIGO MONEDA
		, @MOOPER     CHAR(15)      = 'T'  -- USUARIO
		, @MOTIPOPE   CHAR(01)      = 'T'  -- VENTA O COMPRA
		, @FEC_INI    DATETIME             -- FECHA INICIAL
		, @FEC_FIN    DATETIME             -- FECHA FINAL
		, @ORIGEN     CHAR(01)      = 'V'  -- V PARA VIGENTE Y H PARA HISTORICO 
     )    
AS    
BEGIN    
    
	SET NOCOUNT ON    


/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES DE ENTRADAS                                        */
/*-----------------------------------------------------------------------------*/
    --SET @MOTIPMER   = 'EMPR'
    --SET @RUTCLI     = 0       
	--SET @MOCODMON   = 'USD'
	--SET @MOOPER     = 'PCONCHA'
	--SET @MOTIPOPE   = 'C'
	--SET @FEC_INI    = '2013/11/01'
	--SET @FEC_FIN    = '2013/11/05'

--SP_CONSULTA_OPERACIONES_SPOT_TURING 'T',0,'T','T','C','20131101','20131105','V'


/*-----------------------------------------------------------------------------*/
/* OBJETIVO : OPERACIONES DEL DIA DEL SPOT                                     */
/*            SE MODIFICA EL ORDEN DEL PROCESO PARA PROVOCAR UNA HOMOLOGACION  */
/*            GENERALIZADA PARA OBTENER LOS RESULTADOS EN LA GRILLA DEL        */
/*   		  PROYECTO TURING REQUERIMIENTO 19162                              */
/* AUTOR    : ROBERTO MORA DROGUETT                                            */
/* FECHA    : 18/03/2014                                                       */
/*          : ORDEN DE PROCEDIMIENTO SP_OPERACIONES_DIA                        */
/*-----------------------------------------------------------------------------*/




/*-----------------------------------------------------------------------------*/
/* SALIDA DE REGISTROS VIGENTES                                                */
/*-----------------------------------------------------------------------------*/
  IF @ORIGEN = 'V' BEGIN 


  SELECT 'ENTID'    = MOENTIDAD       
        ,'TIPOMERC' = MOTIPMER        
        ,'NUMOPE'   = MONUMOPE        
        ,'RUT'      = ISNULL(A.CLRUT,0)
        ,'DV'       = ISNULL(A.CLDV,'')
        ,'CODCLIEN' = ISNULL(A.CLCODIGO,0)
        ,'NOMCLIEN' = SUBSTRING( ISNULL(A.CLNOMBRE,''), 1, 49)
        ,'TIPOPER'  = MOTIPOPE        
        ,'CODMDA'   = MOCODMON        
        ,'MDACONV'  = MOCODCNV        
        ,'MONTO'    = MOMONMO         
        ,'TIPCAMB'  = MOTICAM         
        ,'TCTRA'    = MOTCTRA         
        ,'PARME'    = MOPARME         
        ,'PARTR'    = MOPARTR         
        ,'PRECIO'   = MOPRECIO        
        ,'PRETRA'   = MOPRETRA        
        ,'USSME'    = MOUSSME         
        ,'MONPE'    = MOMONPE         
        ,'ENTREG'   = MOENTRE         
        ,'GLOENTR'  = ISNULL((SELECT GLOSA 
		                        FROM VIEW_FORMA_DE_PAGO 
							   WHERE CODIGO  =  MOENTRE),'') 
        ,'FECVALUE' = CONVERT(CHAR(10),MOVALUTA1,103)      
        ,'RECIB'    = MORECIB          
        ,'GLORECIB' = ISNULL((SELECT GLOSA 
		                        FROM VIEW_FORMA_DE_PAGO 
							   WHERE CODIGO=MORECIB),'')  
        ,'FECVALUR' = CONVERT(CHAR(10),MOVALUTA2,103) 
        ,'OPER'     = MOOPER         
        ,'FECHA'    = CONVERT(CHAR(10),MOFECH,103)     
        ,'HORA'     = MOHORA         
        ,'GLOMDA'   = D.MNGLOSA      
        ,'GLOMDACN' = E.MNGLOSA      
        ,'VAMOS'    = MOVAMOS        
        ,'TERM'     = MOTERM         
        ,'CODOMA'   = MOCODOMA       
        ,'ESTATUS'  = MOESTATUS      
        ,'RENTAB'   = MORENTAB       
        ,'ALINEA'   = MOALINEA       
        ,'TIPCAR'   = MOTIPCAR 
        ,'NUMFUT'   = MONUMFUT 
        ,'FECHAINI' = MOFECINI 
        ,'APROBA'   = MOAPROB  
        ,'CBCOMDA'  = D.MNCODBANCO 
        ,'CBCOMDAC' = E.MNCODBANCO 
        ,'ENTIDAD'  = ( SELECT DISTINCT F.RCNOMBRE FROM  VIEW_ENTIDAD F WHERE  F.RCCODCAR = MOENTIDAD )
        ,'NOMPROP'  = ( SELECT DISTINCT ACNOMBRE   FROM  MEAC )    
        ,'FECHAP'   = ( SELECT  DISTINCT ACFECPRO  FROM  MEAC )    
        ,'HORASERV' = CONVERT(CHAR(08),GETDATE(),108)          
        ,'ESTADO'   = MOESTATUS        
        ,'FECHASER' = CONVERT(CHAR(10),GETDATE(),101)    
        ,'TIPMERC'  = MOTIPMER         
        ,'OBSERV'   = OBSERVACION      
        ,'CODCOMER' = CODIGO_COMERCIO  
        ,'RUTGIRAD' = MORUTGIR         
        ,'NOMGIRAD' = CASE 
		              WHEN MORUTGIR = 0 THEN ' ' 
					  ELSE ( SELECT CLNOMBRE 
					           FROM VIEW_CLIENTE
							  WHERE CLRUT     =  MORUTGIR 
							    AND CLCODIGO  =  mocodigogirador ) 
				      END
        ,'DESCRIP'  = P.DESCRIPCION      
        ,'USSTR'    = MOUSSTR         
        ,'SWIFT_C'  = SWIFT_CORRESPONSAL
        ,'SWIFT_R'  = SWIFT_RECIBIMOS   
        ,'SWIFT_E'  = SWIFT_ENTREGAMOS  
        ,'COSTFOND' = MOCOSTOFO         
        ,'ENTMX'    = FORMA_PAGO_CLI_EXT  
        ,'GLOENTMX' = CASE 
		              WHEN FORMA_PAGO_CLI_EXT = 0 THEN ' ' 
					  ELSE ( SELECT GLOSA 
					           FROM VIEW_FORMA_DE_PAGO 
							  WHERE CODIGO   =  FORMA_PAGO_CLI_EXT )
			          END
        ,'FECVALMX' = CONVERT(CHAR(10),VALUTA_CLI_EXT,103)     
        ,'RECMN'    = FORMA_PAGO_CLI_NAC       
        ,'GLORECMN' = CASE 
		              WHEN FORMA_PAGO_CLI_NAC = 0 THEN ' ' 
					  ELSE ( SELECT GLOSA 
					           FROM VIEW_FORMA_DE_PAGO 
							  WHERE CODIGO   =  FORMA_PAGO_CLI_NAC )
				      END
        ,'FECVALMN' = CONVERT(CHAR(10),VALUTA_CLI_NAC,103)    
        ,'FECVCTO'  = ISNULL(CONVERT(CHAR(10),MOFECVCTO,103),'')    
        ,'DIAS'     = MODIAS        
        ,'USUARIO'  = MOOPER        
        ,'UF_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROC) 
        ,'UF_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROX) 
        ,'IVP_HOY'  = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROC) 
        ,'IVP_MAN'  = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROX) 
        ,'DO_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC) 
        ,'DO_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROX) 
        ,'DA_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROC) 
        ,'DA_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROX) 
        ,'CodigoGir' = mocodigogirador 
        ,'MORECIB_C' = MORECIB         
        ,'MOTLXP1'   = MOTLXP1  
	    ,'PLAZO'     = 0
	    ,'ResultadoMesaPeso' = moDifTran_Clp
		,'ResultadoMesaUsd' = moDifTran_Mo
		
    FROM MEMO    
    LEFT JOIN 
	     VIEW_FORMA_DE_PAGO           r 
      ON R.codigo          =  MORECIB    
    LEFT join 
	     VIEW_CLIENTE                 A 
	  ON MORUTCLI          =  A.CLRUT  
     AND MOCODCLI          =  A.CLCODIGO  
   INNER JOIN
         VIEW_MONEDA                  D
      ON MOCODMON          = SUBSTRING( D.MNNEMO, 1, 3 )        
   INNER JOIN
         VIEW_MONEDA                  E
      ON MOCODCNV          = SUBSTRING( E.MNNEMO, 1, 3 )              
   INNER JOIN
         VIEW_PRODUCTO                P
      ON P.ID_SISTEMA      = 'BCC' 
	 AND P.CODIGO_PRODUCTO = MOTIPMER  
   WHERE (MOTIPMER         = @MOTIPMER OR   @MOTIPMER  ='T')
     AND (MORUTCLI         = @RUTCLI   OR   @RUTCLI    = 0 )
	 AND (MOCODMON         = @MOCODMON OR   @MOCODMON  ='T')
	 AND (MOOPER           = @MOOPER   OR   @MOOPER    ='T')
	 AND (MOTIPOPE         = @MOTIPOPE OR   @MOTIPOPE  ='T')
	 AND  MOFECH   Between   @FEC_INI And   @FEC_FIN
  ORDER BY MONUMOPE
END



/*-----------------------------------------------------------------------------*/
/* SALIDA DE REGISTROS HISTORICOS                                              */
/*-----------------------------------------------------------------------------*/
IF @ORIGEN = 'H' BEGIN 


  SELECT 'ENTID'    = MOENTIDAD       
        ,'TIPOMERC' = MOTIPMER        
        ,'NUMOPE'   = MONUMOPE        
        ,'RUT'      = ISNULL(A.CLRUT,0)
        ,'DV'       = ISNULL(A.CLDV,'')
        ,'CODCLIEN' = ISNULL(A.CLCODIGO,0)
        ,'NOMCLIEN' = SUBSTRING( ISNULL(A.CLNOMBRE,''), 1, 49)
        ,'TIPOPER'  = MOTIPOPE        
        ,'CODMDA'   = MOCODMON        
        ,'MDACONV'  = MOCODCNV        
        ,'MONTO'    = MOMONMO         
        ,'TIPCAMB'  = MOTICAM         
        ,'TCTRA'    = MOTCTRA         
        ,'PARME'    = MOPARME         
        ,'PARTR'    = MOPARTR         
        ,'PRECIO'   = MOPRECIO        
        ,'PRETRA'   = MOPRETRA        
        ,'USSME'    = MOUSSME         
        ,'MONPE'    = MOMONPE         
        ,'ENTREG'   = MOENTRE         
        ,'GLOENTR'  = ISNULL((SELECT GLOSA 
		                        FROM VIEW_FORMA_DE_PAGO 
							   WHERE CODIGO  =  MOENTRE),'') 
        ,'FECVALUE' = CONVERT(CHAR(10),MOVALUTA1,103)      
        ,'RECIB'    = MORECIB          
        ,'GLORECIB' = ISNULL((SELECT GLOSA 
		                        FROM VIEW_FORMA_DE_PAGO 
							   WHERE CODIGO=MORECIB),'')  
        ,'FECVALUR' = CONVERT(CHAR(10),MOVALUTA2,103) 
        ,'OPER'     = MOOPER         
        ,'FECHA'    = CONVERT(CHAR(10),MOFECH,103)     
        ,'HORA'     = MOHORA         
        ,'GLOMDA'   = D.MNGLOSA      
        ,'GLOMDACN' = E.MNGLOSA      
        ,'VAMOS'    = MOVAMOS        
        ,'TERM'     = MOTERM         
        ,'CODOMA'   = MOCODOMA       
        ,'ESTATUS'  = MOESTATUS      
        ,'RENTAB'   = MORENTAB       
        ,'ALINEA'   = MOALINEA       
        ,'TIPCAR'   = MOTIPCAR 
        ,'NUMFUT'   = MONUMFUT 
        ,'FECHAINI' = MOFECINI 
        ,'APROBA'   = MOAPROB  
        ,'CBCOMDA'  = D.MNCODBANCO 
        ,'CBCOMDAC' = E.MNCODBANCO 
        ,'ENTIDAD'  = ( SELECT DISTINCT F.RCNOMBRE FROM  VIEW_ENTIDAD F WHERE  F.RCCODCAR = MOENTIDAD )
        ,'NOMPROP'  = ( SELECT DISTINCT ACNOMBRE   FROM  MEAC )    
        ,'FECHAP'   = ( SELECT  DISTINCT ACFECPRO  FROM  MEAC )    
        ,'HORASERV' = CONVERT(CHAR(08),GETDATE(),108)          
        ,'ESTADO'   = MOESTATUS        
        ,'FECHASER' = CONVERT(CHAR(10),GETDATE(),101)    
        ,'TIPMERC'  = MOTIPMER         
        ,'OBSERV'   = OBSERVACION      
        ,'CODCOMER' = CODIGO_COMERCIO  
        ,'RUTGIRAD' = MORUTGIR         
        ,'NOMGIRAD' = CASE 
		              WHEN MORUTGIR = 0 THEN ' ' 
					  ELSE ( SELECT CLNOMBRE 
					           FROM VIEW_CLIENTE
							  WHERE CLRUT     =  MORUTGIR 
							    AND CLCODIGO  =  mocodigogirador ) 
				      END
        ,'DESCRIP'  = P.DESCRIPCION      
        ,'USSTR'    = MOUSSTR         
        ,'SWIFT_C'  = SWIFT_CORRESPONSAL
        ,'SWIFT_R'  = SWIFT_RECIBIMOS   
        ,'SWIFT_E'  = SWIFT_ENTREGAMOS  
        ,'COSTFOND' = MOCOSTOFO         
        ,'ENTMX'    = FORMA_PAGO_CLI_EXT  
        ,'GLOENTMX' = CASE 
		              WHEN FORMA_PAGO_CLI_EXT = 0 THEN ' ' 
					  ELSE ( SELECT GLOSA 
					           FROM VIEW_FORMA_DE_PAGO 
							  WHERE CODIGO   =  FORMA_PAGO_CLI_EXT )
			          END
        ,'FECVALMX' = CONVERT(CHAR(10),VALUTA_CLI_EXT,103)     
        ,'RECMN'    = FORMA_PAGO_CLI_NAC       
        ,'GLORECMN' = CASE 
		              WHEN FORMA_PAGO_CLI_NAC = 0 THEN ' ' 
					  ELSE ( SELECT GLOSA 
					           FROM VIEW_FORMA_DE_PAGO 
							  WHERE CODIGO   =  FORMA_PAGO_CLI_NAC )
				      END
        ,'FECVALMN' = CONVERT(CHAR(10),VALUTA_CLI_NAC,103)    
        ,'FECVCTO'  = ISNULL(CONVERT(CHAR(10),MOFECVCTO,103),'')    
        ,'DIAS'     = MODIAS        
        ,'USUARIO'  = MOOPER        
        ,'UF_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROC) 
        ,'UF_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 998 AND VMFECHA = ACFECPROX) 
        ,'IVP_HOY'  = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROC) 
        ,'IVP_MAN'  = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 997 AND VMFECHA = ACFECPROX) 
        ,'DO_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC) 
        ,'DO_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROX) 
        ,'DA_HOY'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROC) 
        ,'DA_MAN'   = (SELECT VMVALOR FROM VIEW_VALOR_MONEDA,VIEW_MDAC WHERE VMCODIGO = 995 AND VMFECHA = ACFECPROX) 
        ,'CodigoGir' = mocodigogirador 
        ,'MORECIB_C' = MORECIB         
        ,'MOTLXP1'   = MOTLXP1  
		,'PLAZO'     = 0
		,'ResultadoMesaPeso' = moDifTran_Clp
		,'ResultadoMesaUsd'  = moDifTran_Mo
    FROM MEMOH    
    LEFT JOIN 
	     VIEW_FORMA_DE_PAGO           r 
      ON R.codigo          =  MORECIB    
    LEFT join 
	     VIEW_CLIENTE                 A 
	  ON MORUTCLI          =  A.CLRUT  
     AND MOCODCLI          =  A.CLCODIGO  
   INNER JOIN
         VIEW_MONEDA                  D
      ON MOCODMON          = SUBSTRING( D.MNNEMO, 1, 3 )        
   INNER JOIN
         VIEW_MONEDA                  E
      ON MOCODCNV          = SUBSTRING( E.MNNEMO, 1, 3 )              
   INNER JOIN
         VIEW_PRODUCTO                P
      ON P.ID_SISTEMA      = 'BCC' 
	 AND P.CODIGO_PRODUCTO = MOTIPMER  
   WHERE (MOTIPMER         = @MOTIPMER OR   @MOTIPMER  ='T')
     AND (MORUTCLI         = @RUTCLI   OR   @RUTCLI    = 0 )
	 AND (MOCODMON         = @MOCODMON OR   @MOCODMON  ='T')
	 AND (MOOPER           = @MOOPER   OR   @MOOPER    ='T')
     AND (MOTIPOPE         = @MOTIPOPE OR   @MOTIPOPE  ='T') 
	 AND  MOFECH   Between   @FEC_INI And   @FEC_FIN
	ORDER BY MONUMOPE
END

END






GO
