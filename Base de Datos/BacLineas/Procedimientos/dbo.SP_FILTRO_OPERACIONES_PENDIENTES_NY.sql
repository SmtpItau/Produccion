USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FILTRO_OPERACIONES_PENDIENTES_NY]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--SP_FILTRO_OPERACIONES_PENDIENTES_NY '20141016', 'RFUENTES', ' ', ' ', '', '', ''

CREATE  PROCEDURE [dbo].[SP_FILTRO_OPERACIONES_PENDIENTES_NY]
   (   @cFecha  DATETIME      
   ,   @Usuario CHAR(15)      
   ,   @Modulo   CHAR(3)      
   ,   @T_Operacion    CHAR(255)      
   ,   @Operador       CHAR(10)      
   ,   @Moneda    CHAR(3)      
   ,   @Digitador	CHAR(15)=''	--- Nuevo
   )      
AS      
BEGIN      
   SET NOCOUNT ON      
      
   DECLARE @Fecha_Proceso CHAR(08)      
      
   CREATE TABLE #TEMP      
	( 
	Sistema  CHAR(5),    
  Glo_Producto CHAR (40) ,      
  numoper  NUMERIC(10) ,      
  cliente  CHAR(80) ,      
  moneda  CHAR(05) ,      
  Monto  NUMERIC(19,4) ,      
  Operador CHAR(15) ,      
  ErrorG          CHAR(02) ,      
        )      
      
    CREATE TABLE #TEMP2      
	( 
	Sistema  		CHAR (5),    
  Tipoper  CHAR (80) ,       
  Glo_Producto CHAR (40) ,      
  numoper  NUMERIC(10) ,      
  cliente  CHAR(80) ,      
  moneda  CHAR(05) ,      
  Monto  NUMERIC(19,4) ,      
  Operador CHAR(15) ,      
  ErrorG          CHAR(02) ,      
  Codprod  CHAR(20) ,      
  RutCart  NUMERIC(09) ,      
  FirmaOpe        CHAR(15) ,         
  FirmaSup1       CHAR(15) ,      
  FirmaSup2       CHAR(15) ,      
  Producto        VARCHAR(15)     ,      
  TipoCliente     INTEGER,
  Digitador	CHAR(15)
        )      
      
   EXECUTE dbo.Sp_Importacion_Opciones @Usuario       
      
   INSERT #TEMP EXECUTE Sp_Lineas_LeerOpPendientes_NY  @cFecha ,@Usuario           
      
   INSERT INTO #TEMP2          
    SELECT Sistema      
          ,''      
   ,Glo_Producto      
   ,numoper          
          ,cliente      
   ,moneda      
   ,Monto                       
   ,Operador      
          ,ErrorG         
   ,''       
   ,0       
          ,''      
          ,''       
          ,''      
          , ''      
          , 0      
	  ,''
    FROM  #TEMP      
      
------------------------------------------Spot-------------------------------------------------------      
     --UPDATE #TEMP2        
     --SET  Tipoper = descripcion      
     --,Digitador = moDigitador
     --,Glo_Producto = case when MOTIPMER = 'PTAS' then descripcion + ' PUNTA'      
     --when MOTIPMER = 'EMPR' then descripcion + ' EMPRESA'      
     --when MOTIPMER = 'ARBI' then descripcion + ' ARBITRAJE'      
     --else descripcion + MOTIPMER end       
     --,Codprod = motipmer            
     --, Producto    = motipmer      
     --, TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = morutcli and clcodigo = mocodcli)      
     --FROM VIEW_MEMO                          with(nolock),      
     --Bacparamsuda..OPERACION_PRODUCTO a with(nolock)      
     --WHERE monumope = numoper and       
     --MOTIPOPE = a.codigo and      
     --Sistema  = a.Id_Sistema      
