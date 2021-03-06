USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVIMIENTOS_DIARIOS]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MOVIMIENTOS_DIARIOS]
AS
BEGIN
   /*=======================================================================*/
delete from cetac        -- borra los movimientos del dia de la tabla cetac 
   /*=======================================================================*/
declare @aux_tac_codtx       numeric(2)   
       ,@aux_tac_fecha       datetime      
       ,@aux_tac_codmon      char(3)       
       ,@aux_tac_mtoori      numeric(19,4) 
       ,@aux_tac_mtousd      numeric(19,4) 
       ,@aux_tac_mtopes      numeric(19,4) 
       ,@aux_tac_paridad     numeric(19,8) 
       ,@aux_tac_cambio      numeric(19,4) 
       ,@aux_tac_fpagpe      numeric(2)    
       ,@aux_tac_fpagmx      numeric(2)    
       ,@aux_tac_numope      numeric(7)    
       ,@aux_tac_refer       numeric(7)    
       ,@aux_tac_tipope      char(1)       
       ,@aux_tac_rutcli      numeric(9)    
       ,@aux_tac_tipcli      numeric(1)    
       ,@aux_tac_fecctb      datetime      
       ,@aux_tac_tipop       char(1)       
       ,@aux_tac_difrev      numeric(19)   
       ,@aux_tac_utirev      numeric(19)   
       ,@aux_tac_perrev      numeric(19)   
       ,@aux_tac_impuesto    numeric(19)   
   /*=======================================================================*/
Declare   
       @aux_mofech      datetime
      ,@aux_mocodmon    char(3)
      ,@aux_mocodcnv    char(3)
      ,@aux_momonmo     numeric(19,4)
      ,@aux_moussme     numeric(19,4)
      ,@aux_momonpe     numeric(19,4)
      ,@aux_moparme     numeric(19,8)
      ,@aux_moticam     numeric(19,4)
      ,@aux_monumope    numeric(7)
      ,@aux_motipope    char(1)
      ,@aux_morutcli    numeric(9)
      ,@aux_motipmer    char(4)
      ,@aux_moentre     numeric(2)
      ,@aux_morecib     numeric(2)
   /*=======================================================================*/      
declare @xxfecha        datetime
declare @aux_tac_return numeric(2) 
declare @conta numeric(6)
   /*=======================================================================*/
set @aux_tac_codtx  = isnull(@aux_tac_codtx ,0)
set @aux_tac_fecha  = isnull(@aux_tac_fecha ,' ')
set @aux_tac_codmon = isnull(@aux_tac_codmon,' ')
set @aux_tac_mtoori = isnull(@aux_tac_mtoori,0)
set @aux_tac_mtousd = isnull(@aux_tac_mtousd,0)
set @aux_tac_mtopes = isnull(@aux_tac_mtopes,0)
set @aux_tac_paridad = isnull(@aux_tac_paridad,0)
set @aux_tac_cambio  = isnull(@aux_tac_cambio,0)
set @aux_tac_fpagpe  = isnull(@aux_tac_fpagpe,0)
set @aux_tac_fpagmx  = isnull(@aux_tac_fpagmx,0)
set @aux_tac_numope  = isnull(@aux_tac_numope,0)
set @aux_tac_refer   = isnull(@aux_tac_refer ,0)
set @aux_tac_tipope  = isnull(@aux_tac_tipope,0)
set @aux_tac_rutcli  = isnull(@aux_tac_rutcli,0)
set @aux_tac_tipcli  = isnull(@aux_tac_tipcli,0)
set @aux_tac_fecctb  = isnull(@aux_tac_fecctb,' ')
set @aux_tac_tipop   = isnull(@aux_tac_tipop ,' ')
set @aux_tac_difrev  = isnull(@aux_tac_difrev,0)
set @aux_tac_utirev  = isnull(@aux_tac_utirev,0)
set @aux_tac_perrev  = isnull(@aux_tac_perrev,0)
set @aux_tac_impuesto = isnull(@aux_tac_impuesto,0)
set @aux_tac_return   = isnull(@aux_tac_return,0)
Declare movimiento cursor for
        Select mofech,mocodmon,mocodcnv,momonmo,moussme,momonpe,moparme
              ,moticam,monumope,motipope,morutcli,motipmer,moentre,morecib
        from memo ,meac  
        where (mofech = acfecpro) and( motipmer = 'PTAS' or motipmer = 'ARBI' 
              or motipmer = 'CANJE' or motipmer = 'ARRI') and( id_sistema = 'BCC')
           
