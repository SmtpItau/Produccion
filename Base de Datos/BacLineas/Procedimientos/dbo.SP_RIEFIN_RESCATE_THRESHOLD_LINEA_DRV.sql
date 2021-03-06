USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV]
					   (   	@Fecha					datetime                
						,	@Rut					int     
						,	@Codigo					int    
					   )


	
AS
BEGIN

   SET NOCOUNT ON 

   -- SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV '20110321',  1, 1
   -- SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV '20110311', 472655828, 1
   -- SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV '20110311',  643293 , 1
   -- SP_RIEFIN_RESCATE_THRESHOLD_LINEA_DRV '20110311', 470300136, 1

   declare @Monto_Linea_Threshold            numeric(20,4)
   declare @Moneda_Monto_Linea_Threshold     numeric(5)
   declare @TCM_Moneda_Monto_Linea_Threshold numeric(10,4)
      
   declare @Monto_Linea_Drv_Otorgada    numeric(20,4)
   declare @Moneda_Monto_Linea_Drv_Otorgada    numeric(20,4)
   declare @TCM_Moneda_Monto_Linea_Drv_Otorgada    numeric(20,4)
   
   -- Cambio al Padre para rescatar Threshold   
   Select  @Rut    = clrut_padre
         , @Codigo = clcodigo_padre
   from CLIENTE_RELACIONADO 
   where     clrut_hijo = @Rut
         and clcodigo_hijo = @Codigo
         and Afecta_Lineas_Hijo = 0 -- Solo familias tipo AFP

   -- Rescate del Monto Threshold y la mda.
   -- en que está expresado.
   set @Monto_Linea_Threshold = 0
   set @Moneda_Monto_Linea_Threshold = 0
   select @Monto_Linea_Threshold        = Monto_Linea_Threshold 
        , @Moneda_Monto_Linea_Threshold = 13 -- moneda       -- Temporalmente hasta haya moneda para Threshold.
   from LINEA_GENERAL   
   where  rut_cliente = @Rut
      and codigo_cliente = @Codigo

   -- Rescate del Valor de Tipo de Cambio para
   -- la moneda en que está expresada el monto
   -- threshold
   set @TCM_Moneda_Monto_Linea_Threshold = 1
   select @TCM_Moneda_Monto_Linea_Threshold = Tipo_Cambio 
   from BacParamSuda..Valor_Moneda_Contable 
   where  Codigo_Moneda = ( Case when @Moneda_Monto_Linea_Threshold = 13 then 994 else @Moneda_Monto_Linea_Threshold end )    
       and Fecha        = @Fecha
   

   -- Rescate del Monto linea asignada para derivados y la mda.
   -- en que está expresada.
   set @Monto_Linea_Drv_Otorgada = 0
   set @Moneda_Monto_Linea_Drv_Otorgada = 0
   select @Monto_Linea_Drv_Otorgada        = TotalAsignado
        , @Moneda_Monto_Linea_Drv_Otorgada = Moneda       
   from LINEA_SISTEMA   
   where  rut_cliente = @Rut
      and codigo_cliente = @Codigo
      and Id_Sistema = 'DRV'    -- select distinct id_sistema , * from linea_sistema
      

   -- Rescate del Valor de Tipo de Cambio para
   -- la moneda en que está expresada La linea
   -- para derivados
   set    @TCM_Moneda_Monto_Linea_Drv_Otorgada = 1
   select @TCM_Moneda_Monto_Linea_Drv_Otorgada = Tipo_Cambio 
   from BacParamSuda..Valor_Moneda_Contable 
   where  Codigo_Moneda = ( Case when @Moneda_Monto_Linea_Drv_Otorgada = 13 then 994 else @Moneda_Monto_Linea_Drv_Otorgada end )    
      and Fecha = @Fecha

   Select Rut    = @Rut
       ,  Codigo = @Codigo
       ,  Threshold_MO  = @Monto_Linea_Threshold
       ,  Threshold_TCM = @TCM_Moneda_Monto_Linea_Threshold  
       ,  Threshold_CLP = round( @Monto_Linea_Threshold * @TCM_Moneda_Monto_Linea_Threshold  , 0 )
       ,  Linea_MO      = @Monto_Linea_Drv_Otorgada
       ,  Linea_CLP     = round( @Monto_Linea_Drv_Otorgada * @TCM_Moneda_Monto_Linea_Drv_Otorgada , 0 )   
       ,  Estado_Linea  = case when  @Monto_Linea_Drv_Otorgada = 0 then 'No hay Linea DRV Aùn' else ' ' end   
   -- PENDIENTE: programar posible error  con @@error
   -- retornando 1
END
GO
