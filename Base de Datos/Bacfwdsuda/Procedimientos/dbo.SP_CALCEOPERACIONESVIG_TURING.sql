USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALCEOPERACIONESVIG_TURING]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CALCEOPERACIONESVIG_TURING] ( @norden  FLOAT,  
                                          @nentidad      FLOAT,  
                                          @ncodpos       FLOAT,  
                                          @ncodmda       FLOAT,  
                                          @nrutcli       FLOAT,  
                                          @nnumoper      FLOAT,  
                                          @cfecproc      VARCHAR ( 08 ),  
                                          @cfecvcto      VARCHAR ( 08 ),  
                                          @nentrefechas  FLOAT,  
                                          @nfecinivcto   FLOAT,  
                                          @dfecdesde     CHAR    ( 08 ),  
                                          @dfechasta     CHAR    ( 08 ),  
                                          @cat_cartnorm  CHAR    ( 06 )= '',  
                                          @cat_subcart  CHAR ( 06 )= '',  
                                          @cat_libro  CHAR ( 06 )= '',  
                                          @Id_CartNorm  CHAR ( 06 )= '',  
                                          @Id_SubCartNorm CHAR ( 06 )= '',  
                                          @Id_Libro      CHAR ( 06 )= '',
										  @operador      VARCHAR(100) = 'T',
										  @TipoOper      VARCHAR(1) = ''										    
                                         )  
