USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCACAPTACION]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCACAPTACION]
     (
     @numoper numeric (10,0)
     )
as
begin
   set nocount on
 declare @sforpai char (25) ,
  @sforpav char (25) ,
  @stipcar char (25) ,
  @nvalmon float  ,
  @ntotmtoini float  ,
  @ntotmtofin float  
 if exists(select *  from GEN_CAPTACION, MDAC where numero_operacion=@numoper and estado=' ' and GEN_CAPTACION.fecha_operacion = MDAC.acfecproc)
 begin        
  
  if exists(select operacion from GEN_OPERACIONES where operacion = @numoper and cerrada = 'S')
  begin 
   
                        set nocount off
                        SELECT 'NO','OPERACI¢N YA ESTA CERRADA. NO PUEDE ANULAR'
                        return
  end
  select 
   @sforpai = glosa
  from 
   GEN_CAPTACION ,
   VIEW_FORMA_DE_PAGO  ,
   MDAC
  where numero_operacion=@numoper 
  and  estado<>'A' 
  and  GEN_CAPTACION.fecha_operacion = MDAC.acfecproc
  and     convert(integer,forma_pago) =  codigo 
  select 
   @ntotmtoini = sum(monto_inicio)  ,
   @ntotmtofin = sum(monto_final) 
  from  
   GEN_CAPTACION  ,
   MDAC
  where 
   numero_operacion = @numoper
  and  estado=' ' 
  and  GEN_CAPTACION.fecha_operacion =  MDAC.acfecproc
  select @sforpav = '',
   @stipcar = '',
   @nvalmon = 1.0
  select 
   @nvalmon = isnull(vmvalor,0)
  from 
   VIEW_VALOR_MONEDA, 
   GEN_CAPTACION
  where 
   numero_operacion=@numoper 
  and (vmcodigo=moneda 
  and  vmfecha=fecha_operacion)   
  and moneda<>999
  select 'tipoper'   = 'CAP'       ,
   'f.emision'   = convert(char(10),fecha_operacion,103)   ,
   'dias'    = convert(char(10),plazo)       ,
   'f.vencimiento'   = convert(char(10),fecha_vencimiento,103)  ,
   'moneda'   = mnnemo      ,
   'base'    = convert(char(3),mnbase)     ,
   'valor moneda'   = convert(char(30),@nvalmon,0)    ,
   'montoinicial'   = @ntotmtoini ,
   'tasa'    = convert(char(20),tasa,7)    ,
   'monto final'   = @ntotmtofin ,
   'rut cartera'   = convert(char(9),entidad)    ,
   'digito_veri'   = rcdv       ,
   'cartera'   = rcnombre      ,
   'tipo cartera'   = @stipcar      ,
   'forma pago inicio'  = @sforpai      ,
   'forma pago vencimiento' = @sforpav      ,
   'tipo retiro'   = retiro      ,
   'tipo pago'   = '' ,
   'rut_cli'   = convert(char(09),rut_cliente)    ,
   'dig_cli'   = convert(char(7),codigo_rut)       ,
   'nombre cliente'  = clnombre
   ,numero_certificado_dcv as 'numeroALTAMIRA'
  from 
   GEN_CAPTACION , 
   VIEW_MONEDA  ,
   VIEW_ENTIDAD  ,
   VIEW_CLIENTE  ,
   MDAC 
  where 
   numero_operacion = @numoper 
  and mncodmon  = moneda 
  and  rcrut   = entidad 
  and  clrut   = rut_cliente 
  and clcodigo   = codigo_rut
  and  estado   = ' ' 
  and  GEN_CAPTACION.fecha_operacion = MDAC.acfecproc
 end
 else
 begin
  set nocount off
         SELECT 'NO','OPERACI¢N NO ES UNA OPERACI¢N DE CAPTACI¢N'
 end
end
GO