open movimiento
fetch movimiento
Into  @aux_mofech      
     ,@aux_mocodmon   
     ,@aux_mocodcnv   
     ,@aux_momonmo
     ,@aux_moussme
     ,@aux_momonpe
     ,@aux_moparme
     ,@aux_moticam
     ,@aux_monumope
     ,@aux_motipope
     ,@aux_morutcli
     ,@aux_motipmer
     ,@aux_moentre
     ,@aux_morecib
  While (@@fetch_status = 0)
  Begin
   set @xxfecha  = @aux_mofech   
   If  ( @aux_mocodcnv =  'CLP' and @aux_morutcli = 97029000 ) and @aux_motipmer = 'PTAS' begin  /*     MOVIMIENTO           */
       set @aux_tac_fecha  = @aux_mofech
       set @aux_tac_codmon = @aux_mocodmon
       set @aux_tac_mtoori = @aux_momonmo
       set @aux_tac_mtousd = @aux_moussme
       set @aux_tac_mtopes = @aux_momonpe
       set @aux_tac_paridad= @aux_moparme 
       set @aux_tac_cambio = @aux_moticam
       set @aux_tac_numope = @aux_monumope
       set @aux_tac_fecctb = '12/12/1900'
       set @aux_tac_tipop  = @aux_motipope
       set @aux_tac_refer  = @aux_monumope
       set @aux_tac_tipope = @aux_motipope
       set @aux_tac_rutcli = @aux_morutcli
      
       if @aux_motipope = 'C' begin
         set @aux_tac_codtx  = 12
        end else begin 
         set @aux_tac_codtx  = 13
       end  
       
      
       exec sp_calculaFpagPeMx_diarios 1,@xxfecha ,@aux_motipope,@aux_moentre
                                        ,@aux_morecib,@aux_tac_return out
       set @aux_tac_fpagpe = @aux_tac_return
       
       exec  sp_calculaFpagPeMx_diarios 2,@xxfecha ,@aux_motipope,@aux_moentre
                                         ,@aux_morecib,@aux_tac_return out
       set @aux_tac_fpagmx = @aux_tac_return
       if @aux_morutcli <> 97018000 begin 
          set @aux_tac_tipcli = 1
         end else  begin
          set @aux_tac_tipcli = 2
       end 
     exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                          ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                          ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                          ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                          ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                          ,@aux_tac_impuesto
   End 
   
  if (@aux_mocodcnv = 'CLP' and @aux_morutcli <> 97029000)  and @aux_motipmer = 'PTAS'  begin 
    
     if @aux_motipope = 'C' begin
        set @aux_tac_codtx = 1
       end else begin 
        set @aux_tac_codtx = 2
     end   
    set @aux_tac_fecha  = @aux_mofech
    set @aux_tac_codmon = @aux_mocodmon
    set @aux_tac_mtoori = @aux_momonmo
    set @aux_tac_mtousd = @aux_moussme
    set @aux_tac_mtopes = @aux_momonpe
    set @aux_tac_paridad= @aux_moparme 
    set @aux_tac_cambio = @aux_moticam
    exec sp_calculaFpagPeMx_diarios 1,@xxfecha ,@aux_motipope,@aux_moentre
                                     ,@aux_morecib,@aux_tac_return out
    set @aux_tac_fpagpe = @aux_tac_return
       
    exec  sp_calculaFpagPeMx_diarios 2,@xxfecha ,@aux_motipope,@aux_moentre
                                      ,@aux_morecib,@aux_tac_return out
    set @aux_tac_fpagmx = @aux_tac_return
    set @aux_tac_numope = @aux_monumope
    set @aux_tac_refer  = @aux_monumope
    set @aux_tac_tipope = @aux_motipope
    set @aux_tac_rutcli = @aux_morutcli 
 
    if @aux_morutcli <> 97029000 begin 
       set @aux_tac_tipcli = 1
      end else begin 
       set @aux_tac_tipcli = 2
    end 
    set @aux_tac_fecctb = ' '
    exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                         ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                         ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                         ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                         ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                         ,@aux_tac_impuesto
  end 
