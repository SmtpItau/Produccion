USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ImportaDataBacParamSuda]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_ImportaDataBacParamSuda]  
AS  
BEGIN  
-- Sp_ImportaDataBacParamSuda  
   SET NOCOUNT ON  
   -- MAP 13 Octubre 2009  
   -- Problema: evitar esta carga: lnkBac.BacParamSuda.dbo.BacParamSudaTBL_CLASIFICACION_CARTERA  
   -- MAP 05 Nov. 2009 Desvio a vista por alter a tabla cliente  
  
   declare @Control_Error numeric(3)  
  
   select @Control_Error = 0  
  
   -- Importacion de Feriados  
   truncate table BacParamSudaFERIADO  
   INSERT INTO BacParamSudaFERIADO  
   select * from lnkBac.BacParamSuda.dbo.FERIADO  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando FERIADO')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   declare @dAcfecproc datetime  
   declare @dAcfecante datetime  
   select  @dAcfecante = fechaant                      
         , @dAcfecproc = fechaproc from opcionesgeneral  
   -- Importacion de VALOR_MONEDA_CONTABLE  
   --truncate table BacParamSudaVALOR_MONEDA  
   declare @HayValorMoneda int  
   select  @HayValorMoneda = 0  
   select  @HayValorMoneda = 1 FROM   LnkBac.BacParamSuda.dbo.VALOR_MONEDA with (nolock)  
   WHERE (   vmfecha = @dAcfecproc    
         )  
   if @HayValorMoneda = 1 begin  
      delete BacParamSudaVALOR_MONEDA where vmfecha = @dAcfecproc  
      insert into   BacParamSudaVALOR_MONEDA   
      select *  
      FROM   LnkBac.BacParamSuda.dbo.VALOR_MONEDA with (nolock)  
      WHERE (   vmfecha = @dAcfecproc    
         )  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT @Control_Error = 1  
         INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando VALOR_MONEDA')  
         GOTO   FIN_PROCEDIMIENTO  
      END  
   end  
   else  
   begin  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR Operativo: Falta Ingreso VALOR_MONEDA.')  
      GOTO   FIN_PROCEDIMIENTO  
   end  
  
   declare @HayValorMonedaContable int  
   select  @HayValorMonedaContable = 0  
   select @HayValorMonedaContable = 1 FROM LnkBac.BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WITH (NOLOCK)  
   WHERE (    Fecha         = @dAcfecproc -- En producción poner '20090619' -- Comienzo de certificación    
          )  
  
   if @HayValorMonedaContable = 1 begin  
      --truncate table BacParamSudaVALOR_MONEDA_CONTABLE  
      delete BacParamSudaVALOR_MONEDA_CONTABLE where Fecha         = @dAcfecproc  
      insert into BacParamSudaVALOR_MONEDA_CONTABLE  
      SELECT *  
      FROM   LnkBac.BacParamSuda.dbo.VALOR_MONEDA_CONTABLE WITH (NOLOCK)  
      WHERE (    Fecha         = @dAcfecproc -- En producción poner '20090619' -- Comienzo de certificación    
          )  
      IF @@ERROR <> 0  
      BEGIN  
         SELECT @Control_Error = 1  
         INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando VALOR_MONEDA_CONTABLE.')  
         -- MAP GOTO   FIN_PROCEDIMIENTO  
      END  
   end  
   else  
   begin  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR Operativo: Falta Ingreso Valor Moneda Contable ')   
      -- MAP GOTO   FIN_PROCEDIMIENTO  
   end  
  
  
   Declare @Rut numeric(9)  
   select @Rut = Rut From OpcionesGeneral  
  
   truncate table BacParamSudaCLIENTE  
  
   insert into BacParamSudaCLIENTE  -- select distinct * from BacParamSudaCLIENTE  
   SELECT        Clrut  
      ,Cldv  
      ,Clcodigo  
      ,Clnombre  
      ,Clgeneric  
      ,Cldirecc  
      ,Clcomuna  
      ,Clregion  
      ,Cltipcli  
      ,Clfecingr  
      ,Clctacte  
      ,Clfono  
      ,Clfax  
      ,Clapelpa  
      ,Clapelma  
      ,Clnomb1  
      ,Clnomb2  
      ,Clapoderado  
      ,Clciudad  
      ,Clmercado  
      ,Clgrupo  
      ,Clpais  
      ,Clcalidadjuridica  
      ,Cltipoml  
      ,Cltipomx  
      ,Clbanca  
      ,Clrelac  
      ,Clnumero  
      ,Clcomex  
