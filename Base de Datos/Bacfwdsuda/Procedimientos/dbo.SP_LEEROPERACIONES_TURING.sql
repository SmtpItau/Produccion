USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEROPERACIONES_TURING]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEEROPERACIONES_TURING]     
(
	@norden           FLOAT,    
    @nentidad         FLOAT,
    @ncodpos          FLOAT,    
    @ncodmda          FLOAT,    
    @nrutcli          FLOAT,    
    @cfecvcto         CHAR(08)    = '',    
    @catcartnorm      CHAR(06)    = '',    
    @catsubcart       CHAR(06)    = '',    
    @catlibro         CHAR(06)    = '',     
    @usuario          VARCHAR(20) = '',    --PARA FILTRO POR USUARIO
    @TipoOperacion    CHAR(1)     = '',  -- PARA FILTRO SI ES COMPRA O VENTA     
    @Id_CartNorm      CHAR(06)    = '',    
    @Id_SubCartNorm   CHAR(06)    = '',    
    @Id_Libro         CHAR(06)    = '',    
    @numope           NUMERIC(9)  = 0 -- REQ. 3141 CASS    
)
    
AS 
   
BEGIN    

	SET NOCOUNT ON    
    
    DECLARE @cnomprop    CHAR(40),    
	        @cdirprop    CHAR(40),    
	        @cfecpro     CHAR(10),    
	        @dfecproc    DATETIME,    
	        @dfecvcto    DATETIME,    
	        @corden      VARCHAR(100),    
	        @Glosa_Libro CHAR(50)    
    
    
 
	IF  @id_libro = '' 
		BEGIN    
			SELECT @Glosa_libro = '< TODOS >'     
		END 	    
	ELSE 
		BEGIN    
			SELECT @Glosa_libro = tbglosa    
			  FROM VIEW_TABLA_GENERAL_DETALLE    
             WHERE tbcateg   = @CatLibro     
               AND tbcodigo1 = @Id_Libro    
		END    
    
	
	SELECT @corden = 'SELECT * FROM #tmpmfmo '    
    
	
	IF @cfecvcto <> ''     
		BEGIN    
			SELECT @corden = @corden + ' WHERE fvcto = '' + @cfecvcto + '' '    
		END
		    
	IF @norden = 0     
		BEGIN    
			SELECT @corden = @corden + 'ORDER BY numoper'    
		END 
	ELSE     
		IF @norden = 1     
			BEGIN    
				SELECT @corden = @corden + 'ORDER BY nombre'    
			END 
		ELSE     
			IF @norden = 2     
				BEGIN    
					SELECT @corden = @corden + 'ORDER BY nemo2'    
				END ELSE     
   IF @norden = 3     
   BEGIN    
      SELECT @corden = @corden + 'ORDER BY fproc'    
   END ELSE     
   IF @norden = 4     
   BEGIN    
      SELECT @corden = @corden + 'ORDER BY fvcto'    
   END    
   DECLARE @mdarrda varchar(1)    
    


   SELECT @cnomprop = ( SELECT rcnombre  FROM view_entidad )    
   ,      @cdirprop = ( SELECT rcdirecc  FROM view_entidad )    
   ,      @cfecpro  = ( SELECT CONVERT ( CHAR(10), acfecproc, 103 ) FROM mfac )    
    
    SELECT 'Modificada' = CASE (SELECT TOP 1 g.caestado from mfca_log g where a.monumoper = g.canumoper) WHEN 'M' THEN 'MODIFICADA'   
                                                                                                         WHEN 'A' THEN 'ANULADA'  
                                                                                                  ELSE 'NO MODIFICADA' END,  
           'glosa'  = Case when var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' when mocalvtadol = 16 then 'FORWARD A OBSERVADO' WHEN mocalvtadol = 14 then 'FORWARD A STARTING'Else lTrim(rTrim(c.descripcion)) End,    
           'tipoper' = a.motipoper                                ,    
           'nombre'  = b.clnombre                                 ,    
           'fecvcto' = CONVERT ( CHAR(10), a.mofecvcto, 103 )     ,    
           'nemo1'   = d.mnnemo                                   ,                                                       --> MonInstruemtno    
           'mtomda1' = a.momtomon1                                ,                                                       --> Nominales    
           'tipcam'  =  CASE WHEN var_moneda2 = 0 THEN  case when a.mocodpos1 = 10 then round(convert(numeric(21,4),a.motipcam),4) else a.motipcam END    
                             ELSE a.moprecal    
                        END,    
           'nemo2'   = CASE WHEN var_moneda2 = 0   THEN e.mnnemo ELSE 'CLP' END, --> MonPago    
           'mtomda2' = CASE WHEN var_moneda2 = 0  THEN   CASE WHEN a.mocodpos1 = 10 THEN Round(CONVERT(NUMERIC(21, 0), a.momtomon2), 0)    
                                                              WHEN a.mocodpos1 = 2  THEN a.momtomon2    
                                                              ELSE a.momtomon2    
                                                         END           
                            ELSE f.camtomon1 * f.caprecal    
                       END,    
    
           'codpos'  = CASE WHEN f.var_moneda2 > 0 THEN 12 ELSE a.mocodpos1 END,    
           'numoper' = Case when var_moneda2 > 0   THEN var_moneda2 Else a.monumoper End,    
           'nomprop' = @cnomprop          ,    
           'dirprop' = @cdirprop                                  ,    
           'fecphoy' = @cfecpro                                   ,    
           'estado'  = CASE a.moestado WHEN 'P' THEN 'PENDIENTE' WHEN 'R' THEN 'RECHAZADA' ELSE 'APROBADA' END,  
           'lock'    = a.molock       ,    
           'fvcto'   = CONVERT( CHAR(10), a.mofecvcto, 103 )      ,    
           'fproc'   = CONVERT( CHAR(10),a.mofecha,103)           ,    
           'horaOp'  = a.mohora                                   ,    
           'dias'    = a.moplazo                                  ,    
           'horarep' = CONVERT(CHAR(8),GETDATE(),108)             ,    
           'Modal'   = a.motipmoda                                ,    
           'calce'   = CASE WHEN f.camtocalzado > 0 THEN 'SI'     
                            ELSE 'NO'     
                       END                                        ,    
           'prod'  = a.mocodpos1      ,    
           'EstadoGraba'= '  '                                  ,    
           'cartnorm' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @catcartnorm AND tbcodigo1 = mocartera_normativa),'No Especificado') ,    
           'subcart' = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @catsubcart AND tbcodigo1 = mosubcartera_normativa ),'No Especificado'),    
           'Libro'  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @catlibro  AND tbcodigo1 = molibro),'No Especificado') , --28    
           'Glosa_Libro' = @Glosa_Libro, --29    
           'Estado_Sinacofi'= SUBSTRING(f.Estado_sinacofi,1,2),    
           'Operador'  = CASE WHEN a.mocodpos1 IN (1,2,3,7,10,11,12,14) THEN mooperador ELSE '' END,    
           'Digitador' = CASE WHEN a.mocodpos1 IN ( 1, 2, 3, 7, 10, 11, 12 ) THEN modigitador ELSE '' END,    
           'OperacionMxClp' = var_moneda2,    
		   'Relacionada_Spot' =  CASE WHEN (a.mooperrelaspot = '06' and a.numerospot <> 0) THEN 'SWAP SPOT'
		    ELSE '' END


   INTO    #tmpmfmo    
   FROM    mfmo          a ,     
           view_cliente  b ,    
           view_producto c ,    
           view_moneda   d ,    
           view_moneda   e ,    
           mfca          f    
   WHERE   a.monumoper       = f.canumoper       
   AND     a.mocodigo        = b.clrut           
   AND     a.mocodcli        = b.clcodigo        
   AND     c.id_sistema      = 'BFW'             
   AND     c.codigo_producto = a.mocodpos1       
   AND     a.mocodmon1       = d.mncodmon        
   AND     a.mocodmon2       = e.mncodmon        
   AND    (a.mocodsuc1       = @nentidad  OR @nentidad = 0)      
   AND    (a.mocodpos1       = @ncodpos   OR @ncodpos = 0)    
   AND    (a.mocodmon1       = @ncodmda   OR @ncodmda = 0) -- PRD21645    
   AND    (a.mocodigo        = @nrutcli   OR @nrutcli = 0)    
   AND    (a.mocartera_normativa = @Id_CartNorm  OR @Id_CartNorm  = '')   
   AND    (a.mooperador = @usuario  OR @usuario  = '') -- FILTRO POR USUARIO
   AND    (a.motipoper  = @TipoOperacion  OR @TipoOperacion  = '') -- FILTRO POR TIPO DE OPERACION         
   AND    (a.mosubcartera_normativa = @Id_SubCartNorm OR @Id_SubCartNorm = '')    
   AND    (a.molibro   = @id_libro  OR @id_libro  = '')    
   AND    (a.monumoper      = @numope  OR  @numope = 0 ) -- REQ. 3141 CASS    
   AND NOT (a.mocodpos1=1 and var_moneda2<>0) --REQ. 5541    
   ORDER  BY a.monumoper    
    
 UPDATE  #tmpmfmo    
 SET EstadoGraba = (CASE WHEN HoraOp BETWEEN DESDE AND HASTA THEN 'SI' ELSE 'NO' END)     
 FROM #tmpmfmo    
 Inner Join mdgestion..hora_producto    
 ON    sistema   = 'BFW'    
        AND   producto = codpos    
    
 SELECT * FROM #tmpmfmo order by  numoper    
    
   SET NOCOUNT OFF    
    
   RETURN 0    
END 
GO
