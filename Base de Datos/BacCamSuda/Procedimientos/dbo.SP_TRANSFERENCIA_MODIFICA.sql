USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRANSFERENCIA_MODIFICA]    Script Date: 11-05-2022 16:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SP_TRANSFERENCIA_MODIFICA]
           (
                @numope        char(5)
               ,@corresponsal  varchar(10)
               ,@valuta        datetime
               ,@monto         numeric(19,4)
               ,@apodder       numeric(9)
               ,@apodizq       numeric(9)
               ,@rutcli        numeric(9)        
               ,@operador      char(10)         
               ,@fecha         datetime           
               ,@hora          char(8)
               ,@terminal      char(12)
            )            
as 
begin
   set nocount on
               declare @nomcli   char(35)
               declare @codcli   numeric(5)
               declare @observ   numeric(19,3)
               declare @entidad  numeric(9)               
               declare @tipmer   char(4)
               declare @tipope   char(1)
               declare @codmon   char(3)
               declare @codm0nc  char(3)
         begin transaction
                  -- selecciona el nombre y codigo del cliente a partir del rut
                  select @nomcli = ( select clnombre from VIEW_CLIENTE where clrut = @rutcli )
                  select @codcli = ( select clcodigo from VIEW_CLIENTE where clrut = @rutcli )
                  -- selecciona el dolar observ
                  select @observ = ( select acobser from MEAC )
                  -- asigna la entidad
                  select @entidad = ( select accodigo from MEAC where acentida = 'ME' )
                  -- asigna los descripciones basicas
                  select @tipmer  = 'TRAN'  -- tipo mercado
                  select @tipope  = 'C'     -- tipo operacion
                  select @codmon  = 'USD'   -- codigo moneda
                  select @codm0nc = 'USD'   -- codigo moneda cnv
   
 update  MEMO set 
                 momonmo                   =   @monto                      
                ,motctra                   =   @observ                     --11
                ,movaluta1                 =   @valuta                     --12
                ,movaluta2                 =   @valuta                     --13
                ,mooper                    =   @operador                   --14
                ,mofech                    =   @fecha                      --15
                ,mohora                    =   @hora                       --16
                ,moterm                    =   @terminal                   --17
                ,swift_corresponsal        =   @corresponsal               --18
--              ,plaza_corresponsal        =   @pl_corresponsal            --19
                ,apoderado_izquierda       =   @apodizq                    --20
                ,apoderado_derecha         =   @apodder                    --21
    where  monumope  =  @numope
         and   motipmer  =  'TRAN'   
                           
 if @@error <> 0      
                  rollback transaction
 if @@error =  0      
                  commit transaction
   
        set nocount off
 select @numope
 return
end 



GO
