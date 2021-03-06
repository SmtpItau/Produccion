USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_OPERACIONES_FORWARD_TURING]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CONSULTA_OPERACIONES_FORWARD_TURING] 
(		 @PRODUCTO               Numeric(5,2)  =  0      -- PRODUCTO
       , @RUTCLI                 Numeric(9,0)  =  0      -- RUT       
	   , @MONEDA                 INT           =  0      -- MONEDA NUMERICA
	   , @MOOPER                 CHAR(15)      = 'T'     -- USUARIO
	   , @MOTIPOPE               CHAR(01)      = 'T'     -- TIPO DE OPERACION
	   , @FEC_INI                DATETIME                -- FECHA INICIO
	   , @FEC_FIN                DATETIME                -- FECHA FIN
	   , @ORIGEN                 CHAR(01)      = 'V'     -- V VIGENTE H HISTORICO

)



/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES DE ENTRADAS                                        */
/*-----------------------------------------------------------------------------*/
                                                
--SP_CONSULTA_OPERACIONES_FORWARD_TURING 0,0,0,'T','T','20140401','20140409','H'

                  
/*-----------------------------------------------------------------------------*/
/* OBJETIVO : OPERACIONES DEL DIA DEL FORWARD                                  */
/*            SE MODIFICA EL ORDEN DEL PROCESO PARA PROVOCAR UNA HOMOLOGACION  */
/*            GENERALIZADA PARA OBTENER LOS RESULTADOS EN LA GRILLA DEL        */
/*   		  PROYECTO TURING REQUERIMIENTO 19162                              */
/* AUTOR    : ROBERTO MORA DROGUETT                                            */
/* FECHA    : 18/03/2014                                                       */
/*          : ORDEN DE PROCEDIMIENTO SP_LEEROPERACIONES                        */
/*-----------------------------------------------------------------------------*/


AS    
BEGIN    
   SET NOCOUNT ON 


/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES X DEFECTO                                          */
/*-----------------------------------------------------------------------------*/
  DECLARE @catcartnorm            NUMERIC(08)   = 1111
        , @catsubcart             NUMERIC(08)   = 1554 
        , @catlibro               NUMERIC(08)   = 1552
        , @Id_Libro               CHAR(06)      = '' 



/*-----------------------------------------------------------------------------*/
/* DECLARACION DE VARIABLES                                                    */
/*-----------------------------------------------------------------------------*/
  DECLARE @cnomprop    CHAR(40)    
        , @cdirprop    CHAR(40)    
        , @cfecpro     CHAR(10)    
        , @Glosa_Libro CHAR(50) 


/*-----------------------------------------------------------------------------*/
/* ASIGNACIONES DE VALORES                                                     */
/*-----------------------------------------------------------------------------*/
  SET @cnomprop = ( SELECT rcnombre  FROM BacfwdSuda.dbo.view_entidad )    
  SET @cdirprop = ( SELECT rcdirecc  FROM BacfwdSuda.dbo.view_entidad )    
  SET @cfecpro  = ( SELECT CONVERT ( CHAR(10), acfecproc, 103 ) FROM BacfwdSuda.dbo.mfac )    
   

/*-----------------------------------------------------------------------------*/
/* ASIGNACIONES DE VALORES                                                     */
/*-----------------------------------------------------------------------------*/
  IF  @id_libro = '' BEGIN    

      SET @Glosa_libro = '< TODOS >'     

  END     
  ELSE BEGIN    

      SELECT @Glosa_libro  = tbglosa    
        FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE  WITH(NOLOCK)
       WHERE tbcateg       = @CatLibro     
         AND tbcodigo1     = @Id_Libro    
  END    

