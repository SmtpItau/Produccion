USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[dpsp_obtiene_depositos]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[dpsp_obtiene_depositos] (@fecha as datetime)  
  
/**  
  
 SP Name            : dpsp_obtiene_depositos  
  
 Fecha Creación     :  
  
 Author             : Banco Itaú                          
  
 Author Modificación : Jose Bustos H.  
  
 Fecha Modificación : 16/09/2010                                                                    
  
 Descripción        : Obtiene depositos para Simulación DP a Altamira   
   
 Modificación       : se agrego campo tasa_tran  
                                                
  
**/  
  
as  
begin  
            select   
            numero_operacion,fecha_operacion,fecha_vencimiento,plazo,tasa,  
            moneda,codigo_as400,clcodigo,cuenta_dcv,mncodbkb,clnombre,  
            sum(monto_inicio) as monto_inicio,sum(monto_final) as monto_final,count(*) as cortes,  
            tipo_emision,tipo_deposito,rut_cliente,cldv,tasa_tran  
            from VIEW_DEPOSITOS   
            where fecha_operacion=@fecha  
            group by  
            numero_operacion,fecha_operacion,fecha_vencimiento,plazo,tasa,  
            moneda,codigo_as400,clcodigo,cuenta_dcv,mncodbkb,clnombre,tipo_emision,tipo_deposito,  
            rut_cliente,cldv,tasa_tran  
            order by rut_cliente,mncodbkb,tipo_deposito,numero_operacion  
end  
  
GO
