USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_LIQUIDEZ_HISTORICO]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_LIQUIDEZ_HISTORICO]  
as  
begin   
set nocount on  
  
declare @acfecprox datetime,
         @acfecproc datetime ,  
        @valor_pres numeric(19,4),  
        @valor_pres2 numeric(19,4),  
        @Responsable char(40),  
        @Referencia  char(40)   
   
  
  
select @acfecproc   = acfecproc,  
        @acfecprox   = acfecprox,  
        @Responsable = acnom_resoma,    
        @Referencia  = acnomprop  
from mdac0111  
  
  
create table #tmp_cp  
            ( codigo            numeric(5)     --1  
             ,suma_prc          numeric(19,4)  --2  
             ,suma_prd          numeric(19,4)  --3   
             ,suma_pdbc         numeric(19,4)  --4  
             ,suma_prbc         numeric(19,4)  --5       
             ,suma_cero         numeric(19,4)  --6       
             ,suma_zero         numeric(19,4)  --7       
             ,suma_bcp          numeric(19,4)  --8       
             ,suma_bcu          numeric(19,4)  --9       
             ,suma_bcd          numeric(19,4)  --10       
             ,suma_btp          numeric(19,4)  --10       
             ,suma_btu          numeric(19,4)  --10       
             ,suma_prc_int      numeric(19,4)  --11  
             ,suma_prd_int      numeric(19,4)  --12       
             ,suma_pdbc_int     numeric(19,4)  --13  
             ,suma_prbc_int     numeric(19,4)  --14       
             ,suma_cero_int     numeric(19,4)  --15       
             ,suma_zero_int     numeric(19,4)  --16       
             ,suma_bcp_int      numeric(19,4)  --17       
             ,suma_bcu_int      numeric(19,4)  --18       
             ,suma_bcd_int      numeric(19,4)  --19       
             ,suma_btp_int      numeric(19,4)  --19       
             ,suma_btu_int      numeric(19,4)  --19       
             ,suma_prc_pacto    numeric(19,4)  --20  
             ,suma_prd_pacto    numeric(19,4)  --21       
             ,suma_pdbc_pacto   numeric(19,4)  --22  
             ,suma_prbc_pacto   numeric(19,4)  --23       
             ,suma_cero_pacto   numeric(19,4)  --24       
             ,suma_zero_pacto   numeric(19,4)  --25       
             ,suma_bcp_pacto    numeric(19,4)  --26       
             ,suma_bcu_pacto    numeric(19,4)  --27       
             ,suma_bcd_pacto    numeric(19,4)  --28       
             ,suma_btp_pacto    numeric(19,4)  --28  
             ,suma_btu_pacto    numeric(19,4)  --28       
             ,instrumento       char(20)       --29                     
             )  
  
--************* Insertando Codigo Instrumentos *************  
  
--PRC  
insert #tmp_cp   
      select   4  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')    
--PRD  
insert #tmp_cp   
      select   31  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--PDBC  
insert #tmp_cp   
      select  6  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--PRBC  
insert #tmp_cp   
      select  7  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--CERO  
insert #tmp_cp   
      select   300  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--ZERO  
insert #tmp_cp   
      select   301  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--BCP  
insert #tmp_cp   
      select   33  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--BCU  
insert #tmp_cp   
      select   32  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
--BCD  
insert #tmp_cp   
      select   34  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
     , convert(char(20),'')   
  
--BTP  
insert #tmp_cp   
      select   37  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
--BTU  
insert #tmp_cp   
      select   36  
             , 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0  
             , convert(char(20),'')   
  
  
--************* PRC ****************  
  
update  #tmp_cp   
      set suma_prc_int = ISNULL((select sum(vivptirc)/1000             
      from mdvi0111 where vicodigo = 4 group by vicodigo),0)  
  
  
update  #tmp_cp   
      set   suma_prc  = ISNULL(( select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo = 4 group by cpcodigo),0)  
  
update  #tmp_cp   
      set   suma_prc_pacto = ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 4 group by cicodigo),0)  
  
  
--*********** PRD  *****************  
  
update  #tmp_cp   
      set suma_prd_int = ISNULL((select  sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 31 group by vicodigo),0)  
  
  
update  #tmp_cp   
      set   suma_prd =  ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo = 31 group by cpcodigo),0)  
  
  
update  #tmp_cp   
      set suma_prd_pacto = ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 31 group by cicodigo),0)  
  
  
--************ PDBC ****************   
  
  
update #tmp_cp   
      set suma_pdbc_int = ISNULL((select  sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 6 group by vicodigo ),0)  
  
  
  
update  #tmp_cp   
      set  suma_pdbc =  ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo = 6 group by cpcodigo),0)  
  
update  #tmp_cp   
      set suma_pdbc_pacto = ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 6 group by cicodigo),0)  
  
  
--*********** PRBC *****************  
  