------------------------------------------Spot-------------------------------------------------------      
      
      
------------------------------------------Forward-------------------------------------------------------       
     /* 
     UPDATE #TEMP2    
 SET  Tipoper = b.descripcion      
     , Glo_Producto = CASE WHEN a.moNroOpeMxClp = 0 Then b.descripcion + ' ' + c.descripcion ELSE b.descripcion + ' ' +Glo_Producto END      
     ,Codprod = convert(char(10),a.mocodpos1)      
     , Producto    = a.mocodpos1      
     , TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = mocodigo and clcodigo = mocodcli)      
     FROM VIEW_MFMO a   with(nolock),      
     Bacparamsuda..OPERACION_PRODUCTO b  with(nolock),      
     Bacparamsuda..PRODUCTO c    with(nolock)      
     WHERE a.monumoper = numoper and       
     a.motipoper = b.codigo  and       
     convert (char(05),a.mocodpos1) = c.codigo_producto and      
     Sistema  = 'BFW' and       
     b.id_sistema= 'BFW'    
     */  

  UPDATE #TEMP2    
     SET Tipoper      = op.descripcion    
     , Digitador    = ca.moDigitador 
     , Glo_Producto = CASE WHEN ca.monroopemxclp > 0 AND ca.mocodpos1 <> 1 THEN op.descripcion + ' ARBITRAJE MX-CLP'
          WHEN ca.monroopemxclp > 0 AND ca.mocodpos1 = 1 THEN op.descripcion + ' ARBITRAJE MX-CLP (SC)'
     ELSE CASE WHEN ca.mocodpos1 = 1 THEN glo_producto ELSE op.descripcion + ' ' + glo_producto  END    
     END    
     ,   Codprod      = CONVERT(CHAR(10), ca.mocodpos1 )    
     ,   Producto     = ca.mocodpos1    
     ,   TipoCliente  = cl.cltipcli    
    FROM BacFwdNY.dbo.MFMO        ca    
         INNER JOIN BacParamSuda.dbo.CLIENTE            cl ON cl.clrut      = ca.mocodigo and cl.clcodigo        = ca.mocodcli    
         INNER JOIN BacParamSuda.dbo.PRODUCTO           pr ON pr.id_sistema = 'BFW'       and pr.codigo_producto = ca.mocodpos1    
         INNER JOIN BacParamSuda.dbo.OPERACION_PRODUCTO op ON op.id_sistema = 'BFW'       and op.codigo          = ca.motipoper    
   WHERE ca.monumoper   = numoper     
              
------------------------------------------Forward-------------------------------------------------------      
      
      
------------------------------------------Renta Fija-------------------------------------------------------      
      
 --UPDATE #TEMP2        
 --SET  Tipoper = a.descripcion --Case when motipoper ='IB' then substring(a.descripcion,1,14) else a.descripcion end      
 --    ,Digitador    = moDigitador
 --    ,Glo_Producto =a.descripcion      
 --    ,Codprod = motipoper      
 --    ,RutCart = morutcart      
 --    , Producto    = (case when motipoper ='IB' then moinstser else motipoper end)      
 --    , TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = morutcli and clcodigo = mocodcli)      
 --FROM   view_mdmo with(nolock) ,      
 --       Bacparamsuda..OPERACION_PRODUCTO   a with(nolock)      
 --WHERE  monumoper =numoper and       
 --       a.codigo = (case when motipoper ='IB' then moinstser else motipoper end)   and      
 --          Sistema  = a.id_sistema      
------------------------------------------Renta Fija-------------------------------------------------------      
      
------------------------------------------Swap-------------------------------------------------------      
        UPDATE #TEMP2        
 SET    Tipoper = case when tipo_swap = 1 then 'ST'      
         when tipo_swap = 2 then 'SM'      
                              when tipo_swap = 3 then 'FR'      
                              when tipo_swap = 4 then 'SP'      
           end      
     ,  Digitador = moDigitador	
     , Producto    = case when tipo_swap = 1 then 'ST'      
            when tipo_swap = 2 then 'SM'      
            when tipo_swap = 3 then 'FR'      
            when tipo_swap = 4 then 'SP'      
            end      
     , TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = rut_cliente and clcodigo = codigo_cliente)      
 FROM   view_movdiario_NY   with(nolock)      
 WHERE  numero_operacion = numoper       
 and    Sistema          = 'PCS'      


      
               
        UPDATE #TEMP2        
 SET   Tipoper = a.descripcion      
   ,Glo_Producto =a.descripcion + ' ' + b.descripcion      
             ,Codprod = case when  tipo_swap = 1 then 'TASA'      
        when  tipo_swap = 2 then 'MONEDA'      
                             when  tipo_swap = 3 then 'FRA'      
                             when  tipo_swap = 4 then 'PROMEDIO CAMARA'      
                        END        
        FROM   VIEW_MOVDIARIO_NY with(nolock),       
        Bacparamsuda..OPERACION_PRODUCTO   a  with(nolock),      
        Bacparamsuda..PRODUCTO b with(nolock)      
 WHERE  numero_operacion =numoper  and      
           Sistema  = a.id_sistema and       
               tipoper  = b.codigo_producto      
      
