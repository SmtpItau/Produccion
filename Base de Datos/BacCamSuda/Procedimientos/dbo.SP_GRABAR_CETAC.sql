USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABAR_CETAC]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABAR_CETAC]  ( @aux_tac_codtx    numeric(2)   
                                   ,@aux_tac_fecha    datetime 
                                   ,@aux_tac_codmon   char(3)     
                                   ,@aux_tac_mtoori   numeric(19,4) 
                                   ,@aux_tac_mtousd   numeric(19,4) 
                                   ,@aux_tac_mtopes   numeric(19,4) 
                                   ,@aux_tac_cambio   numeric(19,4)
                                   ,@aux_tac_fpagpe   numeric(2)    
                                   ,@aux_tac_fpagmx   numeric(2)    
                                   ,@aux_tac_numope   numeric(7)    
                                   ,@aux_tac_refer    numeric(7)    
                                   ,@aux_tac_tipope   char(1)       
                                   ,@aux_tac_rutcli   numeric(9)    
                                   ,@aux_tac_tipcli   numeric(1)    
                                   ,@aux_tac_fecctb   datetime      
                                   ,@aux_tac_tipop    char(1)       
                                   ,@aux_tac_difrev   numeric(19)   
                                   ,@aux_tac_utirev   numeric(19)   
                                   ,@aux_tac_perrev   numeric(19)  
                                   ,@aux_tac_paridad  numeric(19,8)  
                                   ,@aux_tac_impuesto numeric(19)   
                                             )
                                              
AS
BEGIN
SET NOCOUNT ON
   insert into cetac (tac_codtx
                     ,tac_fecha
                     ,tac_codmon
                     ,tac_mtoori
                     ,tac_mtousd 
                     ,tac_mtopes
                     ,tac_cambio
                     ,tac_fpagpe
                     ,tac_fpagmx
                     ,tac_numope 
                     ,tac_refer
                     ,tac_tipope
                     ,tac_rutcli
                     ,tac_tipcli
                     ,tac_fecctb 
                     ,tac_tipop
                     ,tac_difrev
                     ,tac_utirev
                     ,tac_perrev
                     ,tac_paridad
                     ,tac_impuesto
                     )
             values( @aux_tac_codtx
                    ,@aux_tac_fecha
                    ,@aux_tac_codmon
                    ,@aux_tac_mtoori 
                    ,@aux_tac_mtousd
                    ,@aux_tac_mtopes
                    ,@aux_tac_cambio
                    ,@aux_tac_fpagpe 
                    ,@aux_tac_fpagmx
                    ,@aux_tac_numope
                    ,@aux_tac_refer
                    ,@aux_tac_tipope 
                    ,@aux_tac_rutcli
                    ,@aux_tac_tipcli
                    ,@aux_tac_fecctb
                    ,@aux_tac_tipop  
                    ,@aux_tac_difrev
                    ,@aux_tac_utirev
                    ,@aux_tac_perrev
                    ,@aux_tac_paridad 
                    ,@aux_tac_impuesto              
                   )
  
  IF @@ERROR <> 0 BEGIN
     ROLLBACK TRANSACTION
     SELECT -1, 'ERROR:  EN CALCULOS DIARIOS.'
     SET NOCOUNT OFF
     RETURN
  END
END

GO