update  #tmp_cp   
      set suma_prbc_int = ISNULL((select  sum(vivptirc)/1000   
      from mdvi0111 where vicodigo =7  group by vicodigo),0)  
  
  
update #tmp_cp   
      set suma_prbc =  ISNULL((select sum(cpvptirc)/1000            
      from mdcp0111 where cpcodigo =7  group by cpcodigo),0)  
  
  
update  #tmp_cp   
      set suma_prbc_pacto =  ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 7 group by cicodigo),0)  
  
  
  
--*********** CERO ******************  
  
update  #tmp_cp   
      set suma_cero_int = ISNULL((select sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 300 group by vicodigo),0)  
  
  
  
update  #tmp_cp   
      set suma_cero = ISNULL( (select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =300  group by cpcodigo),0)  
  
  
update  #tmp_cp   
      set suma_cero_pacto = ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 300 group by cicodigo),0)  
  
  
--*********** ZERO ******************  
  
  
update  #tmp_cp   
      set suma_zero_int =  ISNULL((select  sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 301 group by vicodigo ),0)  
  
  
  
update  #tmp_cp   
      set suma_zero  = ISNULL( (select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =301  group by cpcodigo),0)  
  
  
update #tmp_cp   
      set suma_zero_pacto =  ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 301 group by cicodigo),0)  
  
  
  
--*********** BCP ******************  
  
  
update #tmp_cp   
      set suma_bcp_int =  ISNULL((select  sum(vivptirc)/1000   
      from mdvi0111 where vicodigo = 33 group by vicodigo ),0)  
  
  
update #tmp_cp   
      set suma_bcp = ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =33  group by cpcodigo),0)  
  
update #tmp_cp   
      set  suma_bcp_pacto = ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 33 group by cicodigo),0)  
  
  
--*********** BCU ******************  
  
update #tmp_cp   
      set suma_bcu_int =  ISNULL((select  sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 32 group by vicodigo),0)  
  
  
update  #tmp_cp   
      set suma_bcu = ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =32  group by cpcodigo),0)  
  
update #tmp_cp   
      set   suma_bcu_pacto =  ISNULL((select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 32 group by cicodigo),0)  
  
  
--*********** BCD ******************  
  
update #tmp_cp   
      set suma_bcd_int= ISNULL((select sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 34 group by vicodigo),0)  
  
  
update #tmp_cp   
      set  suma_bcd =  ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =34  group by cpcodigo),0)  
  
update  #tmp_cp   
      set  suma_bcd_pacto = ISNULL( (select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 34 group by cicodigo),0)  
  
--*********** BTP ******************  
  
update #tmp_cp   
      set suma_btp_int= ISNULL((select sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 37 group by vicodigo),0)  
  
  
update #tmp_cp   
      set  suma_btp =  ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =37  group by cpcodigo),0)  
  
update  #tmp_cp   
      set  suma_btp_pacto = ISNULL( (select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 37 group by cicodigo),0)  
  
--*********** BTU ******************  
  
update #tmp_cp   
      set suma_btu_int= ISNULL((select sum(vivptirc)/1000  
      from mdvi0111 where vicodigo = 36 group by vicodigo),0)  
  
  
update #tmp_cp   
      set  suma_btu =  ISNULL((select sum(cpvptirc)/1000  
      from mdcp0111 where cpcodigo =36  group by cpcodigo),0)  
  
update  #tmp_cp   
      set  suma_btu_pacto = ISNULL( (select sum(civptirc)/1000  
      from mdci0111 where cicodigo = 36 group by cicodigo),0)  
  
  
   
--************ ACTUALIZACIONES **************  
  