------------------------------------------Swap-------------------------------------------------------        
      
       
------------------------------------------Bonos-------------------------------------------------------        
 UPDATE #TEMP2        
 SET  Tipoper = b.descripcion      
     ,Glo_Producto =c.descripcion      
     ,Digitador    = a.moDigitador
     ,Codprod = a.motipoper      
     , Producto    = a.motipoper      
     , TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = morutcli and clcodigo = mocodcli)      
     FROM       
     VIEW_text_mvt_dri_NY a   with(nolock),      
     Bacparamsuda..OPERACION_PRODUCTO b with(nolock) ,        
     Bacparamsuda..PRODUCTO c with(nolock)      
     WHERE a.monumoper = numoper and       
     a.motipoper = b.codigo  and       
     a.motipoper = substring(c.codigo_producto,1,2) and      
     Sistema  = 'BEX' and       
     b.id_sistema= Sistema       
     
 
------------------------------------------Bonos-------------------------------------------------------        
      
------------------------------------------Opciones-------------------------------------------------------       
      
-- UPDATE #TEMP2        
-- SET  Tipoper = b.descripcion      
--     ,Glo_Producto = case when CodEstructura in(8) then 'FORWARD AMERICANO' else b.descripcion + ' ' + c.descripcion END      
----     ,Glo_Producto = b.descripcion + ' ' + c.descripcion    
--          ,Codprod = convert(char(10),'OPT')      
----  22 Sept. 2009  Por tema Perfiles de Acceso Lineas para Opciones.      
--            ,Producto    = convert(Varchar(15),'OPT')           
--            ,TipoCliente = (select cltipcli FROM BacParamSuda.dbo.CLIENTE WHERE clrut = a.RutCliente and clcodigo = a.Codigo)      
      
--        FROM       
--      DBO.TAB_Importada_MoEncContrato a   with(nolock),      
--           Bacparamsuda..OPERACION_PRODUCTO b  with(nolock),      
--      Bacparamsuda..PRODUCTO c    with(nolock)      
-- WHERE a.NumContrato = numoper and       
--       a.CVEstructura = b.codigo  and       
--       convert (char(05),'OPT') = c.codigo_producto and      
--          Sistema  = 'OPT' and       
--       b.id_sistema= 'OPT'       


------------------------------------------Opciones-------------------------------------------------------      
      
    UPDATE #TEMP2        
  SET  FirmaOpe  = Operador_Origen --- CASE WHEN  Firma1=Operador_Origen THEN Operador_Origen ELSE Operador_Origen END      
            , FirmaSup1 = CASE WHEN  Firma1<>'' OR Firma1<>'FALTA'  then  Firma1 ELSE 'FALTA' END     
            , FirmaSup2 = CASE WHEN  Firma2=''     THEN 'FALTA'       
                               WHEN  Firma1=Firma2 THEN 'FALTA'           
                               ELSE  Firma2 END       
                    
         FROM  DETALLE_APROBACIONES   with(nolock)      -- select * from baclineas..DETALLE_APROBACIONES
         WHERE   @cFecha = Fecha_Operacion AND			--- se agrega la fecha 31/07/2014
		 case when Id_Sistema = 'BTR' then Sistema else Id_Sistema end = Sistema     --  24 Sept. 2009  Por tema limites Operador.      
         --  10967 21 Oct. 2011        
         AND     Numero_Operacion = numoper      
      
         DELETE FROM #TEMP2      
               WHERE SISTEMA NOT IN(SELECT DISTINCT sistema FROM BacLineas.dbo.PERFIL_USUARIO_LINEAS WHERE usuario = @Usuario AND activado = 1)      
       
         SELECT tmp.* FROM #TEMP2                                         tmp    
                       INNER JOIN BacLineas.dbo.PERFIL_USUARIO_LINEAS usr ON usr.Usuario      = @Usuario      
                                                                         and usr.sistema      = tmp.sistema      
                                                                         and usr.Producto     = CASE WHEN tmp.sistema = 'BEX' AND tmp.Producto = 'CP' THEN 'CPX'      
                                                                                                     WHEN tmp.sistema = 'BEX' AND tmp.Producto = 'VP' THEN 'VPX'      
                                       ELSE tmp.Producto 
                                                                                                END      
                                       and usr.Tipo_Cliente = tmp.TipoCliente      
                   and usr.Activado     = 1      
         WHERE (tmp.SISTEMA  = @Modulo      OR @Modulo      = '')      
         AND   (tmp.TIPOPER  = @T_Operacion OR @T_Operacion = '')      
         AND   (tmp.OPERADOR = @Operador    OR @Operador    = '')      
         AND   (tmp.MONEDA   = @Moneda      OR @Moneda      = '')      
 	 AND   (tmp.DIGITADOR= @Digitador   OR @Digitador   = '')	
         ORDER BY tmp.Sistema, numoper      
      
   SET NOCOUNT OFF      
END


GO
