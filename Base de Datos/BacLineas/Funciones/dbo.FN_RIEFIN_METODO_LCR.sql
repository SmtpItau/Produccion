USE [BacLineas]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_RIEFIN_METODO_LCR]    Script Date: 13-05-2022 10:35:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[FN_RIEFIN_METODO_LCR]  
(
     @nRutcli numeric(13) -- Cliente Posiblemente modificado
   , @nCodigo numeric(5)
   , @nRutcliAux numeric(13) -- Cliente Original
   , @nCodigoAux numeric(5)
)
RETURNS numeric(5)
As 
Begin
-- select dbo.FN_RIEFIN_METODO_LCR( 5198175, 1, 5198175, 1)
    declare @MetodoLCR numeric(5)
    declare @SegCli    numeric(5)
    declare @SegCliAux varchar(5)
    declare @AuxMetCli Varchar(10)

    -- Si es hijo debe tomar la metodologia del padre
         SELECT @nRutcli      = clrut_padre		
         ,      @nCodigo      = clcodigo_padre
         FROM   BacLineas..CLIENTE_RELACIONADO 
         WHERE  clrut_hijo    = @nRutcli	
         AND    clcodigo_hijo = @nCodigo




	select  @MetodoLCR = convert( numeric(10), ClRecMtdCod )
          , @SegCliAux    = convert( varchar(10), seg_comercial )
            from bacparamsuda..cliente --- select ClRecMtdCod, seg_comercial, * from bacparamsuda..cliente where clrut = 5198175 
    where   ClRut = @nRutcli
        and ClCodigo = @nCodigo

    select @SegCliAux = ltrim(@SegCliAux)
    if len( @SegCliAux ) = 0    
        select  @SegCli = 0
    else 
        select  @SegCli = convert( numeric(5), @SegCliAux )
    if  @MetodoLCR = 0
        select  @MetodoLCR = isnull( ( select RecMtdCod from 
                          BacParamSuda..TBL_SEGMENTOSCOMERCIALES where SgmCod = @SegCli ), 1 )

    -- Si cliente no tiene segmento se asume la metodologia 1. -- SIN NETTIG y SIN TRESHOLD
    if @MetodoLCR = 0  
       select @MetodoLCR = 1
    select @MetodoLCR = isnull(@MetodoLCR, 1 )     
    return @MetodoLCR
End
-- select convert( numeric(5), '0' )
-- select * from bacParamSuda.dbo.TBL_SEGMENTOSCOMERCIALES
GO