/*update #tmp_cp set suma_prc  = suma_prc /1000 where codigo = 4   
update #tmp_cp set suma_prd  = suma_prd  /1000 where codigo = 31   
update #tmp_cp set suma_pdbc = suma_pdbc /1000 where codigo = 6   
update #tmp_cp set suma_prbc = suma_prbc /1000 where codigo = 7   
update #tmp_cp set suma_cero = suma_cero /1000 where codigo = 300   
update #tmp_cp set suma_zero = suma_zero /1000 where codigo = 301   
update #tmp_cp set suma_bcp  = suma_bcp  /1000 where codigo = 33   
update #tmp_cp set suma_bcu  = suma_bcu  /1000 where codigo = 32   
update #tmp_cp set suma_bcd  = suma_bcd /1000 where codigo = 34   
update #tmp_cp set suma_prc_int   = suma_prc_int /1000 where codigo = 4   
update #tmp_cp set suma_prd_int   = suma_prd_int /1000 where codigo = 31   
update #tmp_cp set suma_pdbc_int  = suma_pdbc_int /1000 where codigo = 6   
update #tmp_cp set suma_prbc_int  = suma_prbc_int /1000 where codigo = 7   
update #tmp_cp set suma_cero_int  = suma_cero_int /1000 where codigo = 300   
update #tmp_cp set suma_zero_int  = suma_zero_int /1000 where codigo = 301   
update #tmp_cp set suma_bcp_int   = suma_bcp_int /1000 where codigo = 33   
update #tmp_cp set suma_bcu_int   = suma_bcu_int /1000 where codigo = 32   
update #tmp_cp set suma_bcd_int   = suma_bcd_int /1000 where codigo = 34   
update #tmp_cp set suma_prc_pacto  = suma_prc_pacto /1000 where codigo = 4   
update #tmp_cp set suma_prd_pacto  = suma_prd_pacto /1000 where codigo = 31   
update #tmp_cp set suma_pdbc_pacto = suma_pdbc_pacto /1000 where codigo = 6   
update #tmp_cp set suma_prbc_pacto = suma_prbc_pacto /1000 where codigo = 7   
update #tmp_cp set suma_cero_pacto = suma_cero_pacto /1000 where codigo = 300   
update #tmp_cp set suma_zero_pacto = suma_zero_pacto /1000 where codigo = 301   
update #tmp_cp set suma_bcp_pacto  = suma_bcp_pacto /1000 where codigo = 33   
update #tmp_cp set suma_bcu_pacto  = suma_bcu_pacto /1000 where codigo = 32   
update #tmp_cp set suma_bcd_pacto  = suma_bcd_pacto /1000 where codigo = 34 */  
  
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 4 and codigo = 4   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 31 and codigo = 31   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 6 and codigo = 6   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 7 and codigo = 7   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 300 and codigo = 300   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 301 and codigo = 301   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 33 and codigo = 33   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 32 and codigo = 32   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 34 and codigo = 34   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 37 and codigo = 37   
update #tmp_cp set instrumento = inserie from view_instrumento where incodigo = 36 and codigo = 36   
  
--*********************************************  
  
select  codigo  
       ,'suma_prc' = ISNULL(sum(suma_prc),0)       
       ,'suma_prd' = ISNULL(sum(suma_prd),0)       
       ,'suma_pdbc' = ISNULL(sum(suma_pdbc),0)      
       ,'suma_prbc' = ISNULL(sum(suma_prbc),0)      
       ,'suma_cero' = ISNULL(sum(suma_cero),0)      
       ,'suma_zero' = ISNULL(sum(suma_zero),0)      
       ,'suma_bcp' = ISNULL(sum(suma_bcp),0)    
       ,'suma_bcu' = ISNULL(sum(suma_bcu),0)  
       ,'suma_bcd' = ISNULL(sum(suma_bcd),0)          
       ,'suma_btp' = ISNULL(sum(suma_btp),0)          
       ,'suma_btu' = ISNULL(sum(suma_btu),0)          
       ,'suma_prc_int' = ISNULL(sum(suma_prc_int),0)      
       ,'suma_prd_int' = ISNULL(sum(suma_prd_int),0)      
       ,'suma_pdbc_int' = ISNULL(sum(suma_pdbc_int),0)     
       ,'suma_prbc_int' = ISNULL(sum(suma_prbc_int),0)     
       ,'suma_cero_int' = ISNULL(sum(suma_cero_int),0)     
       ,'suma_zero_int' = ISNULL(sum(suma_zero_int),0)     
       ,'suma_bcp_int' = ISNULL(sum(suma_bcp_int),0)      
       ,'suma_bcu_int' = ISNULL(sum(suma_bcu_int),0)      
       ,'suma_bcd_int' = ISNULL(sum(suma_bcd_int),0)      
       ,'suma_btp_int' = ISNULL(sum(suma_btp_int),0)      
       ,'suma_btu_int' = ISNULL(sum(suma_btu_int),0)      
       ,'suma_prc_pacto' = ISNULL(sum(suma_prc_pacto),0)    
       ,'suma_prd_pacto' = ISNULL(sum(suma_prd_pacto),0)    
       ,'suma_pdbc_pacto' = ISNULL(sum(suma_pdbc_pacto),0)   
       ,'suma_prbc_pacto' = ISNULL(sum(suma_prbc_pacto),0)   
       ,'suma_cero_pacto' = ISNULL(sum(suma_cero_pacto),0)   
       ,'suma_zero_pacto' = ISNULL(sum(suma_zero_pacto),0)   
       ,'suma_bcp_pacto' = ISNULL(sum(suma_bcp_pacto),0)    
       ,'suma_bcu_pacto' = ISNULL(sum(suma_bcu_pacto),0)    
       ,'suma_bcd_pacto' = ISNULL(sum(suma_bcd_pacto),0)   
       ,'suma_btp_pacto' = ISNULL(sum(suma_btp_pacto),0)    
        ,'suma_btu_pacto' = ISNULL(sum(suma_btu_pacto),0)    
       , instrumento    
       ,'proximo_proc'= @acfecprox  
       ,'proceso'     = @acfecproc  
       ,'Responsable' = @Responsable  
       ,'Referencia'  = @Referencia       
  
 from #tmp_cp   
 group by codigo  
       ,instrumento    
end  

GO