AS  
BEGIN  
   SET NOCOUNT ON  
   DECLARE @dfecproc    CHAR(8)  
   DECLARE @cnomprop    CHAR(40)  
   DECLARE @cdirprop    CHAR(40)  
   DECLARE @cselect     VARCHAR(255)  
   DECLARE @cdesde      VARCHAR(255)  
   DECLARE @chasta      VARCHAR(255)  
   DECLARE @corden      VARCHAR(255)  
 , @Glosa_Libro CHAR(50)  
  
  IF  @id_libro = '' BEGIN  
 SELECT @Glosa_libro = '< TODOS >'   
  END   
  ELSE BEGIN  
 SELECT @Glosa_libro = tbglosa  
 FROM VIEW_TABLA_GENERAL_DETALLE  
 WHERE tbcateg  = @Cat_Libro   
 AND tbcodigo1 = @Id_Libro  
  END  
  
  
   SELECT      @dfecproc = CONVERT(CHAR(8),acfecproc,112)  ,  
               @cnomprop = acnomprop  ,  
               @cdirprop = acdirprop     
   FROM mfac  
   SELECT @cselect = 'SELECT * FROM #tmpmfca '  
   IF @dfecdesde = '' AND @nentrefechas = 1 BEGIN  
      SELECT @dfecdesde = CONVERT ( CHAR ( 08 ), @dfecproc, 112 )  
   END  
   IF @dfechasta = '' AND @nentrefechas = 1 BEGIN  
      SELECT @dfechasta = CONVERT ( CHAR ( 08 ), @dfecproc, 112 )  
   END  
   IF @cfecproc <> '' BEGIN  
      SELECT @cselect = @cselect + ' WHERE CONVERT ( DATETIME, fproc ) = ''' + @cfecproc + ''' '  
        
  
   END  
   IF @cfecproc <> '' AND @cfecvcto <> '' BEGIN  
      SELECT @cselect = @cselect + ' AND CONVERT ( DATETIME, fvcto ) = ''' + @cfecvcto + ''' '  
   END ELSE IF @cfecvcto <> '' BEGIN  
      SELECT @cselect = @cselect + ' WHERE CONVERT ( DATETIME, fvcto ) = ''' + @cfecvcto + ''' '  
   END  
   IF @cfecproc <> '' AND @cfecvcto <> '' AND @nentrefechas = 1 BEGIN  
      SELECT @cdesde = ' AND CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '  
      SELECT @chasta =     ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '  
   END ELSE IF @cfecvcto <> '' AND @nentrefechas = 1 BEGIN  
      SELECT @cdesde = ' AND CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '  
      SELECT @chasta =     ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '  
   END ELSE IF @nentrefechas = 1 BEGIN  
      SELECT @cdesde = ' WHERE CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END >= CONVERT ( DATETIME, ''' + @dfecdesde + ''' ) AND '  
      SELECT @chasta =       ' CASE ' + CONVERT ( CHAR ( 1 ), @nfecinivcto ) + ' WHEN 0 THEN CONVERT ( DATETIME, fproc ) WHEN 1 THEN CONVERT ( DATETIME, fvcto ) END <= CONVERT ( DATETIME, ''' + @dfechasta + ''' ) '  
   END  
   IF @norden = 0 BEGIN  
      SELECT @corden = ' ORDER BY nrooperacion'  
   END ELSE IF @norden = 1 BEGIN  
      SELECT @corden = ' ORDER BY nomcliente'  
   END ELSE IF @norden = 2 BEGIN  
      SELECT @corden = ' ORDER BY monedaco2nver'  
   END ELSE IF @norden = 3 BEGIN  
      SELECT @corden = ' ORDER BY fproc'  
   END ELSE IF @norden = 4 BEGIN  
      SELECT @corden = ' ORDER BY fvcto'  
   END  
   SELECT @cselect = ISNULL ( RTRIM ( @cselect ), '' ),  
          @cdesde  = ISNULL ( RTRIM ( @cdesde  ), '' ),  
          @chasta  = ISNULL ( RTRIM ( @chasta  ), '' ),  
          @corden  = ISNULL ( RTRIM ( @corden  ), '' )  
   SELECT   'nrooperacion'= a.canumoper                                 ,  
            'nomcliente'   = b.clnombre                                  ,  
            'tipooperacion'= a.catipoper                                 ,  
            'fechavcto'  = CONVERT ( CHAR ( 10 ), a.cafecvcto, 103 )   ,  
            'monedaco2nver' = c.mnnemo                                    ,  
            'montoorigen'  = a.camtomon1                                 ,  
            --'producto'     = d.descripcion                               ,  
             'producto'  = Case when var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' Else lTrim(rTrim(d.descripcion)) End,    
			'fechacompra'  = CONVERT ( CHAR ( 10 ), a.cafecha, 103 )     ,   
            'fechaproceso' = CONVERT ( CHAR ( 10 ), CONVERT(DATETIME,@dfecproc), 103 )  ,  
            'plazo'        = a.caplazo                                   ,  
            'monedaorigen' = e.mnnemo                                    ,  
            'precio'       = a.catipcam                                  ,  
            'montoconver'  = a.camtomon2                                 ,  
            'nombrepropie' = @cnomprop                                   ,  
            'direccpropie' = @cdirprop                                   ,  
            'posición'     = a.cacodpos1                                 ,  
            'fvcto'        = CONVERT ( CHAR ( 8 ), a.cafecvcto, 112 )   ,  
            'fproc'        = CONVERT ( CHAR ( 8 ), a.cafecha, 112 )     ,  
            'codmda'       = cacodmon1                                   ,  
            'HoraOp'       = a.cahora             ,  
   'HoraRep'    = CONVERT(CHAR(8),GETDATE(),108)          ,  
   'Modal'        = a.catipmoda            ,  
   'calce'        = CASE WHEN a.camtocalzado > 0 THEN 'SI' ELSE 'NO' END ,  
   'Estado'       = CASE WHEN a.caestado = 'P' THEN 'PENDIENTE'  
      WHEN a.caestado = 'R' THEN 'RECHAZADA'   
      ELSE  'APROBADA'  
        END,  
           'cartera norm' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado') ,  
           'subcartera'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcart  AND tbcodigo1 = casubcartera_normativa),'No Especificado') ,  
           'libro'      = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro  AND tbcodigo1 = calibro) ,'No Especificado') ,  
     'GLosa_Libro' = @Glosa_Libro,  
           'Estado_Sinacofi'    = Estado_Sinacofi,  
           'FechaStarting'      = a.CaFechaStarting,              
           'FechaFijaStarting'  = a.CaFechaFijacionStarting,
	   'Modificada' = CASE (SELECT TOP 1 g.caestado from mfca_log g where a.canumoper = g.canumoper)
 				WHEN 'M' THEN 'MODIFICADA'
				WHEN 'A' THEN 'MODIFICADA'
				ELSE 'NO MODIFICADA' END,	
	        'operador'=  a.caoperador,
		'cacalvtadol'  = a.cacalvtadol,
		 'Relacionada_Spot' =  CASE WHEN (a.caoperrelaspot = '06' and a.numerospot <> 0) THEN 'SWAP SPOT'
		    ELSE '' END                 																		
   INTO     #tmpmfca  
   FROM     mfca          a,  
            view_cliente  b,  
            view_moneda   c,  
            view_producto d,  
            view_moneda   e  
 WHERE   (a.cacodigo  = b.clrut  AND a.cacodcli  = b.clcodigo )   
 AND a.cacodmon2      = c.mncodmon     
 AND a.cacodmon1      = e.mncodmon     
 AND d.id_sistema  = 'BFW'          
 AND d.codigo_producto = a.cacodpos1    
 AND (a.cacodsuc1  = @nentidad  OR @nentidad  = 0 )   
 AND (a.cacodpos1  = @ncodpos  OR @ncodpos      = 0 )   
 AND (a.cacodmon1  = @ncodmda  OR @ncodmda = 0 )   
 AND (a.cacodigo      = @nrutcli  OR @nrutcli      = 0 )   
 AND (a.canumoper  = @nnumoper  OR @nnumoper  = 0 )   
 AND a.cafecvcto      > @dfecproc  
 AND (cacartera_normativa  = @Id_CartNorm  OR @Id_CartNorm  = '' )  
 AND (casubcartera_normativa = @Id_SubCartNorm OR @Id_SubCartNorm = '' )  
 AND (calibro  = @Id_Libro  OR @Id_Libro  = '' )  
 AND (a.caoperador  = @operador  OR @operador  = 'T' )
 AND (a.catipoper   = @TipoOper  OR @TipoOper  = '' )
   AND NOT (a.cacodpos1=1 and var_moneda2<>0) --REQ. 5541    
 ORDER   
 BY a.canumoper  
  
   EXECUTE ( @cselect + @cdesde + @chasta + @corden )  
     
  
  
   SET NOCOUNT OFF  
   RETURN 0  
END

GO
