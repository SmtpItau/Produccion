USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_FORWARD_PFE_CCE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_FORWARD_PFE_CCE]( @tipo            char(3)               ,
                                     @rut_cliente     numeric(10)           ,
                                     @codigo_rut      numeric(5)            ,
                                     @moneda          numeric(4)            ,
                                     @precio_fwd      float                 ,
                                     @valor_mercado   float                 ,
                                     @valor_presente  float                 ,
                                     @fecha_inicio    datetime              ,
                                     @fecha_vcto      datetime              ,
                                     @tipo_operacion  char(1)               ,
                                     @monto_pfe       float output          ,
                                     @monto_cce       float output          )
as 
begin
declare @monto_disp_pfe   float    ,
        @monto_disp_cce   float    ,
        @plazo            float    ,
        @volatilidad      float    ,
        @valor_dolar      float    ,
        @valor_uf         float    ,
        @tasa_fwd         float    ,
        @tasa_usd         float    ,
        @bidask           float    ,
        @spread           float    ,
        @precio           float    ,
        @nombre_cliente   char(40) ,
        @peak_pfe         float    ,
        @peak_cce         float
select @nombre_cliente = clnombre 
  from VIEW_CLIENTE  
 where clrut    = @rut_cliente 
   and clcodigo = @codigo_rut 
/* busca limites asociados al cliente ----------------------------------------------- */
select @monto_disp_pfe = monto_asignado - monto_ocupado 
  from MD_PFE_CCE 
 where rut         = @rut_cliente
   and codigo      = @codigo_rut
   and productos   = 'BFW'
   and tipo_limite = 'PFE' 
  
if @@rowcount = 0
begin
   select 1, rtrim(@nombre_cliente ) + ' no tiene definido limite pfe '
   return 0
end
select @monto_disp_pfe = monto_asignado - monto_ocupado 
  from MD_PFE_CCE 
 where rut         = @rut_cliente
   and codigo      = @codigo_rut
   and productos   = 'BFW'
   and tipo_limite = 'CCE' 
if @@rowcount = 0
begin
   select 2, rtrim(@nombre_cliente) + ' no tiene definido limite cce '
   return 0
end
/* calcula pfe y cce para forward --------------------------------------------------- */
if @tipo = 'VAL'
begin
   /* busca valor de uf ------------------------------------------------------------- */
   select @valor_uf = 1.0
   select @valor_uf = isnull(vmvalor, 1.0)
     from VIEW_VALOR_MONEDA
    where vmcodigo = 998  /* uf */
      and vmfecha  = @fecha_inicio
   /* busca dolar interbancario compra o venta -------------------------------------- */
   select @bidask = 1.0
   select @bidask = isnull(vmvalor, 1.0)
     from VIEW_VALOR_MONEDA
    where vmcodigo = (case when @tipo_operacion = 'c' then 500 else 501 end) 
      and vmfecha  = @fecha_inicio
   /* calcula segun moneda del contrato forward ------------------------------------- */
   select @plazo  = datediff(day, @fecha_inicio, @fecha_vcto)
   select @tasa_usd = isnull(libor , 1.0),
          @spread   = isnull(spread, 0.0)
     from VIEW_TASA_FWD
    where @plazo >= plazo_ini
      and @plazo <= plazo_fin
   if @moneda = 999
   begin
      select @tasa_fwd = isnull(clp, 1.0)
        from VIEW_TASA_FWD
       where @plazo >= plazo_ini
         and @plazo <= plazo_fin
      select @precio = @bidask * ((1.0 + (@tasa_fwd / 30.0) * @plazo) / 
                                  (1.0 + (@tasa_usd + @spread / 360.0) * @plazo))
   end
   else
   begin
      select @tasa_fwd = isnull(uf, 1.0)
        from VIEW_TASA_FWD
       where @plazo >= plazo_ini
         and @plazo <= plazo_fin
      select @precio = (@bidask / @valor_uf) * ((1.0 + (@tasa_fwd / 360.0) * @plazo) / 
                        (1.0 + (@tasa_usd + @spread / 360.0) * @plazo))
   end
   select @peak_cce = round(@valor_presente * (@precio_fwd - @precio), 2)
   select @precio = isnull(porcentaje, 0.0)
     from MD_PORC_PFE
    where @plazo >= plazo_ini
      and @plazo <= plazo_fin
   select @peak_pfe = round(@valor_presente * @precio, 2)
   if @monto_pfe > @monto_disp_pfe 
   begin
      select 3, rtrim(@nombre_cliente) + ' sobrepasa limite pfe ' , (@monto_pfe - @monto_disp_pfe ) 
      return 0
   end
  
   if @monto_cce > @monto_disp_cce 
   begin
      select 4, rtrim(@nombre_cliente) + ' sobrepasa limite cce ' , (@monto_cce - @monto_disp_cce ) 
      return 0
   end
end
if @tipo = 'CAR' or @tipo = 'DES'
begin
   if @tipo = 'DES'
   begin 
      select @monto_pfe = @monto_pfe * -1.0
      select @monto_cce = @monto_cce * -1.0
   end
   update MD_PFE_CCE set monto_ocupado = monto_ocupado + @monto_cce
    where rut         = @rut_cliente
      and codigo      = @codigo_rut
      and productos   = 'BFW'
      and tipo_limite = 'CCE' 
   if @@error <> 0
   begin
      select -1, 'falla actualizando limite pfe.'
      return -1
   end
   update MD_PFE_CCE set monto_ocupado = monto_ocupado + @monto_pfe
    where rut         = @rut_cliente
      and codigo      = @codigo_rut
      and productos   = 'BFW'
      and tipo_limite = 'PFE' 
   if @@error <> 0
   begin
      select -1, 'falla actualizando limite cce.'
      return -1
   end
end
select 0
return 0
end   /* fin procedimiento */

GO