/*-----------------------------------------------------------------------------*/
/* SALIDA DE REGISTROS VIGENTES                                                */
/*-----------------------------------------------------------------------------*/
 IF @ORIGEN ='V' BEGIN 



  SELECT * 
   FROM(
  SELECT  'MODIFICADA'         = CASE (SELECT TOP 1 g.caestado 
                                         FROM BacfwdSuda.dbo.mfca_log g WITH(NOLOCK)
				                        WHERE a.monumoper = g.canumoper) 
							     WHEN 'M' THEN 'MODIFICADA'   
                                 WHEN 'A' THEN 'ANULADA'  
                                 ELSE 'NO MODIFICADA' 
	                             END                    
		, 'GLOSA'              = CASE 
		                         WHEN var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' 
		                         Else lTrim(rTrim(c.descripcion)) 
	                             END  
        , 'TIPOPER'            = a.motipoper 
        , 'NOMBRE'             = b.clnombre
		, 'FECVCTO'            = CONVERT(CHAR(10),a.mofecvcto, 103) 
        , 'NEMO1'              = d.mnnemo                                          --> MonInstruemtno  
        , 'MTOMDA1'            = a.momtomon1                                       --> Nominales
        , 'TIPCAM'             = CASE 
		                         WHEN var_moneda2 = 0 THEN  CASE 
								                            WHEN a.mocodpos1 = 10 then round(convert(numeric(21,4),a.motipcam),4) 
															ELSE a.motipcam 
															END    
                                 ELSE a.moprecal    
                                 END
        , 'NEMO2'              = CASE 
		                         WHEN var_moneda2 = 0 THEN e.mnnemo 
								 ELSE 'CLP' 
								 END                                               --> MonPago    
        ,'MTOMDA2'             = CASE 
		                         WHEN var_moneda2 = 0  THEN CASE 
								                            WHEN a.mocodpos1 = 10 THEN Round(CONVERT(NUMERIC(21, 0), a.momtomon2), 0)    
                                                            WHEN a.mocodpos1 = 2  THEN a.momtomon2    
                                                            ELSE a.momtomon2    
                                                            END           
                                 ELSE f.camtomon1 * f.caprecal    
                                 END
        ,'CODPOS'              = CASE 
		                         WHEN f.var_moneda2 > 0 THEN 12 
								 ELSE a.mocodpos1 
								 END    
        ,                        Convert(numeric(10,0),Case 
		                         WHEN var_moneda2 > 0  
								 THEN var_moneda2 
								 Else a.monumoper 
								 End ) as  NUMOPER
		, 'NOMPROP'            = @cnomprop
		, 'DIRPROP'            = @cdirprop
		, 'FECPHOY'            = @cfecpro
		, 'ESTADO'             = CASE a.moestado 
		                         WHEN 'P' THEN 'PENDIENTE' 
								 WHEN 'R' THEN 'RECHAZADA' 
								 ELSE 'APROBADA' 
								 END
        , 'LOCK'               = a.molock
		, 'FVCTO'              = CONVERT( CHAR(10),a.mofecvcto,103) 
		, 'FPROC'              = CONVERT( CHAR(10),a.mofecha,103)
		, 'HORAOP'             = a.mohora
		, 'DIAS'               = a.moplazo
		, 'HORAREP'            = CONVERT(CHAR(8),GETDATE(),108)
		, 'MODAL'              = a.motipmoda
		, 'CALCE'              = CASE 
		                         WHEN f.camtocalzado > 0 THEN 'SI'     
                                 ELSE 'NO'     
                                 END 
        , 'PROD'               = a.mocodpos1
		, 'ESTADOGRABA'        = ''
		, 'CARTNORM'           = ISNULL((SELECT tbglosa 
		                                   FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catcartnorm 
										    AND tbcodigo1 = mocartera_normativa),'No Especificado')
        , 'SUBCART'            = ISNULL((SELECT tbglosa 
		                                   FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catsubcart 
										    AND tbcodigo1 = mosubcartera_normativa ),'No Especificado')    
        , 'LIBRO'              = ISNULL((SELECT tbglosa 
		                         FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catlibro  
										    AND tbcodigo1 = molibro),'No Especificado')                  
        , 'GLOSA_LIBRO'        = @Glosa_Libro
		, 'ESTADO_SINACOFI'    = SUBSTRING(f.Estado_sinacofi,1,2)
		, 'OPERADOR'           = CASE 
		                         WHEN a.mocodpos1 IN (1,2,3,7,10,11,12) THEN mooperador 
								 ELSE '' 
								 END
        , 'DIGITADOR'          = CASE 
		                         WHEN a.mocodpos1 IN ( 1, 2, 3, 7, 10, 11, 12 ) 
								 THEN modigitador
								 ELSE '' 
								 END
        , 'OPERACIONMXCLP'     = var_moneda2
		, 'PLAZO'              = isnull(DATEDIFF(dd,cafecha,cafecvcto),0)
		, 'RUT'                = mocodigo
		, 'VALIDACION'         = (CASE 
		                          WHEN var_moneda2 = 0 Then canumoper 
		                          Else var_moneda2
	                              END)  
		,'OPERACION'           = canumoper
		,'COD_PRODUCTO'        = CASE 
		                         WHEN var_moneda2 > 0 Then 12 
		                         Else mocodpos1
	                             END 
	    , 'MODALIDAD'		   = CONVERT( VARCHAR(10),ISNULL((CASE RTRIM(LTRIM(A.motipmoda))
	                                    WHEN 'C' THEN  'COMPENSADO' 
		                                ELSE 'FISICO' 
									    END),' ')) 
	    , 'PRECIOTRANSFERENCIA'=A.mopreciopunta
		,MOCALVTADOL                 --> PRD 21645	
		, 'Relacionada_Spot' =  CASE WHEN (a.mooperrelaspot = '06' and a.numerospot <> 0) THEN 'SWAP SPOT'
		    ELSE '' END   	
    FROM  BacfwdSuda.dbo.mfmo           a WITH(NOLOCK)
   INNER  JOIN       
          BacfwdSuda.dbo.view_cliente   b WITH(NOLOCK)
      ON  a.mocodigo                  = b.clrut           
     AND  a.mocodcli                  = b.clcodigo        
   INNER  JOIN    
          BacfwdSuda.dbo.view_producto  c WITH(NOLOCK)
      ON  c.id_sistema                = 'BFW'             
     AND  c.codigo_producto           = a.mocodpos1     
   INNER  JOIN
          BacfwdSuda.dbo.view_moneda    d WITH(NOLOCK)
      ON  a.mocodmon1                 = d.mncodmon 
   INNER  JOIN
          BacfwdSuda.dbo.view_moneda    e WITH(NOLOCK)
      ON  a.mocodmon2                 = e.mncodmon 
   INNER  JOIN
          BacfwdSuda.dbo.mfca           f WITH(NOLOCK)  
     ON  a.monumoper                  = f.canumoper 
   WHERE (a.mocodigo                  = @RUTCLI         OR @RUTCLI          =  0)
     AND (a.mocodmon1                 = @MONEDA         OR @MONEDA          =  0)
	 AND (a.mooperador                = @MOOPER         OR @MOOPER          = 'T')
     AND (a.motipoper                 = @MOTIPOPE       OR @MOTIPOPE        = 'T')
	 AND  a.mofecha   Between           @FEC_INI And   @FEC_FIN
     ) AS TABLA
   WHERE VALIDACION = OPERACION  
     AND (COD_PRODUCTO                = @PRODUCTO       OR @PRODUCTO        =  0)
  ORDER BY OPERACION




  END


  