,Clchips  
      ,Claba  
      ,Clswift  
      ,Clnfm  
      ,Clfmutuo  
      ,Clfeculti  
      ,Clejecuti  
      ,Clentidad  
      ,Clgraba  
      ,Clcompint  
      ,Clcalle  
      ,Clctausd  
      ,Clcaljur  
      ,Clnemo  
      ,Climplic  
     ,Clopcion  
      ,Clcalidad  
      ,Cltipode  
      ,Clrelacion  
      ,Clcatego  
  ,Clsector  
      ,Clestado  
      ,ISNULL(Clclsbif,'')
      ,Clfesbif  
      ,Clclbco  
      ,Clfecbco  
      ,Clactivida  
      ,Cltelef  
      ,Usuario  
      ,Cltipemp  
      ,Relbco  
      ,Fecact  
      ,Cltipsis  
      ,Poder  
      ,Firma  
      ,Feca85  
      ,Relcia  
      ,Relcor  
      ,Infosoc  
      ,Art85  
      ,Dec85  
      ,Clconres  
      ,Clcodban  
      ,Cod_Inst  
      ,Rut_Grupo  
      ,Clcodfox  
      ,Clcrf  
      ,Clerf  
      ,Clvctolineas  
      ,Clvalidalinea  
      ,Oficinas  
      ,Clclaries  
      ,Codigo_Otc  
      ,Bloqueado  
      ,CLFECCONDGRL  
      ,clcosto  
      ,mxcontab  
      ,clrutcliexterno  
      ,cldvcliexterno  
      ,clBrokers  
      ,RutBancoReceptor  
      ,CodBancoReceptor  
      ,clCondicionesGenerales  
      ,clFechaFirma_cond  
      ,fecha_escritura  
      ,nombre_notaria  
      ,ClCompBilateral  
  
   FROM   LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc WITH (NOLOCK)  
   WHERE /* (    ClRut  in ( select MoRutCliente from MoEncContrato union Select MoRutCliente from MoHisEncContrato )   
          ) */   
        (    NUEVO_CCG_FIRMADO = 'S' and FECHA_FIRMA_NUEVO_CCG <> '19000101'  
          or Clrut in ( select CaRutCliente from CaencContrato ) -- MAP Carga de Clientes Espejo  
         )  
     and clnombre not like '%&%'  
  
                                            
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando CLIENTE')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
/* MAP: Se cargaran todos los clientes activos   
   insert into BacParamSudaCLIENTE  
   select Clrut  
      ,Cldv  
      ,Clcodigo  
      ,Clnombre  
      ,Clgeneric  
      ,Cldirecc  
      ,Clcomuna  
      ,Clregion  
      ,Cltipcli  
      ,Clfecingr  
      ,Clctacte  
      ,Clfono  
      ,Clfax  
      ,Clapelpa  
      ,Clapelma  
      ,Clnomb1  
      ,Clnomb2  
      ,Clapoderado  
      ,Clciudad  
      ,Clmercado  
      ,Clgrupo  
      ,Clpais  
      ,Clcalidadjuridica  
      ,Cltipoml  
      ,Cltipomx  
      ,Clbanca  
      ,Clrelac  
      ,Clnumero  
      ,Clcomex  
      ,Clchips  
      ,Claba  
      ,Clswift  
      ,Clnfm  
      ,Clfmutuo  
      ,Clfeculti  
      ,Clejecuti  
      ,Clentidad  
      ,Clgraba  
      ,Clcompint  
      ,Clcalle  
      ,Clctausd  
      ,Clcaljur  
      ,Clnemo  
      ,Climplic  
      ,Clopcion  
      ,Clcalidad  
      ,Cltipode  
      ,Clrelacion  
      ,Clcatego  
      ,Clsector  
      ,Clestado  
      ,Clclsbif  
      ,Clfesbif  
      ,Clclbco  
      ,Clfecbco  
      ,Clactivida  
      ,Cltelef  
      ,Usuario  
      ,Cltipemp  
      ,Relbco  
      ,Fecact  
      ,Cltipsis  
      ,Poder  
      ,Firma  
      ,Feca85  
      ,Relcia  
      ,Relcor  
      ,Infosoc  
      ,Art85  
      ,Dec85  
      ,Clconres  
      ,Clcodban  
      ,Cod_Inst  
      ,Rut_Grupo  
      ,Clcodfox  
      ,Clcrf  
      ,Clerf  
      ,Clvctolineas  
      ,Clvalidalinea  
      ,Oficinas  
      ,Clclaries  
      ,Codigo_Otc  
      ,Bloqueado  
      ,CLFECCONDGRL  
      ,clcosto  
      ,mxcontab  
      ,clrutcliexterno  
      ,cldvcliexterno  
      ,clBrokers  
      ,RutBancoReceptor  
      ,CodBancoReceptor  
      ,clCondicionesGenerales  
      ,clFechaFirma_cond  
      ,fecha_escritura  
      ,nombre_notaria  
      ,ClCompBilateral   
   from LnkBac.BacParamSuda.dbo.View_CLIENTEParaOpc  WITH (NOLOCK)  
   where ( ClRut = @Rut and clCodigo = 1 )  
  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando CLIENTE CORPBANCA')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
   */  
   -- Esta importación es obligatoria  
   -- porque la tabla Campo_Cnt no puede referenciar  
   -- a la tabla por LnkServer (nombre queda muy largo  
   -- y no puede grabarse en la tabla Campo_Cnt  
   truncate table BacParamSudaTBL_CLASIFICACION_CARTERA   
   insert into BacParamSudaTBL_CLASIFICACION_CARTERA   -- select * from BacParamSudaTBL_CLASIFICACION_CARTERA 
   SELECT id_Sistema,Tipo_movimiento,Tipo_operacion,TipoInstrumento,Moneda,TipoEmisor,OrigenEmision,ObjetoCubierto,Contraparte,Desde,Hasta,CarteraNormativa,SubcarteraNormativa,Glosa,CodigoCartera
   FROM   LnkBac.BacParamSuda.dbo.TBL_CLASIFICACION_CARTERA_INSTRUMENTO WITH (NOLOCK)   
   WHERE (   id_sistema = 'OPT'   
          )  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando TBL_CLASIFICACION_CARTERA')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   truncate table BacParamSudaPERFIL_CNT  
   insert into BacParamSudaPERFIL_CNT  
   SELECT *  
   FROM   LnkBac.BacParamSuda.dbo.PERFIL_CNT WITH (NOLOCK)   
   WHERE (   id_sistema = 'OPT'   
          )  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando PERFIL_CNT')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   truncate table BacParamSudaPERFIL_DETALLE_CNT  
   insert into BacParamSudaPERFIL_DETALLE_CNT  
   SELECT *  
   FROM   LnkBac.BacParamSuda.dbo.PERFIL_DETALLE_CNT WITH (NOLOCK)   
   WHERE (   Folio_Perfil in ( select Folio_perfil from  BacParamSudaPERFIL_CNT )  
          )  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando PERFIL_DETALLE_CNT')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   truncate table BacParamSudaPERFIL_VARIABLE_CNT  
   insert into BacParamSudaPERFIL_VARIABLE_CNT  
   SELECT *  
   FROM   LnkBac.BacParamSuda.dbo.PERFIL_VARIABLE_CNT WITH (NOLOCK)   
   WHERE (   Folio_Perfil in ( select Folio_perfil from  BacParamSudaPERFIL_CNT )  
          )  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando PERFIL_VARIABLE_CNT')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
   truncate table BacParamSudaCampo_CNT  
   insert into BacParamSudaCampo_CNT  
   SELECT id_sistema   
        , tipo_movimiento   
        , tipo_operacion   
        , codigo_campo   
        , descripcion_campo                                              
        , nombre_campo_tabla                         
        , tipo_administracion_campo   
        , tabla_campo = case when tabla_campo <> '' then case  when tabla_campo like '%BacParamSuda%' then tabla_campo  
                                                                    else 'lnkBac.BacParamSuda.dbo.' + tabla_campo end   
                                                    else '' end                                
        , campo_tabla                                                                                            
        , campos_tablas                                                                                          
  
   FROM   LnkBac.BacParamSuda.dbo.Campo_CNT WITH (NOLOCK)   
   WHERE (   id_sistema =  'OPT'   
          )  
   IF @@ERROR <> 0  
   BEGIN  
      SELECT @Control_Error = 1  
      INSERT CntError (Mensaje) VALUES ('ERROR_PROC FALLA Importando Campo_CNT')  
      GOTO   FIN_PROCEDIMIENTO  
   END  
  
FIN_PROCEDIMIENTO:  
   IF @Control_Error = 0  
   begin  
      UPDATE OpcionesGeneral with (rowlock)   
      SET CargaParamSudaCierre = 1   
      select convert( varchar(80) , 'Actualización OK' ) as Mensaje  
      --select 'OK', 'Ejecuta Correctamente Importacion datos BacParamSuda'  
   end  
     else 
      select convert( varchar(80) , 'Faltaron Algunos Parametros' ) as Mensaje  
      --select 'NO', Mensaje from CntError  
     
   return( @Control_Error )  
     
   SET NOCOUNT OFF  
  
  
END  
GO
