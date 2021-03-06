USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEINFARB]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- sp_leeinfarb 2 , '20050330' , '1111' , '1554' , '1552'

CREATE PROCEDURE [dbo].[SP_LEEINFARB]	(	@tipo			FLOAT	
					,	@dfecdesde		CHAR(08)
					,	@Cat_CartNorm		CHAR(06)
					,	@Cat_SubCartNorm	CHAR(06)
					,	@Cat_Libro		CHAR(06)
					)
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   CHAR(8)
   DECLARE @ENCONTRO1  CHAR (  1 )
   DECLARE @ENCONTRO2  CHAR (  1 )

   /*=======================================================================*/
   /*=======================================================================*/
   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD),
               @cdirprop = acdirprop,
               @dfecproc = CONVERT( CHAR(8) , acfecproc, 112), 
               @cfecproc = CONVERT( CHAR(10), acfecproc, 103 ) 
          FROM MFAC
 SELECT @encontro1 = 'S' 
 SELECT @encontro2 = 'S'
   /*=======================================================================*/
   /*=======================================================================*/
   IF @dfecdesde = @dfecproc
   BEGIN               
   IF NOT EXISTS( SELECT 1 FROM MFMO  a ,
				VIEW_CLIENTE c ,
				VIEW_MONEDA f ,
				VIEW_MONEDA g ,
				VIEW_MONEDA h       
			WHERE	a.mocodpos1  = @tipo        AND
				( a.mocodigo   = c.clrut    AND
				a.mocodcli   = c.clcodigo ) AND
				a.momdausd   = f.mncodmon   AND   
				a.mocodmon1  = g.mncodmon   AND
				a.mocodmon2  = h.mncodmon     )
	
		  SELECT @ENCONTRO1 = 'N'  
   ELSE
            SELECT  'Numero Contrato'  = a.monumoper   , 
                    'Rut Cliente'      = c.clrut       ,
                    'DV'               = c.cldv        ,          
                    'Nombre Cliente'   = c.clnombre    ,
                    'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103),
                    'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103),
                    'Dias'             = a.moplazo     ,                
                    'M/X'              = ISNULL(g.mnnemo,'N/D')   ,
                    'Monto M/X'        = a.momtomon1   ,
                    'Paridad Futuro'   = a.motipcam    ,
                    'CNV'              = ISNULL(h.mnnemo,'N/D')   ,
                    'Monto Final'      = a.momtomon2   ,  
                    'Paridad Spot'     = a.moparmon1   ,
                    'PRM'             = ISNULL(f.mnnemo,'N/D')   ,
                    'T/CInicial compra'= a.mopremon1,
                    'Mod.Cumplimiento' = a.motipmoda   ,
                    'Pago M/X'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomx )),
                    'Pago M/N'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomn )),
                    'Nombre Empresa'   = @cnomprop,
                    'Tipo de Operacion'= a.motipoper ,
                    'Direccion'        = @cdirprop ,
                    'Fecha de Proceso' = @cfecproc        ,
                    'Entidad'          = @cfecproc        ,
                    'Hora'      = CONVERT(CHAR(08),GETDATE(),108)  ,
                    'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
	                'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
        	        'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
	                'Libro'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro  AND tbcodigo1 = molibro),'No Especificado') ,
					'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
            FROM    MFMO  a ,
                    VIEW_CLIENTE c ,
                    VIEW_MONEDA f ,
                    VIEW_MONEDA g ,
                    VIEW_MONEDA h       
    WHERE          a.mocodpos1  = @tipo         AND
        ( a.mocodigo   = c.clrut      AND
                    a.mocodcli   = c.clcodigo )  AND
                    a.momdausd   = f.mncodmon   AND   
                    a.mocodmon1  = g.mncodmon   AND
                    a.mocodmon2  = h.mncodmon   --AND
 
      END
      ELSE     
      BEGIN   
  IF NOT EXISTS( SELECT 1 
             FROM    MFMOH a,
                     VIEW_CLIENTE c,
            VIEW_MONEDA  f,
                     VIEW_MONEDA  g,
                     VIEW_MONEDA  h 
             WHERE   a.mocodpos1  = @tipo        AND
         (a.mocodigo   = c.clrut      AND
                     a.mocodcli   = c.clcodigo ) AND
                     a.momdausd   = f.mncodmon  AND   
                     a.mocodmon1  = g.mncodmon  AND
                     a.mocodmon2  = h.mncodmon  AND
        a.mofecha    = @dfecdesde
    )           
   SELECT @ENCONTRO2 = 'N'
  ELSE
            SELECT  'Numero Contrato'  = a.monumoper   , 
                    'Rut Cliente'      = c.clrut       ,
                    'DV'               = c.cldv        ,          
                    'Nombre Cliente'   = c.clnombre    ,
                    'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103),
                    'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103),
                    'Dias'             = a.moplazo     ,  
                    'M/X'              = ISNULL(g.mnnemo,'N/D')   ,
                    'Monto M/X'        = a.momtomon1   ,
                    'Paridad Futuro'   = a.motipcam    ,
                    'CNV'              = ISNULL(h.mnnemo,'N/D')   ,
                    'Monto Final'      = a.momtomon2   ,  
                    'Paridad Spot'     = a.moparmon1   ,  
                    'PRM'              = ISNULL(f.mnnemo,'N/D')   ,
                    'T/CInicial compra'= a.mopremon1,  
                    'Mod.Cumplimiento' = a.motipmoda   ,
                    'Pago M/X'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomx )),
                    'Pago M/N'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomn )),
                    'Nombre Empresa'   = @cnomprop,
                    'Tipo de Operacion'= a.motipoper ,
                    'Direccion'        = @cdirprop ,
                    'Fecha de Proceso' = @cfecproc        ,
                    'Entidad'          = @cnomprop        ,
                    'Hora'      = CONVERT(CHAR(08),GETDATE(),108)           ,
                    'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
		            'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
		            'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
		            'Libro'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro    AND tbcodigo1 = molibro),'No Especificado') ,
					'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
            FROM    MFMOH a,
                    VIEW_CLIENTE c,
                    VIEW_MONEDA  f,
                    VIEW_MONEDA  g,
                    VIEW_MONEDA  h 
            WHERE   a.mocodpos1  = @tipo        AND
        (a.mocodigo   = c.clrut      AND
                    a.mocodcli   = c.clcodigo ) AND
                    a.momdausd   = f.mncodmon  AND   
                    a.mocodmon1  = g.mncodmon  AND
                    a.mocodmon2  = h.mncodmon  AND
       a.mofecha    = @dfecdesde
   END
   SET NOCOUNT OFF
   IF @encontro1 = 'N' OR @encontro2 = 'N'
           SELECT  'Numero Contrato'   = 0, 
                   'Rut Cliente'       = 0,
                   'DV'                = '',          
                   'Nombre Cliente'    = '',
				   'Fecha Inicio'      = '',
                   'Fecha Termino'     = '',
                   'Dias'              = 0,  
                   'M/X'               = '',
                   'Monto M/X'         = 0,
                   'Paridad Futuro'    = 0,
                   'CNV'               = '',
                   'Monto Final'       = 0,  
                   'Paridad Spot'      = 0,  
                   'PRM'               = '',
                   'T/CInicial compra' = 0,  
                   'Mod.Cumplimiento'  = '',
                   'Pago M/X'          = '',
                   'Pago M/N'          = '',
                   'Nombre Empresa'    = @cnomprop,
                   'Tipo de Operacion' = '0',
                   'Direccion'         = @cdirprop ,
                   'Fecha de Proceso'  = @cfecproc        ,
                   'Entidad'           = @cnomprop        ,
                   'Hora'              = CONVERT(CHAR(08),GETDATE(),108)           ,
                   'Fecha_Cons'        = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
				   'cartnorm'		   = '',
		           'subcart'		   = '',
		           'Libro'		       = '',
				   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

END



GO