/*============================================================================================*/
 if @aux_motipmer = 'ARBI'   begin       /*                 ARBITRAJE                         */
   
     exec @aux_tac_fecctb = sp_diferencia_dias @aux_motipope,@aux_moentre,@aux_morecib
if @aux_motipope = 'C' begin 
       set @aux_tac_codtx  = 3
       end else begin 
       set @aux_tac_codtx  = 4
     end
     set @aux_tac_fecha  = @aux_mofech
     set @aux_tac_codmon = @aux_mocodmon
     set @aux_tac_mtoori = @aux_momonmo
     set @aux_tac_mtousd = @aux_moussme
     set @aux_tac_mtopes = @aux_momonpe
     set @aux_tac_paridad= @aux_moparme 
     set @aux_tac_cambio = @aux_moticam
     set @aux_tac_numope = @aux_monumope
     exec sp_calculaFpagPeMx_diarios 1,@xxfecha ,@aux_motipope,@aux_moentre
                                      ,@aux_morecib,@aux_tac_return out
     set @aux_tac_fpagpe = @aux_tac_return
       
     exec  sp_calculaFpagPeMx_diarios 2,@xxfecha ,@aux_motipope,@aux_moentre
                                       ,@aux_morecib,@aux_tac_return out
     set @aux_tac_fpagmx = @aux_tac_return
     set @aux_tac_rutcli = 97018000
     exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                          ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                          ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                          ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                          ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                          ,@aux_tac_impuesto
  
   end
/*=============================================================================================*/
  if @aux_motipope = 'CANJ' begin     /*                  CANJE                       */
     
     set @aux_tac_codtx  = 1          /*       pirmer registro por las compras           */
     set @aux_tac_fecha  = @aux_mofech
     set @aux_tac_codmon = 'USD'
     set @aux_tac_mtoori = @aux_momonmo
     set @aux_tac_mtousd = @aux_moussme
     set @aux_tac_mtopes = @aux_momonpe
     set @aux_tac_paridad= (1.00) 
     set @aux_tac_cambio = @aux_moticam   
     set @aux_tac_fpagpe = @aux_morecib
     set @aux_tac_fpagmx = @aux_moentre
     set @aux_tac_numope = @aux_monumope
     set @aux_tac_refer  = @aux_monumope
     set @aux_tac_rutcli = @aux_morutcli
     if @aux_morutcli <> 97029000 begin 
       set @aux_tac_tipcli = 1
      end else begin 
       set @aux_tac_tipcli = 2
     end 
     set @aux_tac_tipop  = 'C'  
     exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                          ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                          ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                          ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                          ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                          ,@aux_tac_impuesto
   /*                                                    segundo registro por las ventas      */
     exec @aux_tac_fecctb = sp_diferencia_dias @aux_motipope,@aux_moentre,@aux_morecib
     set @aux_tac_codtx  = 2                 
     set @aux_tac_fecha  = @aux_mofech
     set @aux_tac_codmon = 'USD'
     set @aux_tac_mtoori = @aux_momonmo
     set @aux_tac_mtousd = @aux_moussme
     set @aux_tac_mtopes = (@aux_moticam * @aux_momonpe)
     set @aux_tac_paridad= (1.00) 
     set @aux_tac_cambio = @aux_moticam   
     set @aux_tac_fpagpe = @aux_morecib
     set @aux_tac_fpagmx = @aux_moentre
     set @aux_tac_numope = @aux_monumope
     set @aux_tac_refer  = @aux_monumope
     set @aux_tac_rutcli = @aux_morutcli
     if @aux_morutcli <> 97029000 begin 
       set @aux_tac_tipcli = 1
      end else begin 
       set @aux_tac_tipcli = 2
     end 
     set @aux_tac_tipop  = 'C'  
     exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                          ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                          ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                          ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                          ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                          ,@aux_tac_impuesto 
  end 