/*-----------------------------------------------------------------------------*/
/* SALIDA DE REGISTROS HISTORICO                                               */
/*-----------------------------------------------------------------------------*/
 IF @ORIGEN ='H' BEGIN 



   SELECT * 
   FROM(
   SELECT  'MODIFICADA'         = CASE (SELECT TOP 1 g.caestado 
                                         FROM BacfwdSuda.dbo.mfca_log g 
				                        WHERE a.monumoper = g.canumoper) 
							     WHEN 'M' THEN 'MODIFICADA'   
                                 WHEN 'A' THEN 'ANULADA'  
                                 ELSE 'NO MODIFICADA' 
	                             END                    
		, 'GLOSA'              = CASE 
		                         WHEN var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' 
		                         Else lTrim(rTrim(c.descripcion)) 
	                             END  
        , 'TIPOPER'            = a.motipoper 
        , 'NOMBRE'             = b.clnombre
		, 'FECVCTO'            = CONVERT(CHAR(10),a.mofecvcto, 103) 
        , 'NEMO1'              = d.mnnemo                                          --> MonInstruemtno  
        , 'MTOMDA1'            = a.momtomon1                                       --> Nominales
        , 'TIPCAM'             = CASE 
		                         WHEN var_moneda2 = 0 THEN  CASE 
								                            WHEN a.mocodpos1 = 10 then round(convert(numeric(21,4),a.motipcam),4) 
															ELSE a.motipcam 
															END    
                                 ELSE a.moprecal    
                                 END
        , 'NEMO2'              = CASE 
		                         WHEN var_moneda2 = 0 THEN e.mnnemo 
								 ELSE 'CLP' 
								 END                                               --> MonPago    
        ,'MTOMDA2'             = CASE 
		                         WHEN var_moneda2 = 0  THEN CASE 
								    WHEN a.mocodpos1 = 10 THEN Round(CONVERT(NUMERIC(21, 0), a.momtomon2), 0)    
                                                            WHEN a.mocodpos1 = 2  THEN a.momtomon2    
                                                            ELSE a.momtomon2    
                                                            END           
                                 ELSE f.camtomon1 * f.caprecal    
                                 END
        ,'CODPOS'              = CASE 
		                         WHEN f.var_moneda2 > 0 THEN 12 
								 ELSE a.mocodpos1 
								 END    
        ,						 convert(numeric(10,0),Case 
		                         WHEN var_moneda2 > 0  
								 THEN var_moneda2 
								 Else a.monumoper 
								 End )  AS NUMOPER 
		, 'NOMPROP'            = @cnomprop
		, 'DIRPROP'            = @cdirprop
		, 'FECPHOY'            = @cfecpro
		, 'ESTADO'             = CASE a.moestado 
		                         WHEN 'P' THEN 'PENDIENTE' 
								 WHEN 'R' THEN 'RECHAZADA' 
								 ELSE 'APROBADA' 
								 END
        , 'LOCK'               = a.molock
		, 'FVCTO'              = CONVERT( CHAR(10),a.mofecvcto,103) 
		, 'FPROC'              = CONVERT( CHAR(10),a.mofecha,103)
		, 'HORAOP'             = a.mohora
		, 'DIAS'               = a.moplazo
		, 'HORAREP'            = CONVERT(CHAR(8),GETDATE(),108)
		, 'MODAL'              = a.motipmoda
		, 'CALCE'              = CASE 
		                         WHEN f.camtocalzado > 0 THEN 'SI'     
                                 ELSE 'NO'     
                                 END 
        , 'PROD'               = a.mocodpos1
		, 'ESTADOGRABA'        = ''
		, 'CARTNORM'           = ISNULL((SELECT tbglosa 
		                                   FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catcartnorm 
										    AND tbcodigo1 = mocartera_normativa),'No Especificado')
        , 'SUBCART'            = ISNULL((SELECT tbglosa 
		                                   FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catsubcart 
										    AND tbcodigo1 = mosubcartera_normativa ),'No Especificado')    
        , 'LIBRO'              = ISNULL((SELECT tbglosa 
		                                   FROM BacfwdSuda.dbo.VIEW_TABLA_GENERAL_DETALLE 
										  WHERE tbcateg   = @catlibro  
										    AND tbcodigo1 = molibro),'No Especificado')                  
        , 'GLOSA_LIBRO'        = @Glosa_Libro
		, 'ESTADO_SINACOFI'    = SUBSTRING(f.Estado_sinacofi,1,2)
		, 'OPERADOR'           = CASE 
		                         WHEN a.mocodpos1 IN (1,2,3,7,10,11,12) THEN mooperador 
								 ELSE '' 
								 END
        , 'DIGITADOR'          = CASE 
		                         WHEN a.mocodpos1 IN ( 1, 2, 3, 7, 10, 11, 12 ) 
								 THEN modigitador
								 ELSE '' 
								 END
        , 'OPERACIONMXCLP'     = var_moneda2
		, 'PLAZO'              = isnull(DATEDIFF(dd,cafecha,cafecvcto),0)
		, 'RUT'                = mocodigo
		, 'VALIDACION'         = (CASE 
		                          WHEN var_moneda2 = 0 Then canumoper 
		                          Else var_moneda2
	                              END)  
		,'OPERACION'           = canumoper
		,'COD_PRODUCTO'        = CASE 
		                         WHEN var_moneda2 > 0 Then 12 
		                         Else mocodpos1
	                             END 
	    , 'MODALIDAD'		   = CONVERT( VARCHAR(10),ISNULL((CASE RTRIM(LTRIM(A.motipmoda))
	                                    WHEN 'C' THEN  'COMPENSADO' 
		                                ELSE 'FISICO' 
									    END),' ')) 
	    , 'PRECIOTRANSFERENCIA'=A.mopreciopunta
	    ,MOCALVTADOL    --> PRD 21645		
		, 'Relacionada_Spot' =  CASE WHEN  (a.numerospot <> 0) THEN 'SWAP SPOT'
		    ELSE '' END   

    FROM  BacfwdSuda.dbo.mfmoh          a 
   INNER  JOIN       
          BacfwdSuda.dbo.view_cliente   b WITH(NOLOCK)
      ON  a.mocodigo                  = b.clrut           
     AND  a.mocodcli                  = b.clcodigo        
   INNER  JOIN    
          BacfwdSuda.dbo.view_producto  c WITH(NOLOCK)
      ON  c.id_sistema                = 'BFW'             
     AND  c.codigo_producto           = a.mocodpos1     
   INNER  JOIN
          BacfwdSuda.dbo.view_moneda    d WITH(NOLOCK)
      ON  a.mocodmon1                 = d.mncodmon 
   INNER  JOIN
          BacfwdSuda.dbo.view_moneda    e WITH(NOLOCK)
      ON  a.mocodmon2                 = e.mncodmon 
   INNER  JOIN
          BacfwdSuda.dbo.mfca           f WITH(NOLOCK)  
      ON  a.monumoper                  = f.canumoper 
   WHERE (a.mocodigo                  = @RUTCLI         OR @RUTCLI          =  0)
     AND (a.mocodmon1                 = @MONEDA         OR @MONEDA          =  0)
	 AND (a.mooperador                = @MOOPER         OR @MOOPER          = 'T')
     AND (a.motipoper                 = @MOTIPOPE       OR @MOTIPOPE        = 'T')
	 AND  a.mofecha   Between           @FEC_INI And   @FEC_FIN
      ) AS TABLA
   WHERE VALIDACION  = OPERACION  
     AND (COD_PRODUCTO                = @PRODUCTO       OR @PRODUCTO        =  0)
  ORDER BY OPERACION
  
  

 END

END


GO
