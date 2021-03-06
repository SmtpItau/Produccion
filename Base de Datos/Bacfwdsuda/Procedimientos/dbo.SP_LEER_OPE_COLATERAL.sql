USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPE_COLATERAL]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_LEER_OPE_COLATERAL 0,0,0,0,0
CREATE PROCEDURE [dbo].[SP_LEER_OPE_COLATERAL]
   (   @nentidad  FLOAT      
   ,   @ncodpos   FLOAT      
   ,   @ncodmda   FLOAT      
   ,   @nrutcli   FLOAT      
   ,   @numope    NUMERIC(9) = 0 
   )      
AS      
BEGIN      
   SET NOCOUNT ON      
      
   DECLARE @cnomprop   CHAR(40)      
   ,  @cdirprop   CHAR(40)      
   ,  @cfecpro    CHAR(10)      
   ,  @dfecproc   DATETIME      
   ,  @dfecvcto   DATETIME      
   ,  @corden     VARCHAR(100)      
   ,  @Glosa_Libro CHAR(50)      
      

   DECLARE @mdarrda varchar(1)      
      
   SELECT @cnomprop = ( SELECT rcnombre  FROM view_entidad )      
   ,      @cdirprop = ( SELECT rcdirecc  FROM view_entidad )      
   ,      @cfecpro  = ( SELECT CONVERT ( CHAR(10), acfecproc, 103 ) FROM mfac )     
     
   set @cnomprop = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)   


    SELECT  'Modificada' =   CASE (SELECT TOP 1 g.caestado from mfca_log g where a.monumoper = g.canumoper) WHEN 'M' THEN 'MODIFICADA'     
																											WHEN 'A' THEN 'ANULADA'    
																											ELSE 'NO MODIFICADA' END
,			'glosa'  = Case when var_moneda2 > 0 Then 'ARBITRAJE MONEDA MX-$' Else lTrim(rTrim(c.descripcion)) End
,			'tipoper' = a.motipoper                                
,			'nombre'  = b.clnombre                                 
,			'fecvcto' = CONVERT ( CHAR(10), a.mofecvcto, 103 )     
,			'nemo1'   = d.mnnemo
,			'mtomda1' = a.momtomon1
,			'tipcam'  =  CASE WHEN var_moneda2 = 0 THEN  case when a.mocodpos1 = 10 then round(convert(numeric(21,4),a.motipcam),4) else a.motipcam END ELSE a.moprecal END
,			'nemo2'   = CASE WHEN var_moneda2 = 0   THEN e.mnnemo ELSE 'CLP' END
,			'mtomda2' = CASE WHEN var_moneda2 = 0	THEN   CASE WHEN a.mocodpos1 = 10 THEN Round(CONVERT(NUMERIC(21, 0), a.momtomon2), 0)      
                                                               WHEN a.mocodpos1 = 2  THEN a.momtomon2      
                                                               ELSE a.momtomon2 END             
													ELSE f.camtomon1 * f.caprecal END
,			'codpos'  = CASE WHEN f.var_moneda2 > 0 THEN 12 ELSE a.mocodpos1 END
,			'numoper' = Case when var_moneda2 > 0   THEN var_moneda2 Else a.monumoper End
,			'nomprop' = @cnomprop          
,			'dirprop' = @cdirprop
,			'fecphoy' = @cfecpro
,			'estado'  = CASE a.moestado WHEN 'P' THEN 'PENDIENTE' WHEN 'R' THEN 'RECHAZADA' ELSE 'APROBADA' END
,			'lock'    = a.molock       
,			'fvcto'   = CONVERT( CHAR(10), a.mofecvcto, 103 )      
,			'fproc'   = CONVERT( CHAR(10),a.mofecha,103)           
,			'horaOp'  = a.mohora                                   
,			'dias'    = a.moplazo                                  
,			'horarep' = CONVERT(CHAR(8),GETDATE(),108)             
,			'Modal'   = a.motipmoda                                
,			'calce'   = CASE WHEN f.camtocalzado > 0 THEN 'SI' ELSE 'NO' END                                        
,			'prod'  = a.mocodpos1      
,			'OperacionMxClp' = var_moneda2
,			'mocalvtadol' = mocalvtadol   
,			'Colateral'	  = case when isnull(op.cod_colateral,'')='USD' then 'USD' else 'CLP' end 
	FROM    mfmo          a        
    INNER JOIN view_cliente  b ON b.clrut=a.mocodigo and b.clcodigo=a.mocodcli
    inner join view_producto c on c.id_sistema = 'BFW' and c.codigo_producto = a.mocodpos1
    inner join view_moneda   d on d.mncodmon=a.mocodmon1
    inner join view_moneda   e on e.mncodmon=a.mocodmon2      
    inner join mfca          f on f.canumoper=a.monumoper      
    left join BacParamSuda..OPE_COLATERAL  op on op.id_sistema='FWD' AND op.numero_operacion=a.monumoper
    left join BacParamSuda..CLI_COLATERAL  cl on cl.Rut_Cliente=a.mocodigo and cl.Cod_Cliente=a.mocodcli
   WHERE  (a.mocodsuc1       = @nentidad  OR @nentidad = 0)        
   AND    (a.mocodpos1       = @ncodpos   OR @ncodpos = 0)      
   AND    (a.mocodmon1       = @ncodmda   OR a.mocodmon2 = @ncodmda OR @ncodmda = 0)      
   AND    (a.mocodigo        = @nrutcli   OR @nrutcli = 0)      
   AND    (a.monumoper      = @numope  OR  @numope = 0 ) -- REQ. 3141 CASS      
   AND NOT (a.mocodpos1=1 and var_moneda2<>0) --REQ. 5541      
   ORDER  BY a.monumoper      

      
   SET NOCOUNT OFF      
      
      
--      select * from BacParamSuda..OPE_COLATERAL
--      select * from BacParamSuda..CLI_COLATERAL
      
END
GO