/*============================================================================================*/   
  if @aux_motipope = 'ARRI' begin   /*                  ARRIENDO                              */                  
     
    exec @aux_tac_fecctb = sp_diferencia_dias @aux_motipope,@aux_moentre,@aux_morecib
    if @aux_motipope = 'C' begin
       set @aux_tac_codtx = 1
      end else begin 
        set @aux_tac_codtx  = 2
    end   
     set @aux_tac_fecha  = @aux_mofech
     set @aux_tac_codmon = 'USD'
     set @aux_tac_mtoori = @aux_momonmo
     set @aux_tac_mtousd = @aux_moussme
     set @aux_tac_mtopes = (@aux_moticam * @aux_momonpe)
     set @aux_tac_paridad= (1.00) 
     set @aux_tac_cambio = @aux_moticam   
     set @aux_tac_fpagpe = @aux_morecib
     set @aux_tac_fpagmx = @aux_moentre
     set @aux_tac_numope = @aux_monumope
     set @aux_tac_refer  = @aux_monumope
     set @aux_tac_rutcli = @aux_morutcli
     if @aux_morutcli <> 97029000 begin 
       set @aux_tac_tipcli = 1
      end else begin 
       set @aux_tac_tipcli = 2
     end 
     set @aux_tac_tipop  = 'A' 
     exec sp_grabar_cetac  @aux_tac_codtx,@aux_tac_fecha,@aux_tac_codmon,@aux_tac_mtoori
                          ,@aux_tac_mtousd,@aux_tac_mtopes,@aux_tac_cambio,@aux_tac_fpagpe
                          ,@aux_tac_fpagmx,@aux_tac_numope,@aux_tac_refer,@aux_tac_tipope 
                          ,@aux_tac_rutcli,@aux_tac_tipcli,@aux_tac_fecctb,@aux_tac_tipop
                          ,@aux_tac_difrev,@aux_tac_utirev,@aux_tac_perrev,@aux_tac_paridad
                          ,@aux_tac_impuesto
  end
/*============================================================================================*/
  /* limpia las variables */
  set @aux_tac_codtx  = 0
  set @aux_tac_fecha  = ' '
  set @aux_tac_codmon = ' '
  set @aux_tac_mtoori = 0
  set @aux_tac_mtousd = 0
  set @aux_tac_mtopes = 0
  set @aux_tac_cambio = 0
  set @aux_tac_fpagpe = 0
  set @aux_tac_fpagmx = 0
  set @aux_tac_numope = 0
  set @aux_tac_refer  = 0
  set @aux_tac_tipope = 0
  set @aux_tac_rutcli = 0
  set @aux_tac_tipcli = 0
  set @aux_tac_fecctb = ' '
  set @aux_tac_tipop  = ' '
  set @aux_tac_difrev = 0
  set @aux_tac_utirev = 0
  set @aux_tac_perrev = 0
  set @aux_tac_paridad = 0
  set @aux_tac_impuesto = 0
  set @aux_tac_return = 0
 
  Fetch movimiento
  Into  @aux_mofech      
       ,@aux_mocodmon   
       ,@aux_mocodcnv   
       ,@aux_momonmo
       ,@aux_moussme
       ,@aux_momonpe
       ,@aux_moparme
       ,@aux_moticam
       ,@aux_monumope
       ,@aux_motipope
       ,@aux_morutcli
       ,@aux_motipmer
       ,@aux_moentre
       ,@aux_morecib
 End -- while 
  close movimiento
  deallocate movimiento
END
select * from cetac

GO
